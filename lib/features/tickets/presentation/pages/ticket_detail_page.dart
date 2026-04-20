import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/widgets/detail_top_bar.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:itam_app/features/tickets/presentation/providers/ticket_detail_provider.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_detail/ticket_header_card.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_detail/ticket_asset_section.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_detail/ticket_assignee_section.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_detail/ticket_actions_section.dart';
import 'package:itam_app/core/widgets/action_button.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

class TicketDetailPage extends ConsumerWidget {
  final int ticketId;

  const TicketDetailPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketAsync = ref.watch(ticketDetailProvider(ticketId));
    final authState = ref.watch(authNotifierProvider);
    final isAdmin = authState.user?.role == 'ADMIN';
    final isTech = authState.user?.role == 'TECHNICIAN';

    return Scaffold(
      appBar: DetailTopBar(
        title: 'Fiche ticket',
      ),
      body: ticketAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (ticket) {
          final isClosed = ticket.status == TicketStatus.closed;
          final canEdit = (isAdmin || isTech) && !isClosed;

          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TicketHeaderCard(ticket: ticket),
                const SizedBox(height: 12),
                TicketAssetSection(asset: ticket.asset),
                const SizedBox(height: 12),
                TicketAssigneeSection(
                  assignee: ticket.assignee,
                  canEdit: canEdit && ticket.status != TicketStatus.resolved,
                  ticketId: ticketId,
                ),
                const SizedBox(height: 12),
                TicketActionsSection(
                  ticketId: ticketId,
                  comments: ticket.comments,
                  canEdit: canEdit && ticket.status != TicketStatus.resolved,
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
      extendBody: true,
      bottomNavigationBar: ColoredBox(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ticketAsync.maybeWhen(
              data: (ticket) {
                if (!isAdmin && !isTech) return const SizedBox.shrink(); // ← ajoute ça

                final isResolved = ticket.status == TicketStatus.resolved;
                final isClosed = ticket.status == TicketStatus.closed;
                final hasComments = ticket.comments.isNotEmpty;
                final canResolve = (isAdmin || isTech) &&
                    ticket.status == TicketStatus.inProgress &&
                    hasComments;
                final canReopen = (isAdmin || isTech) && isResolved;

                if (isClosed) return const SizedBox.shrink();

                if (canReopen) {
                  return ActionButton(
                    label: 'Réouvrir le ticket',
                    color: Colors.orange,
                    icon: Icons.refresh_rounded,
                    onPressed: () async {
                      await ref
                          .read(ticketDetailProvider(ticketId).notifier)
                          .reopen();
                    },
                  );
                }

                return ActionButton(
                  label: 'Résolu',
                  color: Colors.green,
                  icon: Icons.check_rounded,
                  onPressed: canResolve
                      ? () async {
                          await ref
                              .read(ticketDetailProvider(ticketId).notifier)
                              .resolve();
                        }
                      : null,
                );
              },
              orElse: () => const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }
}