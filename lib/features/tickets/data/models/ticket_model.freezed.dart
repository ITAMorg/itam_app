// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TicketUserModel _$TicketUserModelFromJson(Map<String, dynamic> json) {
  return _TicketUserModel.fromJson(json);
}

/// @nodoc
mixin _$TicketUserModel {
  int get id => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  /// Serializes this TicketUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketUserModelCopyWith<TicketUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketUserModelCopyWith<$Res> {
  factory $TicketUserModelCopyWith(
    TicketUserModel value,
    $Res Function(TicketUserModel) then,
  ) = _$TicketUserModelCopyWithImpl<$Res, TicketUserModel>;
  @useResult
  $Res call({int id, String firstName, String lastName, String? email});
}

/// @nodoc
class _$TicketUserModelCopyWithImpl<$Res, $Val extends TicketUserModel>
    implements $TicketUserModelCopyWith<$Res> {
  _$TicketUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketUserModel
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
abstract class _$$TicketUserModelImplCopyWith<$Res>
    implements $TicketUserModelCopyWith<$Res> {
  factory _$$TicketUserModelImplCopyWith(
    _$TicketUserModelImpl value,
    $Res Function(_$TicketUserModelImpl) then,
  ) = __$$TicketUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String firstName, String lastName, String? email});
}

