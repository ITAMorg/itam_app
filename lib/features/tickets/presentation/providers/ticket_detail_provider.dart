import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/features/tickets/data/repositories/ticket_repository_impl.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

final ticketDetailProvider = FutureProvider.family<Ticket, int>((ref, id) async {
  final repository = ref.watch(ticketRepositoryProvider);
  return await repository.getTicketById(id);
});