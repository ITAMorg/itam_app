import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

part 'ticket_model.freezed.dart';
part 'ticket_model.g.dart';

@freezed
class TicketUserModel with _$TicketUserModel {
  const factory TicketUserModel({
    required int id,
    required String firstName,
    required String lastName,
    String? email,
  }) = _TicketUserModel;

  factory TicketUserModel.fromJson(Map<String, dynamic> json) =>
      _$TicketUserModelFromJson(json);
}

@freezed
class TicketAssetModel with _$TicketAssetModel {
  const factory TicketAssetModel({
    required int id,
    required String name,
    String? brand,
    String? model,
    String? serialNumber,
    String? iconKey,   // 👈
    String? colorKey,  // 👈
  }) = _TicketAssetModel;

  factory TicketAssetModel.fromJson(Map<String, dynamic> json) =>
      _$TicketAssetModelFromJson(json);
}

@freezed
class TicketCommentModel with _$TicketCommentModel {
  const factory TicketCommentModel({
    required int id,
    required String content,
    required String createdAt,
    required TicketUserModel author,
  }) = _TicketCommentModel;

  factory TicketCommentModel.fromJson(Map<String, dynamic> json) =>
      _$TicketCommentModelFromJson(json);
}

@freezed
class TicketModel with _$TicketModel {
  const factory TicketModel({
    required int id,
    required String reference,
    required String type,
    required String status,
    required String priority,
    required String title,
    String? description,
    required String createdAt,
    required String updatedAt,
    String? dueDate,
    String? resolvedAt,
    required TicketUserModel requester,
    TicketUserModel? assignee,
    TicketAssetModel? asset,
    required List<TicketCommentModel> comments,
  }) = _TicketModel;

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        id: json['id'] as int,
        reference: json['reference'] as String,
        type: json['type'] as String,
        status: json['status'] as String,
        priority: json['priority'] as String,
        title: json['title'] as String,
        description: json['description'] as String?,
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String,
        dueDate: json['dueDate'] as String?,
        resolvedAt: json['resolvedAt'] as String?,
        requester: TicketUserModel.fromJson(
            json['requester'] as Map<String, dynamic>),
        assignee: json['assignee'] != null
            ? TicketUserModel.fromJson(
                json['assignee'] as Map<String, dynamic>)
            : null,
        asset: json['asset'] != null
            ? TicketAssetModel.fromJson(json['asset'] as Map<String, dynamic>)
            : null,
        comments: (json['comments'] as List<dynamic>)
            .map((c) =>
                TicketCommentModel.fromJson(c as Map<String, dynamic>))
            .toList(),
      );
}

extension TicketModelMapper on TicketModel {
  Ticket toEntity() => Ticket(
        id: id,
        reference: reference,
        type: _mapType(type),
        status: _mapStatus(status),
        priority: _mapPriority(priority),
        title: title,
        description: description,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
        dueDate: dueDate != null ? DateTime.parse(dueDate!) : null,
        resolvedAt: resolvedAt != null ? DateTime.parse(resolvedAt!) : null,
        requester: TicketUser(
          id: requester.id,
          firstName: requester.firstName,
          lastName: requester.lastName,
          email: requester.email,
        ),
        assignee: assignee != null
            ? TicketUser(
                id: assignee!.id,
                firstName: assignee!.firstName,
                lastName: assignee!.lastName,
                email: assignee!.email,
              )
            : null,
        asset: asset != null
            ? TicketAsset(
                id: asset!.id,
                name: asset!.name,
                brand: asset!.brand,
                model: asset!.model,
                serialNumber: asset!.serialNumber,
                iconKey: asset!.iconKey,
                colorKey: asset!.colorKey,
              )
            : null,
        comments: comments
            .map((c) => TicketComment(
                  id: c.id,
                  content: c.content,
                  createdAt: DateTime.parse(c.createdAt),
                  author: TicketUser(
                    id: c.author.id,
                    firstName: c.author.firstName,
                    lastName: c.author.lastName,
                  ),
                ))
            .toList(),
      );

  TicketType _mapType(String value) => switch (value) {
        'INCIDENT' => TicketType.incident,
        'REQUEST' => TicketType.request,
        _ => TicketType.incident,
      };

  TicketStatus _mapStatus(String value) => switch (value) {
        'OPEN' => TicketStatus.open,
        'IN_PROGRESS' => TicketStatus.inProgress,
        'RESOLVED' => TicketStatus.resolved,
        'CLOSED' => TicketStatus.closed,
        _ => TicketStatus.open,
      };

  TicketPriority _mapPriority(String value) => switch (value) {
        'LOW' => TicketPriority.low,
        'MEDIUM' => TicketPriority.medium,
        'HIGH' => TicketPriority.high,
        _ => TicketPriority.medium,
      };
}