/// @nodoc
class __$$TicketUserModelImplCopyWithImpl<$Res>
    extends _$TicketUserModelCopyWithImpl<$Res, _$TicketUserModelImpl>
    implements _$$TicketUserModelImplCopyWith<$Res> {
  __$$TicketUserModelImplCopyWithImpl(
    _$TicketUserModelImpl _value,
    $Res Function(_$TicketUserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketUserModel
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
      _$TicketUserModelImpl(
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
@JsonSerializable()
class _$TicketUserModelImpl implements _TicketUserModel {
  const _$TicketUserModelImpl({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
  });

  factory _$TicketUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketUserModelImplFromJson(json);

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
    return 'TicketUserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, firstName, lastName, email);

  /// Create a copy of TicketUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketUserModelImplCopyWith<_$TicketUserModelImpl> get copyWith =>
      __$$TicketUserModelImplCopyWithImpl<_$TicketUserModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketUserModelImplToJson(this);
  }
}

abstract class _TicketUserModel implements TicketUserModel {
  const factory _TicketUserModel({
    required final int id,
    required final String firstName,
    required final String lastName,
    final String? email,
  }) = _$TicketUserModelImpl;

  factory _TicketUserModel.fromJson(Map<String, dynamic> json) =
      _$TicketUserModelImpl.fromJson;

  @override
  int get id;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get email;

  /// Create a copy of TicketUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketUserModelImplCopyWith<_$TicketUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TicketAssetModel _$TicketAssetModelFromJson(Map<String, dynamic> json) {
  return _TicketAssetModel.fromJson(json);
}

/// @nodoc
mixin _$TicketAssetModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  String? get serialNumber => throw _privateConstructorUsedError;
  String? get iconKey => throw _privateConstructorUsedError; // 👈
  String? get colorKey => throw _privateConstructorUsedError;

  /// Serializes this TicketAssetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketAssetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketAssetModelCopyWith<TicketAssetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketAssetModelCopyWith<$Res> {
  factory $TicketAssetModelCopyWith(
    TicketAssetModel value,
    $Res Function(TicketAssetModel) then,
  ) = _$TicketAssetModelCopyWithImpl<$Res, TicketAssetModel>;
  @useResult
  $Res call({
    int id,
    String name,
    String? brand,
    String? model,
    String? serialNumber,
    String? iconKey,
    String? colorKey,
  });
}

/// @nodoc
class _$TicketAssetModelCopyWithImpl<$Res, $Val extends TicketAssetModel>
    implements $TicketAssetModelCopyWith<$Res> {
  _$TicketAssetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketAssetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brand = freezed,
    Object? model = freezed,
    Object? serialNumber = freezed,
    Object? iconKey = freezed,
    Object? colorKey = freezed,
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
            iconKey: freezed == iconKey
                ? _value.iconKey
                : iconKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            colorKey: freezed == colorKey
                ? _value.colorKey
                : colorKey // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TicketAssetModelImplCopyWith<$Res>
    implements $TicketAssetModelCopyWith<$Res> {
  factory _$$TicketAssetModelImplCopyWith(
    _$TicketAssetModelImpl value,
    $Res Function(_$TicketAssetModelImpl) then,
  ) = __$$TicketAssetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? brand,
    String? model,
    String? serialNumber,
    String? iconKey,
    String? colorKey,
  });
}

/// @nodoc
class __$$TicketAssetModelImplCopyWithImpl<$Res>
    extends _$TicketAssetModelCopyWithImpl<$Res, _$TicketAssetModelImpl>
    implements _$$TicketAssetModelImplCopyWith<$Res> {
  __$$TicketAssetModelImplCopyWithImpl(
    _$TicketAssetModelImpl _value,
    $Res Function(_$TicketAssetModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketAssetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brand = freezed,
    Object? model = freezed,
    Object? serialNumber = freezed,
    Object? iconKey = freezed,
    Object? colorKey = freezed,
  }) {
    return _then(
      _$TicketAssetModelImpl(
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
        iconKey: freezed == iconKey
            ? _value.iconKey
            : iconKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        colorKey: freezed == colorKey
            ? _value.colorKey
            : colorKey // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketAssetModelImpl implements _TicketAssetModel {
  const _$TicketAssetModelImpl({
    required this.id,
    required this.name,
    this.brand,
    this.model,
    this.serialNumber,
    this.iconKey,
    this.colorKey,
  });

  factory _$TicketAssetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketAssetModelImplFromJson(json);

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
  final String? iconKey;
  // 👈
  @override
  final String? colorKey;

  @override
  String toString() {
    return 'TicketAssetModel(id: $id, name: $name, brand: $brand, model: $model, serialNumber: $serialNumber, iconKey: $iconKey, colorKey: $colorKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketAssetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.iconKey, iconKey) || other.iconKey == iconKey) &&
            (identical(other.colorKey, colorKey) ||
                other.colorKey == colorKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    brand,
    model,
    serialNumber,
    iconKey,
    colorKey,
  );

  /// Create a copy of TicketAssetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketAssetModelImplCopyWith<_$TicketAssetModelImpl> get copyWith =>
      __$$TicketAssetModelImplCopyWithImpl<_$TicketAssetModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketAssetModelImplToJson(this);
  }
}

abstract class _TicketAssetModel implements TicketAssetModel {
  const factory _TicketAssetModel({
    required final int id,
    required final String name,
    final String? brand,
    final String? model,
    final String? serialNumber,
    final String? iconKey,
    final String? colorKey,
  }) = _$TicketAssetModelImpl;

  factory _TicketAssetModel.fromJson(Map<String, dynamic> json) =
      _$TicketAssetModelImpl.fromJson;

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
  @override
  String? get iconKey; // 👈
  @override
  String? get colorKey;

  /// Create a copy of TicketAssetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketAssetModelImplCopyWith<_$TicketAssetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TicketCommentModel _$TicketCommentModelFromJson(Map<String, dynamic> json) {
  return _TicketCommentModel.fromJson(json);
}

/// @nodoc
mixin _$TicketCommentModel {
  int get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  TicketUserModel get author => throw _privateConstructorUsedError;

  /// Serializes this TicketCommentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketCommentModelCopyWith<TicketCommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCommentModelCopyWith<$Res> {
  factory $TicketCommentModelCopyWith(
    TicketCommentModel value,
    $Res Function(TicketCommentModel) then,
  ) = _$TicketCommentModelCopyWithImpl<$Res, TicketCommentModel>;
  @useResult
  $Res call({int id, String content, String createdAt, TicketUserModel author});

  $TicketUserModelCopyWith<$Res> get author;
}

/// @nodoc
class _$TicketCommentModelCopyWithImpl<$Res, $Val extends TicketCommentModel>
    implements $TicketCommentModelCopyWith<$Res> {
  _$TicketCommentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketCommentModel
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
                      as String,
            author: null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as TicketUserModel,
          )
          as $Val,
    );
  }

  /// Create a copy of TicketCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TicketUserModelCopyWith<$Res> get author {
    return $TicketUserModelCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TicketCommentModelImplCopyWith<$Res>
    implements $TicketCommentModelCopyWith<$Res> {
  factory _$$TicketCommentModelImplCopyWith(
    _$TicketCommentModelImpl value,
    $Res Function(_$TicketCommentModelImpl) then,
  ) = __$$TicketCommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String content, String createdAt, TicketUserModel author});

  @override
  $TicketUserModelCopyWith<$Res> get author;
}

