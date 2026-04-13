import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

class TicketAssigneeSection extends StatelessWidget {
  final TicketUser? assignee;
  final bool canEdit;

  const TicketAssigneeSection({
    super.key,
    required this.assignee,
    required this.canEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              'TECHNICIEN ASSIGNÉ',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          // Contenu
          Padding(
            padding: const EdgeInsets.all(12),
            child: assignee == null
                ? Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.border.withValues(alpha: 0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_outline_rounded,
                          color: AppColors.textSecondary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Non assigné',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.textSecondary),
                        ),
                      ),
                      if (canEdit)
                        GestureDetector(
                          onTap: () {
                            // TODO: assigner un technicien
                          },
                          child: Text(
                            'Assigner',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: AppColors.primary),
                          ),
                        ),
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.5)),
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${assignee!.firstName} ${assignee!.lastName}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            if (assignee!.email != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                assignee!.email!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.textSecondary),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (canEdit)
                        GestureDetector(
                          onTap: () {
                            // TODO: réassigner
                          },
                          child: Text(
                            'Réassigner',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: AppColors.primary),
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}