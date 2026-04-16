import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:itam_app/features/tickets/data/repositories/ticket_repository_impl.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

part 'ticket_detail_provider.g.dart';

@riverpod
class TicketDetail extends _$TicketDetail {
  @override
  Future<Ticket> build(int ticketId) async {
    final repository = ref.watch(ticketRepositoryProvider);
    return await repository.getTicketById(ticketId);
  }

  Future<void> assignTechnician(int? assigneeId) async {
    final repository = ref.read(ticketRepositoryProvider);
    await repository.assignTechnician(ticketId, assigneeId);
    ref.invalidateSelf();
    await future;
  }

  Future<void> addComment(String content) async {
    final repository = ref.read(ticketRepositoryProvider);
    await repository.addComment(ticketId, content);
    // Recharge le ticket complet pour avoir les nouveaux comments + statut à jour
    ref.invalidateSelf();
    await future;
  }

  Future<void> resolve() async {
    final repository = ref.read(ticketRepositoryProvider);
    await repository.updateTicketStatus(ticketId, 'RESOLVED');
    ref.invalidateSelf();
    await future;
  }
}