import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

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
      onTap: () {
        // TODO: navigation vers le détail ticket
        // context.push('/tickets/${ticket.id}');
      },
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
            // Barre colorée gauche
            Container(
              width: 4,
              height: 72,
              decoration: BoxDecoration(
                color: priorityColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Contenu
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
                        // Badge statut
                        _Badge(
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
                        // Badge priorité
                        _Badge(
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

class _Badge extends StatelessWidget {
  final String label;
  final Color color;

  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(color: color),
      ),
    );
  }
}