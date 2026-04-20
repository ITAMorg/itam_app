import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/core/widgets/status_chip.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';
import 'package:go_router/go_router.dart';
import 'package:itam_app/core/widgets/priority_chip.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;

  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final priorityColor = _priorityColor(ticket.priority);
    final statusLabel = _statusLabel(ticket.status);
    final statusColor = _statusColor(ticket.status);
    final priorityLabel = _priorityLabel(ticket.priority);

    return GestureDetector(
      onTap: () => context.push('/tickets/${ticket.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.border.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: Container(
                width: 4,
                height: 52,
                decoration: BoxDecoration(
                  color: priorityColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            ticket.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        StatusChip(
                          label: statusLabel,
                          color: statusColor,
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            ticket.asset?.name ?? 'Aucun asset',
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        PriorityChip(
                          label: priorityLabel,
                          color: priorityColor,
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _priorityColor(TicketPriority priority) => switch (priority) {
        TicketPriority.low => const Color(0xFF2E7D32),
        TicketPriority.medium => const Color(0xFFDD862E),
        TicketPriority.high => const Color(0xFFEF4444),
      };

  String _priorityLabel(TicketPriority priority) => switch (priority) {
        TicketPriority.low => 'Faible',
        TicketPriority.medium => 'Moyenne',
        TicketPriority.high => 'Haute',
      };

  Color _statusColor(TicketStatus status) => switch (status) {
        TicketStatus.open => const Color(0xFF3B82F6),
        TicketStatus.inProgress => const Color(0xFFDD862E),
        TicketStatus.resolved => const Color(0xFF2E7D32),
        TicketStatus.closed => const Color(0xFF6B7280),
      };

  String _statusLabel(TicketStatus status) => switch (status) {
        TicketStatus.open => 'Ouvert',
        TicketStatus.inProgress => 'En cours',
        TicketStatus.resolved => 'Résolu',
        TicketStatus.closed => 'Fermé',
      };
}