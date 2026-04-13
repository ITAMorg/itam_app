import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/widgets/detail_top_bar.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:itam_app/features/tickets/presentation/providers/ticket_detail_provider.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_header_card.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_asset_section.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_assignee_section.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_actions_section.dart';
import 'package:itam_app/core/widgets/action_button.dart';

class TicketDetailPage extends ConsumerWidget {
  final int ticketId;

  const TicketDetailPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketAsync = ref.watch(ticketDetailProvider(ticketId));
    final authState = ref.watch(authNotifierProvider);
    final isAdmin = authState.user?.role == 'ADMIN';
    final isTech = authState.user?.role == 'TECHNICIAN';
    final canEdit = isAdmin || isTech;

    return Scaffold(
      appBar: DetailTopBar(
        title: 'Fiche ticket',
        onEdit: canEdit ? () {
          // TODO: navigation vers page édition
        } : null,
        onDelete: isAdmin ? () {
          // TODO: dialog confirmation suppression
        } : null,
      ),
      body: ticketAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (ticket) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TicketHeaderCard(ticket: ticket),
              const SizedBox(height: 12),
              TicketAssetSection(asset: ticket.asset),
              const SizedBox(height: 12),
              TicketAssigneeSection(
                assignee: ticket.assignee,
                canEdit: canEdit,
              ),
              const SizedBox(height: 12),
              TicketActionsSection(
                comments: ticket.comments,
                canEdit: canEdit,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: ColoredBox(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ticketAsync.maybeWhen(
              data: (ticket) => ActionButton(
                label: 'Résolu',
                color: Colors.green,
                icon: Icons.check_rounded,
                // onPressed: ticket.status == TicketStatus.resolved ||
                //         ticket.status == TicketStatus.closed
                //     ? null
                //     : canEdit
                //         ? () {
                //             // TODO: PATCH /tickets/:id status RESOLVED
                //           }
                //         : null,
              ),
              orElse: () => const SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );
  }
}