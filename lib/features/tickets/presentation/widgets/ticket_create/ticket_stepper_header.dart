import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';

class TicketStepperHeader extends StatelessWidget {
  final int currentStep;
  final List<String> stepLabels;

  const TicketStepperHeader({
    super.key,
    required this.currentStep,
    required this.stepLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(stepLabels.length, (index) {
              final isActive = index <= currentStep;
              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(right: 4),
                  height: 3,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(
            'Étape ${currentStep + 1} sur ${stepLabels.length} — ${stepLabels[currentStep]}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}