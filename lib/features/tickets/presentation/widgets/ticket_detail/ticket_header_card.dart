import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/core/widgets/priority_chip.dart';
import 'package:itam_app/core/widgets/status_chip.dart';
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
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.border.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  ticket.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Priorité',
                    style: AppTextStyles.labelSection,
                  ),
                  const SizedBox(height: 4),
                  PriorityChip(label: priorityLabel, color: priorityColor),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (ticket.description != null) ...[
            Text(
              ticket.description!,
              style: AppTextStyles.labelSection,
            ),
            const SizedBox(height: 16),
          ],
          Row(
            children: [
              StatusChip(label: statusLabel, color: statusColor),
              const SizedBox(width: 12),
              Text(
                'Ouvert depuis le ${_formatDate(ticket.createdAt)}',
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
      };

  String _priorityLabel(TicketPriority priority) => switch (priority) {
        TicketPriority.low => 'Faible',
        TicketPriority.medium => 'Moyenne',
        TicketPriority.high => 'Haute',
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