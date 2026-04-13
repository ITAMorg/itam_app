import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../datasources/ticket_remote_datasource.dart';
import '../models/ticket_model.dart';

part 'ticket_repository_impl.g.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource _datasource;

  const TicketRepositoryImpl(this._datasource);

  @override
  Future<List<Ticket>> getTickets() async {
    final models = await _datasource.getTickets();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Ticket> getTicketById(int id) async {
    final model = await _datasource.getTicketById(id);
    return model.toEntity();
  }

  @override
  Future<Ticket> createTicket(Map<String, dynamic> body) async {
    final model = await _datasource.createTicket(body);
    return model.toEntity();
  }
}

@riverpod
TicketRepository ticketRepository(Ref ref) {
  return TicketRepositoryImpl(ref.watch(ticketRemoteDataSourceProvider));
}