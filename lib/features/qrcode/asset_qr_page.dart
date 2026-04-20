import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:itam_app/core/widgets/detail_top_bar.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/core/network/dio_client.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';
import 'package:itam_app/features/assets/presentation/widgets/asset_card.dart';

class AssetQrCodePage extends ConsumerStatefulWidget {
  final String assetId;
  final Asset asset;

  const AssetQrCodePage({
    super.key,
    required this.assetId,
    required this.asset,
  });

  @override
  ConsumerState<AssetQrCodePage> createState() => _AssetQrCodePageState();
}

class _AssetQrCodePageState extends ConsumerState<AssetQrCodePage> {
  Uint8List? _qrBytes;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchQrCode();
  }

  Future<void> _fetchQrCode() async {
    try {
      final dio = ref.read(dioClientProvider);
      final response = await dio.get(
        '/assets/${widget.assetId}/qrcode',
        options: Options(responseType: ResponseType.bytes),
      );
      setState(() {
        _qrBytes = Uint8List.fromList(response.data);
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Impossible de charger le QR code';
        _loading = false;
      });
    }
  }

  Future<void> _save() async {
    if (_qrBytes == null) return;
    if (Platform.isWindows) {
      final dir = await getDownloadsDirectory();
      final file = File('${dir!.path}/qrcode_asset_${widget.assetId}.png');
      await file.writeAsBytes(_qrBytes!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QR code enregistré dans ${file.path}')),
        );
      }
    } else {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/qrcode_asset_${widget.assetId}.png');
      await file.writeAsBytes(_qrBytes!);
      await Gal.putImage(file.path);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR code enregistré dans la galerie')),
        );
      }
    }
  }

  Future<void> _share() async {
    if (_qrBytes == null) return;
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/qrcode_asset_${widget.assetId}.png');
    await file.writeAsBytes(_qrBytes!);
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'QR Code — Asset #${widget.assetId}',
    );
  }

  Future<void> _print() async {
    if (_qrBytes == null) return;
    await Printing.layoutPdf(
      onLayout: (_) async {
        final doc = pw.Document();
        final image = pw.MemoryImage(_qrBytes!);
        doc.addPage(
          pw.Page(
            build: (_) => pw.Center(
              child: pw.Image(image, width: 200, height: 200),
            ),
          ),
        );
        return doc.save();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailTopBar(title: 'QR Code'),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AssetCard(asset: widget.asset, onTap: () {}),
                      const SizedBox(height: 32),
                      _buildQrCard(),
                      const SizedBox(height: 32),
                      _buildActions(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildQrCard() {
    return Container(
      width: 275,
      height: 275,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Image.memory(_qrBytes!, width: 220, height: 220),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionBtn(
          icon: Icons.download_rounded,
          label: 'Enregistrer',
          onTap: _save,
        ),
        if (!Platform.isWindows) ...[
          const SizedBox(width: 16),
          _ActionBtn(
            icon: Icons.share_rounded,
            label: 'Partager',
            onTap: _share,
          ),
        ],
        const SizedBox(width: 16),
        _ActionBtn(
          icon: Icons.print_rounded,
          label: 'Imprimer',
          onTap: _print,
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.border.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(height: 6),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}