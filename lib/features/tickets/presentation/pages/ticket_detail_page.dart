import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/widgets/detail_top_bar.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:itam_app/features/tickets/presentation/providers/ticket_detail_provider.dart';

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
              Text(ticket.title), // placeholder
            ],
          ),
        ),
      ),
    );
  }
}