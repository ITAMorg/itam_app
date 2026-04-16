import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:itam_app/features/auth/presentation/providers/technician_provider.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';
import 'package:itam_app/features/tickets/presentation/providers/ticket_detail_provider.dart';

class TicketAssigneeSection extends ConsumerStatefulWidget {
  final TicketUser? assignee;
  final bool canEdit;
  final int ticketId;

  const TicketAssigneeSection({
    super.key,
    required this.assignee,
    required this.canEdit,
    required this.ticketId,
  });

  @override
  ConsumerState<TicketAssigneeSection> createState() =>
      _TicketAssigneeSectionState();
}

class _TicketAssigneeSectionState extends ConsumerState<TicketAssigneeSection> {
  bool _isSelecting = false;
  bool _isLoading = false;

  Future<void> _assign(TechnicianModel tech) async {
    setState(() => _isLoading = true);
    try {
      final assigneeId = tech.id == -1 ? null : tech.id;
      await ref
          .read(ticketDetailProvider(widget.ticketId).notifier)
          .assignTechnician(assigneeId);
      if (mounted) setState(() => _isSelecting = false);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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

          // Assignee actuel
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: widget.assignee != null
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : AppColors.border.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                    border: widget.assignee != null
                        ? Border.all(
                            color: AppColors.primary.withValues(alpha: 0.5))
                        : null,
                  ),
                  child: Icon(
                    widget.assignee != null
                        ? Icons.person_rounded
                        : Icons.person_outline_rounded,
                    color: widget.assignee != null
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: widget.assignee != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.assignee!.firstName} ${widget.assignee!.lastName}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            if (widget.assignee!.email != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                widget.assignee!.email!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: AppColors.textSecondary),
                              ),
                            ],
                          ],
                        )
                      : Text(
                          'Non assigné',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.textSecondary),
                        ),
                ),
                if (widget.canEdit && !_isLoading)
                  GestureDetector(
                    onTap: () => setState(() => _isSelecting = !_isSelecting),
                    child: Text(
                      widget.assignee != null ? 'Réassigner' : 'Assigner',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.blue),
                    ),
                  ),
                if (_isLoading)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
          ),

          // Dropdown inline
          if (_isSelecting) ...[
            const Divider(height: 1, color: AppColors.border),
            ref.watch(technicianListProvider).when(
                  loading: () => const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (e, _) => Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Erreur : $e'),
                  ),
                  data: (technicians) => Column(
                    children: [
                      // Option "Désassigner"
                      if (widget.assignee != null)
                        _buildTechTile(
                          context,
                          label: 'Retirer l\'assignation',
                          subtitle: null,
                          icon: Icons.person_remove_rounded,
                          color: Colors.red,
                          onTap: () => _assign(
                            TechnicianModel(
                              id: -1,
                              firstName: '',
                              lastName: '',
                              email: '',
                            ),
                          ),
                        ),
                      ...technicians.map(
                        (tech) => _buildTechTile(
                          context,
                          label: '${tech.firstName} ${tech.lastName}',
                          subtitle: tech.email,
                          icon: Icons.person_rounded,
                          color: AppColors.primary,
                          onTap: () => _assign(tech),
                          isSelected: widget.assignee?.id == tech.id,
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ],
      ),
    );
  }

  Widget _buildTechTile(
    BuildContext context, {
    required String label,
    required String? subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.08) : null,
          border: Border(
            top: BorderSide(
                color: AppColors.border.withValues(alpha: 0.15), width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: Theme.of(context).textTheme.bodyMedium),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.textSecondary),
                    ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_rounded,
                  color: AppColors.primary, size: 18),
          ],
        ),
      ),
    );
  }
}