import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/core/widgets/detail_top_bar.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_create/ticket_stepper_header.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_create/ticket_bottom_button.dart';

class CreateTicketPage extends StatefulWidget {
  final int? assetId;

  const CreateTicketPage({super.key, this.assetId});

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  late int _currentStep;
  late final PageController _pageController;

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
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
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

  void _onSubmit() {
    // TODO: soumettre le ticket
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
                _buildPlaceholderStep('Matériel concerné'),
                _buildPlaceholderStep("Détails de l'incident"),
                _buildPlaceholderStep('Priorité & confirmation'),
              ],
            ),
          ),
          TicketBottomButton(
            isFirstStep: isFirstStep,
            isLastStep: isLastStep,
            onNext: _nextStep,
            onPrevious: _previousStep,
            onSubmit: _onSubmit,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderStep(String label) {
    return Center(
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
      ),
    );
  }
}