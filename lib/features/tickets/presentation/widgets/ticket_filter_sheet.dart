import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

class TicketFilterSheet extends StatefulWidget {
  final TicketStatus? initialStatus;
  final TicketPriority? initialPriority;

  const TicketFilterSheet({
    super.key,
    this.initialStatus,
    this.initialPriority,
  });

  @override
  State<TicketFilterSheet> createState() => _TicketFilterSheetState();
}

class _TicketFilterSheetState extends State<TicketFilterSheet> {
  TicketStatus? _status;
  TicketPriority? _priority;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
    _priority = widget.initialPriority;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Row(
            children: [
              Text('Filtres', style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              if (_status != null || _priority != null)
                GestureDetector(
                  onTap: () => setState(() {
                    _status = null;
                    _priority = null;
                  }),
                  child: Text(
                    'Réinitialiser',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.primary),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),

          // Statut
          Text(
            'STATUT',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
          ),
          const SizedBox(height: 10),
          _buildStatusOptions(),
          const SizedBox(height: 20),

          // Priorité
          Text(
            'PRIORITÉ',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
          ),
          const SizedBox(height: 10),
          _buildPriorityOptions(),
          const SizedBox(height: 24),

          // Bouton appliquer
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop({
                'status': _status,
                'priority': _priority,
              }),
              child: const Text('Appliquer'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOptions() {
    final options = [
      (TicketStatus.open, 'Ouvert', Colors.red),
      (TicketStatus.inProgress, 'En cours', Colors.orange),
      (TicketStatus.resolved, 'Résolu', Colors.green),
      (TicketStatus.closed, 'Fermé', AppColors.textSecondary),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final (status, label, color) = opt;
        final selected = _status == status;
        return GestureDetector(
          onTap: () => setState(() => _status = selected ? null : status),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: selected
                  ? color.withValues(alpha: 0.2)
                  : AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected
                    ? color
                    : AppColors.border.withValues(alpha: 0.3),
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: selected ? color : AppColors.textSecondary,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriorityOptions() {
    final options = [
      (TicketPriority.low, 'Basse', Colors.green),
      (TicketPriority.medium, 'Moyenne', Colors.orange),
      (TicketPriority.high, 'Haute', Colors.red),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final (priority, label, color) = opt;
        final selected = _priority == priority;
        return GestureDetector(
          onTap: () =>
              setState(() => _priority = selected ? null : priority),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: selected
                  ? color.withValues(alpha: 0.2)
                  : AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected
                    ? color
                    : AppColors.border.withValues(alpha: 0.3),
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: selected ? color : AppColors.textSecondary,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}