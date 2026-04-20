import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';

class AssetHistorySection extends StatelessWidget {
  final Asset asset;

  const AssetHistorySection({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    final tickets = asset.tickets;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Text(
              'HISTORIQUE DES TICKETS',
              style: AppTextStyles.titleSection,
            ),
          ),
          _Divider(),
          if (tickets.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors.textSecondary.withValues(alpha: 0.4),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Aucun ticket pour ce matériel',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary.withValues(alpha: 0.4),
                        ),
                  ),
                ],
              ),
            )
          else
            Column(
              children: [
                for (int i = 0; i < tickets.length; i++) ...[
                  _TicketHistoryItem(ticket: tickets[i]),
                  if (i < tickets.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.border.withValues(alpha: 0.15),
                    ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

class _TicketHistoryItem extends StatelessWidget {
  final TicketSummary ticket;

  const _TicketHistoryItem({required this.ticket});

  Color _priorityColor(String priority) => switch (priority) {
        'LOW' => const Color(0xFF22C55E),
        'MEDIUM' => const Color(0xFFF59E0B),
        'HIGH' => const Color(0xFFEF4444),
        _ => AppColors.textSecondary,
      };

  String _formatDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/tickets/${ticket.id}'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 36,
              decoration: BoxDecoration(
                color: _priorityColor(ticket.priority),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.title,
                    style: AppTextStyles.bodySection,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatDate(ticket.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _StatusBadge(status: ticket.status),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      'OPEN' => ('Ouvert', const Color(0xFF1D4ED8)),
      'IN_PROGRESS' => ('En cours', Colors.orange),
      'RESOLVED' => ('Résolu', Colors.green),
      'CLOSED' => ('Fermé', AppColors.textSecondary),
      _ => (status, AppColors.textSecondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.border.withValues(alpha: 0.15),
    );
  }
}