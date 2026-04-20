import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

class TicketFilterSheet extends StatefulWidget {
  final Set<TicketStatus> initialStatuses;
  final Set<TicketPriority> initialPriorities;

  const TicketFilterSheet({
    super.key,
    this.initialStatuses = const {},
    this.initialPriorities = const {},
  });

  @override
  State<TicketFilterSheet> createState() => _TicketFilterSheetState();
}

class _TicketFilterSheetState extends State<TicketFilterSheet> {
  late Set<TicketStatus> _statuses;
  late Set<TicketPriority> _priorities;

  @override
  void initState() {
    super.initState();
    _statuses = Set.from(widget.initialStatuses);
    _priorities = Set.from(widget.initialPriorities);
  }

  bool get _hasFilters => _statuses.isNotEmpty || _priorities.isNotEmpty;

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
          Row(
            children: [
              Text('Filtres', style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              if (_hasFilters)
                GestureDetector(
                  onTap: () => setState(() {
                    _statuses.clear();
                    _priorities.clear();
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop({
                'statuses': _statuses.toList(),
                'priorities': _priorities.toList(),
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
      (TicketStatus.open, 'Ouvert', AppColors.primary),
      (TicketStatus.inProgress, 'En cours', Colors.orange),
      (TicketStatus.resolved, 'Résolu', Colors.green),
      (TicketStatus.closed, 'Fermé', AppColors.textSecondary),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final (status, label, color) = opt;
        final selected = _statuses.contains(status);
        return GestureDetector(
          onTap: () => setState(() {
            selected ? _statuses.remove(status) : _statuses.add(status);
          }),
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
      (TicketPriority.low, 'Faible', Colors.green),
      (TicketPriority.medium, 'Moyenne', Colors.orange),
      (TicketPriority.high, 'Haute', Colors.red),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final (priority, label, color) = opt;
        final selected = _priorities.contains(priority);
        return GestureDetector(
          onTap: () => setState(() {
            selected
                ? _priorities.remove(priority)
                : _priorities.add(priority);
          }),
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