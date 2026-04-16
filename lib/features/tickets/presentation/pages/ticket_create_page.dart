import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:itam_app/features/tickets/domain/usecases/create_ticket_usecase.dart';
import 'package:itam_app/core/widgets/detail_top_bar.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';
import 'package:itam_app/features/assets/presentation/providers/assets_provider.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_create/ticket_stepper_header.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_create/ticket_bottom_button.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_create/ticket_step1.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_create/ticket_step2.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_create/ticket_step3.dart';

class _TicketFormData {
  Asset? asset;
  String? title;
  String? description;
  String? priority;

  Map<String, dynamic> toJson() => {
        'assetId': int.parse(asset!.id),
        'title': title,
        'description': description,
        'priority': priority,
        'type': 'INCIDENT',
      };
}

class CreateTicketPage extends ConsumerStatefulWidget {
  final int? assetId;

  const CreateTicketPage({super.key, this.assetId});

  @override
  ConsumerState<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends ConsumerState<CreateTicketPage> {
  late int _currentStep;
  late final PageController _pageController;
  final _formData = _TicketFormData();

  final List<String> _stepLabels = [
    'Matériel concerné',
    "Détails de l'incident",
    'Priorité & confirmation',
  ];

  @override
  void initState() {
    super.initState();
    _currentStep = widget.assetId != null ? 1 : 0;
    _pageController = PageController(initialPage: _currentStep);

    // Pré-sélection de l'asset si assetId fourni
    if (widget.assetId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final assetsAsync = ref.read(assetsProvider);
        assetsAsync.whenData((assets) {
          final match = assets.where(
            (a) => a.id == widget.assetId.toString(),
          ).firstOrNull;
          if (match != null) {
            setState(() => _formData.asset = match);
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _formData.asset != null;
      case 1:
        return (_formData.title?.trim().isNotEmpty ?? false) &&
            (_formData.description?.trim().isNotEmpty ?? false);
      case 2:
        return _formData.priority != null;
      default:
        return false;
    }
  }

  void _nextStep() {
    if (!_canProceed()) return;
    if (_currentStep < 2) {
      setState(() => _currentStep++);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _onSubmit() async {
    if (!_canProceed()) return;

    final authState = ref.read(authNotifierProvider);
    final user = authState.user;
    if (user == null) return;

    final body = {
      ..._formData.toJson(),
      if (user.role == 'TECHNICIAN') 'assigneeId': user.id,
    };

    try {
      final ticket = await ref.read(createTicketUseCaseProvider).execute(body);
      if (mounted) context.pushReplacement('/tickets/${ticket.id}');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur : $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastStep = _currentStep == 2;
    final isFirstStep = _currentStep == 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DetailTopBar(title: 'Nouveau ticket'),
      body: Column(
        children: [
          TicketStepperHeader(
            currentStep: _currentStep,
            stepLabels: _stepLabels,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TicketAssetSection(
                  preselectedAssetId: widget.assetId,
                  onAssetSelected: (asset) {
                    setState(() => _formData.asset = asset);
                  },
                ),
                TicketActionsSection(
                  selectedAsset: _formData.asset,
                  initialTitle: _formData.title,
                  initialDescription: _formData.description,
                  onTitleChanged: (v) => setState(() => _formData.title = v),
                  onDescriptionChanged: (v) => setState(() => _formData.description = v),
                ),
                TicketAssigneeSection(
                  selectedAsset: _formData.asset,
                  title: _formData.title,
                  description: _formData.description,
                  selectedPriority: _formData.priority,
                  onPriorityChanged: (v) => setState(() => _formData.priority = v),
                ),
              ],
            ),
          ),
          TicketBottomButton(
            isFirstStep: isFirstStep,
            isLastStep: isLastStep,
            canProceed: _canProceed(),
            onNext: _nextStep,
            onPrevious: _previousStep,
            onSubmit: _onSubmit,
          ),
        ],
      ),
    );
  }
}