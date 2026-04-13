// lib/features/tickets/presentation/widgets/ticket_hero_card.dart

import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

class TicketHeaderCard extends StatelessWidget {
  final Ticket ticket;

  const TicketHeaderCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final priorityColor = _priorityColor(ticket.priority);
    final priorityLabel = _priorityLabel(ticket.priority);
    final statusColor = _statusColor(ticket.status);
    final statusLabel = _statusLabel(ticket.status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre + badge priorité
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  ticket.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Priorité',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: priorityColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: priorityColor),
                    ),
                    child: Text(
                      priorityLabel,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: priorityColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Description
          if (ticket.description != null) ...[
            Text(
              ticket.description!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 16),
          ],
          // Statut + date
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      statusLabel,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: statusColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _formatDate(ticket.createdAt),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Color _priorityColor(TicketPriority priority) => switch (priority) {
        TicketPriority.low => const Color(0xFF22C55E),
        TicketPriority.medium => const Color(0xFFF59E0B),
        TicketPriority.high => const Color(0xFFEF4444),
        TicketPriority.critical => const Color(0xFF7C3AED),
      };

  String _priorityLabel(TicketPriority priority) => switch (priority) {
        TicketPriority.low => 'Faible',
        TicketPriority.medium => 'Moyenne',
        TicketPriority.high => 'Haute',
        TicketPriority.critical => 'Critique',
      };

  Color _statusColor(TicketStatus status) => switch (status) {
        TicketStatus.open => const Color(0xFF3B82F6),
        TicketStatus.inProgress => const Color(0xFFF59E0B),
        TicketStatus.resolved => const Color(0xFF22C55E),
        TicketStatus.closed => const Color(0xFF6B7280),
      };

  String _statusLabel(TicketStatus status) => switch (status) {
        TicketStatus.open => 'Ouvert',
        TicketStatus.inProgress => 'En cours',
        TicketStatus.resolved => 'Résolu',
        TicketStatus.closed => 'Fermé',
      };
}