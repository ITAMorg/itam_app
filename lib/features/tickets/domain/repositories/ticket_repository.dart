import '../entities/ticket.dart';

abstract class TicketRepository {
  Future<List<Ticket>> getTickets();
  Future<Ticket> getTicketById(int id);
  Future<Ticket> createTicket(Map<String, dynamic> body);
  Future<void> addComment(int ticketId, String content);
  Future<Ticket> updateTicketStatus(int ticketId, String status);
}