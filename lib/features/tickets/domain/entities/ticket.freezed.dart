// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TicketUser {
  int get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  /// Create a copy of TicketUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketUserCopyWith<TicketUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketUserCopyWith<$Res> {
  factory $TicketUserCopyWith(
    TicketUser value,
    $Res Function(TicketUser) then,
  ) = _$TicketUserCopyWithImpl<$Res, TicketUser>;
  @useResult
  $Res call({int id, String firstName, String lastName, String? email});
}

/// @nodoc
class _$TicketUserCopyWithImpl<$Res, $Val extends TicketUser>
    implements $TicketUserCopyWith<$Res> {
  _$TicketUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TicketUserImplCopyWith<$Res>
    implements $TicketUserCopyWith<$Res> {
  factory _$$TicketUserImplCopyWith(
    _$TicketUserImpl value,
    $Res Function(_$TicketUserImpl) then,
  ) = __$$TicketUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String firstName, String lastName, String? email});
}

/// @nodoc
class __$$TicketUserImplCopyWithImpl<$Res>
    extends _$TicketUserCopyWithImpl<$Res, _$TicketUserImpl>
    implements _$$TicketUserImplCopyWith<$Res> {
  __$$TicketUserImplCopyWithImpl(
    _$TicketUserImpl _value,
    $Res Function(_$TicketUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? email = freezed,
  }) {
    return _then(
      _$TicketUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$TicketUserImpl implements _TicketUser {
  const _$TicketUserImpl({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
  });

  @override
  final int id;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? email;

  @override
  String toString() {
    return 'TicketUser(id: $id, firstName: $firstName, lastName: $lastName, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName, email);

  /// Create a copy of TicketUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketUserImplCopyWith<_$TicketUserImpl> get copyWith =>
      __$$TicketUserImplCopyWithImpl<_$TicketUserImpl>(this, _$identity);
}

abstract class _TicketUser implements TicketUser {
  const factory _TicketUser({
    required final int id,
    required final String firstName,
    required final String lastName,
    final String? email,
  }) = _$TicketUserImpl;

  @override
  int get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get email;

  /// Create a copy of TicketUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketUserImplCopyWith<_$TicketUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TicketAsset {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  String? get serialNumber => throw _privateConstructorUsedError;

  /// Create a copy of TicketAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketAssetCopyWith<TicketAsset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketAssetCopyWith<$Res> {
  factory $TicketAssetCopyWith(
    TicketAsset value,
    $Res Function(TicketAsset) then,
  ) = _$TicketAssetCopyWithImpl<$Res, TicketAsset>;
  @useResult
  $Res call({
    int id,
    String name,
    String? brand,
    String? model,
    String? serialNumber,
  });
}

/// @nodoc
class _$TicketAssetCopyWithImpl<$Res, $Val extends TicketAsset>
    implements $TicketAssetCopyWith<$Res> {
  _$TicketAssetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brand = freezed,
    Object? model = freezed,
    Object? serialNumber = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            brand: freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String?,
            model: freezed == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
                      as String?,
            serialNumber: freezed == serialNumber
                ? _value.serialNumber
                : serialNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TicketAssetImplCopyWith<$Res>
    implements $TicketAssetCopyWith<$Res> {
  factory _$$TicketAssetImplCopyWith(
    _$TicketAssetImpl value,
    $Res Function(_$TicketAssetImpl) then,
  ) = __$$TicketAssetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? brand,
    String? model,
    String? serialNumber,
  });
}

/// @nodoc
class __$$TicketAssetImplCopyWithImpl<$Res>
    extends _$TicketAssetCopyWithImpl<$Res, _$TicketAssetImpl>
    implements _$$TicketAssetImplCopyWith<$Res> {
  __$$TicketAssetImplCopyWithImpl(
    _$TicketAssetImpl _value,
    $Res Function(_$TicketAssetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brand = freezed,
    Object? model = freezed,
    Object? serialNumber = freezed,
  }) {
    return _then(
      _$TicketAssetImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        brand: freezed == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String?,
        model: freezed == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
                  as String?,
        serialNumber: freezed == serialNumber
            ? _value.serialNumber
            : serialNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$TicketAssetImpl implements _TicketAsset {
  const _$TicketAssetImpl({
    required this.id,
    required this.name,
    this.brand,
    this.model,
    this.serialNumber,
  });

  @override
  final int id;
  @override
  final String name;
  @override
  final String? brand;
  @override
  final String? model;
  @override
  final String? serialNumber;

  @override
  String toString() {
    return 'TicketAsset(id: $id, name: $name, brand: $brand, model: $model, serialNumber: $serialNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketAssetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, brand, model, serialNumber);

  /// Create a copy of TicketAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketAssetImplCopyWith<_$TicketAssetImpl> get copyWith =>
      __$$TicketAssetImplCopyWithImpl<_$TicketAssetImpl>(this, _$identity);
}

abstract class _TicketAsset implements TicketAsset {
  const factory _TicketAsset({
    required final int id,
    required final String name,
    final String? brand,
    final String? model,
    final String? serialNumber,
  }) = _$TicketAssetImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get brand;
  @override
  String? get model;
  @override
  String? get serialNumber;

  /// Create a copy of TicketAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketAssetImplCopyWith<_$TicketAssetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TicketComment {
  int get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  TicketUser get author => throw _privateConstructorUsedError;

  /// Create a copy of TicketComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketCommentCopyWith<TicketComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCommentCopyWith<$Res> {
  factory $TicketCommentCopyWith(
    TicketComment value,
    $Res Function(TicketComment) then,
  ) = _$TicketCommentCopyWithImpl<$Res, TicketComment>;
  @useResult
  $Res call({int id, String content, DateTime createdAt, TicketUser author});

  $TicketUserCopyWith<$Res> get author;
}

/// @nodoc
class _$TicketCommentCopyWithImpl<$Res, $Val extends TicketComment>
    implements $TicketCommentCopyWith<$Res> {
  _$TicketCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? author = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            author: null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as TicketUser,
          )
          as $Val,
    );
  }

  /// Create a copy of TicketComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TicketUserCopyWith<$Res> get author {
    return $TicketUserCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TicketCommentImplCopyWith<$Res>
    implements $TicketCommentCopyWith<$Res> {
  factory _$$TicketCommentImplCopyWith(
    _$TicketCommentImpl value,
    $Res Function(_$TicketCommentImpl) then,
  ) = __$$TicketCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String content, DateTime createdAt, TicketUser author});

  @override
  $TicketUserCopyWith<$Res> get author;
}

/// @nodoc
class __$$TicketCommentImplCopyWithImpl<$Res>
    extends _$TicketCommentCopyWithImpl<$Res, _$TicketCommentImpl>
    implements _$$TicketCommentImplCopyWith<$Res> {
  __$$TicketCommentImplCopyWithImpl(
    _$TicketCommentImpl _value,
    $Res Function(_$TicketCommentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? createdAt = null,
    Object? author = null,
  }) {
    return _then(
      _$TicketCommentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        author: null == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as TicketUser,
      ),
    );
  }
}

/// @nodoc

class _$TicketCommentImpl implements _TicketComment {
  const _$TicketCommentImpl({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.author,
  });

  @override
  final int id;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final TicketUser author;

  @override
  String toString() {
    return 'TicketComment(id: $id, content: $content, createdAt: $createdAt, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.author, author) || other.author == author));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, content, createdAt, author);

  /// Create a copy of TicketComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketCommentImplCopyWith<_$TicketCommentImpl> get copyWith =>
      __$$TicketCommentImplCopyWithImpl<_$TicketCommentImpl>(this, _$identity);
}

abstract class _TicketComment implements TicketComment {
  const factory _TicketComment({
    required final int id,
    required final String content,
    required final DateTime createdAt,
    required final TicketUser author,
  }) = _$TicketCommentImpl;

  @override
  int get id;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  TicketUser get author;

  /// Create a copy of TicketComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketCommentImplCopyWith<_$TicketCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Ticket {
  int get id => throw _privateConstructorUsedError;
  String get reference => throw _privateConstructorUsedError;
  TicketType get type => throw _privateConstructorUsedError;
  TicketStatus get status => throw _privateConstructorUsedError;
  TicketPriority get priority => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get dueDate => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;
  TicketUser get requester => throw _privateConstructorUsedError;
  TicketUser? get assignee => throw _privateConstructorUsedError;
  TicketAsset? get asset => throw _privateConstructorUsedError;
  List<TicketComment> get comments => throw _privateConstructorUsedError;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketCopyWith<Ticket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCopyWith<$Res> {
  factory $TicketCopyWith(Ticket value, $Res Function(Ticket) then) =
      _$TicketCopyWithImpl<$Res, Ticket>;
  @useResult
  $Res call({
    int id,
    String reference,
    TicketType type,
    TicketStatus status,
    TicketPriority priority,
    String title,
    String? description,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? dueDate,
    DateTime? resolvedAt,
    TicketUser requester,
    TicketUser? assignee,
    TicketAsset? asset,
    List<TicketComment> comments,
  });

  $TicketUserCopyWith<$Res> get requester;
  $TicketUserCopyWith<$Res>? get assignee;
  $TicketAssetCopyWith<$Res>? get asset;
}

/// @nodoc
class _$TicketCopyWithImpl<$Res, $Val extends Ticket>
    implements $TicketCopyWith<$Res> {
  _$TicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reference = null,
    Object? type = null,
    Object? status = null,
    Object? priority = null,
    Object? title = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? dueDate = freezed,
    Object? resolvedAt = freezed,
    Object? requester = null,
    Object? assignee = freezed,
    Object? asset = freezed,
    Object? comments = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            reference: null == reference
                ? _value.reference
                : reference // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as TicketType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as TicketStatus,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as TicketPriority,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            dueDate: freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            requester: null == requester
                ? _value.requester
                : requester // ignore: cast_nullable_to_non_nullable
                      as TicketUser,
            assignee: freezed == assignee
                ? _value.assignee
                : assignee // ignore: cast_nullable_to_non_nullable
                      as TicketUser?,
            asset: freezed == asset
                ? _value.asset
                : asset // ignore: cast_nullable_to_non_nullable
                      as TicketAsset?,
            comments: null == comments
                ? _value.comments
                : comments // ignore: cast_nullable_to_non_nullable
                      as List<TicketComment>,
          )
          as $Val,
    );
  }

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TicketUserCopyWith<$Res> get requester {
    return $TicketUserCopyWith<$Res>(_value.requester, (value) {
      return _then(_value.copyWith(requester: value) as $Val);
    });
  }

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TicketUserCopyWith<$Res>? get assignee {
    if (_value.assignee == null) {
      return null;
    }

    return $TicketUserCopyWith<$Res>(_value.assignee!, (value) {
      return _then(_value.copyWith(assignee: value) as $Val);
    });
  }

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TicketAssetCopyWith<$Res>? get asset {
    if (_value.asset == null) {
      return null;
    }

    return $TicketAssetCopyWith<$Res>(_value.asset!, (value) {
      return _then(_value.copyWith(asset: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TicketImplCopyWith<$Res> implements $TicketCopyWith<$Res> {
  factory _$$TicketImplCopyWith(
    _$TicketImpl value,
    $Res Function(_$TicketImpl) then,
  ) = __$$TicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String reference,
    TicketType type,
    TicketStatus status,
    TicketPriority priority,
    String title,
    String? description,
    DateTime createdAt,
    DateTime updatedAt,
    DateTime? dueDate,
    DateTime? resolvedAt,
    TicketUser requester,
    TicketUser? assignee,
    TicketAsset? asset,
    List<TicketComment> comments,
  });

  @override
  $TicketUserCopyWith<$Res> get requester;
  @override
  $TicketUserCopyWith<$Res>? get assignee;
  @override
  $TicketAssetCopyWith<$Res>? get asset;
}

/// @nodoc
class __$$TicketImplCopyWithImpl<$Res>
    extends _$TicketCopyWithImpl<$Res, _$TicketImpl>
    implements _$$TicketImplCopyWith<$Res> {
  __$$TicketImplCopyWithImpl(
    _$TicketImpl _value,
    $Res Function(_$TicketImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reference = null,
    Object? type = null,
    Object? status = null,
    Object? priority = null,
    Object? title = null,
    Object? description = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? dueDate = freezed,
    Object? resolvedAt = freezed,
    Object? requester = null,
    Object? assignee = freezed,
    Object? asset = freezed,
    Object? comments = null,
  }) {
    return _then(
      _$TicketImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        reference: null == reference
            ? _value.reference
            : reference // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as TicketType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as TicketStatus,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as TicketPriority,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        dueDate: freezed == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        requester: null == requester
            ? _value.requester
            : requester // ignore: cast_nullable_to_non_nullable
                  as TicketUser,
        assignee: freezed == assignee
            ? _value.assignee
            : assignee // ignore: cast_nullable_to_non_nullable
                  as TicketUser?,
        asset: freezed == asset
            ? _value.asset
            : asset // ignore: cast_nullable_to_non_nullable
                  as TicketAsset?,
        comments: null == comments
            ? _value._comments
            : comments // ignore: cast_nullable_to_non_nullable
                  as List<TicketComment>,
      ),
    );
  }
}

/// @nodoc

class _$TicketImpl implements _Ticket {
  const _$TicketImpl({
    required this.id,
    required this.reference,
    required this.type,
    required this.status,
    required this.priority,
    required this.title,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.dueDate,
    this.resolvedAt,
    required this.requester,
    this.assignee,
    this.asset,
    required final List<TicketComment> comments,
  }) : _comments = comments;

  @override
  final int id;
  @override
  final String reference;
  @override
  final TicketType type;
  @override
  final TicketStatus status;
  @override
  final TicketPriority priority;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? dueDate;
  @override
  final DateTime? resolvedAt;
  @override
  final TicketUser requester;
  @override
  final TicketUser? assignee;
  @override
  final TicketAsset? asset;
  final List<TicketComment> _comments;
  @override
  List<TicketComment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  String toString() {
    return 'Ticket(id: $id, reference: $reference, type: $type, status: $status, priority: $priority, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, dueDate: $dueDate, resolvedAt: $resolvedAt, requester: $requester, assignee: $assignee, asset: $asset, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt) &&
            (identical(other.requester, requester) ||
                other.requester == requester) &&
            (identical(other.assignee, assignee) ||
                other.assignee == assignee) &&
            (identical(other.asset, asset) || other.asset == asset) &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    reference,
    type,
    status,
    priority,
    title,
    description,
    createdAt,
    updatedAt,
    dueDate,
    resolvedAt,
    requester,
    assignee,
    asset,
    const DeepCollectionEquality().hash(_comments),
  );

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketImplCopyWith<_$TicketImpl> get copyWith =>
      __$$TicketImplCopyWithImpl<_$TicketImpl>(this, _$identity);
}

abstract class _Ticket implements Ticket {
  const factory _Ticket({
    required final int id,
    required final String reference,
    required final TicketType type,
    required final TicketStatus status,
    required final TicketPriority priority,
    required final String title,
    final String? description,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final DateTime? dueDate,
    final DateTime? resolvedAt,
    required final TicketUser requester,
    final TicketUser? assignee,
    final TicketAsset? asset,
    required final List<TicketComment> comments,
  }) = _$TicketImpl;

  @override
  int get id;
  @override
  String get reference;
  @override
  TicketType get type;
  @override
  TicketStatus get status;
  @override
  TicketPriority get priority;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get dueDate;
  @override
  DateTime? get resolvedAt;
  @override
  TicketUser get requester;
  @override
  TicketUser? get assignee;
  @override
  TicketAsset? get asset;
  @override
  List<TicketComment> get comments;

  /// Create a copy of Ticket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketImplCopyWith<_$TicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
