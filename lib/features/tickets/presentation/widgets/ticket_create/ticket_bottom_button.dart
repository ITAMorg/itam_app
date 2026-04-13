import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';

class TicketBottomButton extends StatelessWidget {
  final bool isFirstStep;
  final bool isLastStep;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;

  const TicketBottomButton({
    super.key,
    required this.isFirstStep,
    required this.isLastStep,
    required this.onNext,
    required this.onPrevious,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Row(
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            child: isFirstStep
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      GestureDetector(
                        onTap: onPrevious,
                        child: Container(
                          width: 48,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.textPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: isLastStep ? onSubmit : onNext,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                height: 52,
                decoration: BoxDecoration(
                  color: isLastStep ? Colors.green : AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        isLastStep ? 'Enregistrer' : 'Continuer',
                        key: ValueKey(isLastStep),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        isLastStep ? Icons.check_rounded : Icons.arrow_forward_rounded,
                        key: ValueKey(isLastStep),
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}