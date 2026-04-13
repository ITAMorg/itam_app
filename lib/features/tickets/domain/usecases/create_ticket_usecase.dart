import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../entities/ticket.dart';
import '../repositories/ticket_repository.dart';
import '../../data/repositories/ticket_repository_impl.dart';

part 'create_ticket_usecase.g.dart';

class CreateTicketUseCase {
  final TicketRepository _repository;

  const CreateTicketUseCase(this._repository);

  Future<Ticket> execute(Map<String, dynamic> body) {
    return _repository.createTicket(body);
  }
}

@riverpod
CreateTicketUseCase createTicketUseCase(Ref ref) {
  return CreateTicketUseCase(ref.watch(ticketRepositoryProvider));
}