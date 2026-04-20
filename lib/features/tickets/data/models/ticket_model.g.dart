// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketUserModelImpl _$$TicketUserModelImplFromJson(
  Map<String, dynamic> json,
) => _$TicketUserModelImpl(
  id: (json['id'] as num).toInt(),
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String?,
);

Map<String, dynamic> _$$TicketUserModelImplToJson(
  _$TicketUserModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
};

_$TicketAssetModelImpl _$$TicketAssetModelImplFromJson(
  Map<String, dynamic> json,
) => _$TicketAssetModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  brand: json['brand'] as String?,
  model: json['model'] as String?,
  serialNumber: json['serialNumber'] as String?,
  iconKey: json['iconKey'] as String?,
  colorKey: json['colorKey'] as String?,
);

Map<String, dynamic> _$$TicketAssetModelImplToJson(
  _$TicketAssetModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'brand': instance.brand,
  'model': instance.model,
  'serialNumber': instance.serialNumber,
  'iconKey': instance.iconKey,
  'colorKey': instance.colorKey,
};

_$TicketCommentModelImpl _$$TicketCommentModelImplFromJson(
  Map<String, dynamic> json,
) => _$TicketCommentModelImpl(
  id: (json['id'] as num).toInt(),
  content: json['content'] as String,
  createdAt: json['createdAt'] as String,
  author: TicketUserModel.fromJson(json['author'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$TicketCommentModelImplToJson(
  _$TicketCommentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'createdAt': instance.createdAt,
  'author': instance.author,
};

_$TicketModelImpl _$$TicketModelImplFromJson(Map<String, dynamic> json) =>
    _$TicketModelImpl(
      id: (json['id'] as num).toInt(),
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
        json['requester'] as Map<String, dynamic>,
      ),
      assignee: json['assignee'] == null
          ? null
          : TicketUserModel.fromJson(json['assignee'] as Map<String, dynamic>),
      asset: json['asset'] == null
          ? null
          : TicketAssetModel.fromJson(json['asset'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>)
          .map((e) => TicketCommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TicketModelImplToJson(_$TicketModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reference': instance.reference,
      'type': instance.type,
      'status': instance.status,
      'priority': instance.priority,
      'title': instance.title,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'dueDate': instance.dueDate,
      'resolvedAt': instance.resolvedAt,
      'requester': instance.requester,
      'assignee': instance.assignee,
      'asset': instance.asset,
      'comments': instance.comments,
    };
