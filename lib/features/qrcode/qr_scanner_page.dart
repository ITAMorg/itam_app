import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:itam_app/core/constants/api_constants.dart';
import 'package:itam_app/core/widgets/detail_top_bar.dart';
import 'package:itam_app/core/theme/app_theme.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController _controller = MobileScannerController();
  bool _handled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleBarcode(String raw) {
    if (_handled) return;
    _handled = true;

    final uri = Uri.tryParse(raw);
    if (uri != null && uri.scheme == 'itam' && uri.host == 'assets') {
      final assetId = uri.pathSegments.firstOrNull;
      if (assetId != null) {
        context.pushReplacement('/assets/$assetId');
        return;
      }
    }

    // Format non reconnu
    setState(() => _handled = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('QR code non reconnu')),
    );
  }

  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final result = await _controller.analyzeImage(picked.path);
    if (result == null || result.barcodes.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aucun QR code détecté dans l\'image')),
        );
      }
      return;
    }

    final raw = result.barcodes.first.rawValue;
    if (raw != null && mounted) _handleBarcode(raw);
  }

  Future<void> _pickFromFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );
    if (result == null || result.files.single.bytes == null) return;

    try {
      final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
      final token = await const FlutterSecureStorage().read(key: 'access_token');
      
      final formData = FormData.fromMap({
        'image': MultipartFile.fromBytes(
          result.files.single.bytes!,
          filename: result.files.single.name,
          contentType: DioMediaType('image', 'png'),
        ),
      });

      final response = await dio.post(
        '/assets/scan',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final assetId = response.data['assetId'];
      if (assetId != null && mounted) {
        context.pushReplacement('/assets/$assetId');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR code non reconnu')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWindows = Platform.isWindows;

    return Scaffold(
      appBar: DetailTopBar(title: 'Scanner un QR code'),
      body: isWindows ? _buildWindowsUI() : _buildMobileUI(),
    );
  }

  Widget _buildMobileUI() {
    return Stack(
      children: [
        // Caméra plein écran
        MobileScanner(
          controller: _controller,
          onDetect: (capture) {
            final raw = capture.barcodes.first.rawValue;
            if (raw != null) _handleBarcode(raw);
          },
        ),
        // Overlay visée
        Center(
          child: Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        // Bouton galerie en bas
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: _pickFromGallery,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.border.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.photo_library_rounded, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Importer depuis la galerie',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWindowsUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code_scanner_rounded,
            size: 80,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 24),
          Text(
            'Importer une image contenant un QR code',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          GestureDetector(
            onTap: _pickFromFile,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.upload_file_rounded, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    'Choisir une image',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}