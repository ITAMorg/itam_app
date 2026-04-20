import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';

enum TicketStatus { open, inProgress, resolved, closed }

enum TicketPriority { low, medium, high }

enum TicketType { incident, request }

@freezed
abstract class TicketUser with _$TicketUser {
  const factory TicketUser({
    required int id,
    required String firstName,
    required String lastName,
    String? email,
  }) = _TicketUser;
}

@freezed
abstract class TicketAsset with _$TicketAsset {
  const factory TicketAsset({
    required int id,
    required String name,
    String? brand,
    String? model,
    String? serialNumber,
    String? iconKey,
    String? colorKey,
  }) = _TicketAsset;
}

@freezed
abstract class TicketComment with _$TicketComment {
  const factory TicketComment({
    required int id,
    required String content,
    required DateTime createdAt,
    required TicketUser author,
  }) = _TicketComment;
}

@freezed
abstract class Ticket with _$Ticket {
  const factory Ticket({
    required int id,
    required String reference,
    required TicketType type,
    required TicketStatus status,
    required TicketPriority priority,
    required String title,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? dueDate,
    DateTime? resolvedAt,
    required TicketUser requester,
    TicketUser? assignee,
    TicketAsset? asset,
    required List<TicketComment> comments,
  }) = _Ticket;
}