import '../entities/ticket.dart';

abstract class TicketRepository {
  Future<List<Ticket>> getTickets();
  Future<Ticket> getTicketById(int id);
  Future<Ticket> createTicket(Map<String, dynamic> body);
}