/// @nodoc
class __$$TicketCommentModelImplCopyWithImpl<$Res>
    extends _$TicketCommentModelCopyWithImpl<$Res, _$TicketCommentModelImpl>
    implements _$$TicketCommentModelImplCopyWith<$Res> {
  __$$TicketCommentModelImplCopyWithImpl(
    _$TicketCommentModelImpl _value,
    $Res Function(_$TicketCommentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketCommentModel
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
      _$TicketCommentModelImpl(
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
                  as String,
        author: null == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as TicketUserModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketCommentModelImpl implements _TicketCommentModel {
  const _$TicketCommentModelImpl({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.author,
  });

  factory _$TicketCommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketCommentModelImplFromJson(json);

  @override
  final int id;
  @override
  final String content;
  @override
  final String createdAt;
  @override
  final TicketUserModel author;

  @override
  String toString() {
    return 'TicketCommentModel(id: $id, content: $content, createdAt: $createdAt, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketCommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, content, createdAt, author);

  /// Create a copy of TicketCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketCommentModelImplCopyWith<_$TicketCommentModelImpl> get copyWith =>
      __$$TicketCommentModelImplCopyWithImpl<_$TicketCommentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketCommentModelImplToJson(this);
  }
}

abstract class _TicketCommentModel implements TicketCommentModel {
  const factory _TicketCommentModel({
    required final int id,
    required final String content,
    required final String createdAt,
    required final TicketUserModel author,
  }) = _$TicketCommentModelImpl;

  factory _TicketCommentModel.fromJson(Map<String, dynamic> json) =
      _$TicketCommentModelImpl.fromJson;

  @override
  int get id;
  @override
  String get content;
  @override
  String get createdAt;
  @override
  TicketUserModel get author;

  /// Create a copy of TicketCommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketCommentModelImplCopyWith<_$TicketCommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) {
  return _TicketModel.fromJson(json);
}

/// @nodoc
mixin _$TicketModel {
  int get id => throw _privateConstructorUsedError;
  String get reference => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  String? get dueDate => throw _privateConstructorUsedError;
  String? get resolvedAt => throw _privateConstructorUsedError;
  TicketUserModel get requester => throw _privateConstructorUsedError;
  TicketUserModel? get assignee => throw _privateConstructorUsedError;
  TicketAssetModel? get asset => throw _privateConstructorUsedError;
  List<TicketCommentModel> get comments => throw _privateConstructorUsedError;

  /// Serializes this TicketModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketModelCopyWith<TicketModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketModelCopyWith<$Res> {
  factory $TicketModelCopyWith(
    TicketModel value,
    $Res Function(TicketModel) then,
  ) = _$TicketModelCopyWithImpl<$Res, TicketModel>;
  @useResult
  $Res call({
    int id,
    String reference,
    String type,
    String status,
    String priority,
    String title,
    String? description,
    String createdAt,
    String updatedAt,
    String? dueDate,
    String? resolvedAt,
    TicketUserModel requester,
    TicketUserModel? assignee,
    TicketAssetModel? asset,
    List<TicketCommentModel> comments,
  });

  $TicketUserModelCopyWith<$Res> get requester;
  $TicketUserModelCopyWith<$Res>? get assignee;
  $TicketAssetModelCopyWith<$Res>? get asset;
}

/// @nodoc
class _$TicketModelCopyWithImpl<$Res, $Val extends TicketModel>
    implements $TicketModelCopyWith<$Res> {
  _$TicketModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketModel
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
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as String,
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
                      as String,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            dueDate: freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            resolvedAt: freezed == resolvedAt
                ? _value.resolvedAt
                : resolvedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            requester: null == requester
                ? _value.requester
                : requester // ignore: cast_nullable_to_non_nullable
                      as TicketUserModel,
            assignee: freezed == assignee
                ? _value.assignee
                : assignee // ignore: cast_nullable_to_non_nullable
                      as TicketUserModel?,
            asset: freezed == asset
                ? _value.asset
                : asset // ignore: cast_nullable_to_non_nullable
                      as TicketAssetModel?,
            comments: null == comments
                ? _value.comments
                : comments // ignore: cast_nullable_to_non_nullable
                      as List<TicketCommentModel>,
          )
          as $Val,
    );
  }

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TicketUserModelCopyWith<$Res> get requester {
    return $TicketUserModelCopyWith<$Res>(_value.requester, (value) {
      return _then(_value.copyWith(requester: value) as $Val);
    });
  }

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TicketUserModelCopyWith<$Res>? get assignee {
    if (_value.assignee == null) {
      return null;
    }

    return $TicketUserModelCopyWith<$Res>(_value.assignee!, (value) {
      return _then(_value.copyWith(assignee: value) as $Val);
    });
  }

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TicketAssetModelCopyWith<$Res>? get asset {
    if (_value.asset == null) {
      return null;
    }

    return $TicketAssetModelCopyWith<$Res>(_value.asset!, (value) {
      return _then(_value.copyWith(asset: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TicketModelImplCopyWith<$Res>
    implements $TicketModelCopyWith<$Res> {
  factory _$$TicketModelImplCopyWith(
    _$TicketModelImpl value,
    $Res Function(_$TicketModelImpl) then,
  ) = __$$TicketModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String reference,
    String type,
    String status,
    String priority,
    String title,
    String? description,
    String createdAt,
    String updatedAt,
    String? dueDate,
    String? resolvedAt,
    TicketUserModel requester,
    TicketUserModel? assignee,
    TicketAssetModel? asset,
    List<TicketCommentModel> comments,
  });

  @override
  $TicketUserModelCopyWith<$Res> get requester;
  @override
  $TicketUserModelCopyWith<$Res>? get assignee;
  @override
  $TicketAssetModelCopyWith<$Res>? get asset;
}

/// @nodoc
class __$$TicketModelImplCopyWithImpl<$Res>
    extends _$TicketModelCopyWithImpl<$Res, _$TicketModelImpl>
    implements _$$TicketModelImplCopyWith<$Res> {
  __$$TicketModelImplCopyWithImpl(
    _$TicketModelImpl _value,
    $Res Function(_$TicketModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketModel
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
      _$TicketModelImpl(
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
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as String,
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
                  as String,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        dueDate: freezed == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        resolvedAt: freezed == resolvedAt
            ? _value.resolvedAt
            : resolvedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        requester: null == requester
            ? _value.requester
            : requester // ignore: cast_nullable_to_non_nullable
                  as TicketUserModel,
        assignee: freezed == assignee
            ? _value.assignee
            : assignee // ignore: cast_nullable_to_non_nullable
                  as TicketUserModel?,
        asset: freezed == asset
            ? _value.asset
            : asset // ignore: cast_nullable_to_non_nullable
                  as TicketAssetModel?,
        comments: null == comments
            ? _value._comments
            : comments // ignore: cast_nullable_to_non_nullable
                  as List<TicketCommentModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketModelImpl implements _TicketModel {
  const _$TicketModelImpl({
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
    required final List<TicketCommentModel> comments,
  }) : _comments = comments;

  factory _$TicketModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketModelImplFromJson(json);

  @override
  final int id;
  @override
  final String reference;
  @override
  final String type;
  @override
  final String status;
  @override
  final String priority;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final String? dueDate;
  @override
  final String? resolvedAt;
  @override
  final TicketUserModel requester;
  @override
  final TicketUserModel? assignee;
  @override
  final TicketAssetModel? asset;
  final List<TicketCommentModel> _comments;
  @override
  List<TicketCommentModel> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  String toString() {
    return 'TicketModel(id: $id, reference: $reference, type: $type, status: $status, priority: $priority, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, dueDate: $dueDate, resolvedAt: $resolvedAt, requester: $requester, assignee: $assignee, asset: $asset, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketModelImplCopyWith<_$TicketModelImpl> get copyWith =>
      __$$TicketModelImplCopyWithImpl<_$TicketModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketModelImplToJson(this);
  }
}

abstract class _TicketModel implements TicketModel {
  const factory _TicketModel({
    required final int id,
    required final String reference,
    required final String type,
    required final String status,
    required final String priority,
    required final String title,
    final String? description,
    required final String createdAt,
    required final String updatedAt,
    final String? dueDate,
    final String? resolvedAt,
    required final TicketUserModel requester,
    final TicketUserModel? assignee,
    final TicketAssetModel? asset,
    required final List<TicketCommentModel> comments,
  }) = _$TicketModelImpl;

  factory _TicketModel.fromJson(Map<String, dynamic> json) =
      _$TicketModelImpl.fromJson;

  @override
  int get id;
  @override
  String get reference;
  @override
  String get type;
  @override
  String get status;
  @override
  String get priority;
  @override
  String get title;
  @override
  String? get description;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  String? get dueDate;
  @override
  String? get resolvedAt;
  @override
  TicketUserModel get requester;
  @override
  TicketUserModel? get assignee;
  @override
  TicketAssetModel? get asset;
  @override
  List<TicketCommentModel> get comments;

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketModelImplCopyWith<_$TicketModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
