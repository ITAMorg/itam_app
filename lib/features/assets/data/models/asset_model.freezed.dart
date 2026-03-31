// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AssetTypeModel _$AssetTypeModelFromJson(Map<String, dynamic> json) {
  return _AssetTypeModel.fromJson(json);
}

/// @nodoc
mixin _$AssetTypeModel {
  String get name => throw _privateConstructorUsedError;
  String get iconKey => throw _privateConstructorUsedError;
  String get colorKey => throw _privateConstructorUsedError;

  /// Serializes this AssetTypeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssetTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssetTypeModelCopyWith<AssetTypeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetTypeModelCopyWith<$Res> {
  factory $AssetTypeModelCopyWith(
    AssetTypeModel value,
    $Res Function(AssetTypeModel) then,
  ) = _$AssetTypeModelCopyWithImpl<$Res, AssetTypeModel>;
  @useResult
  $Res call({String name, String iconKey, String colorKey});
}

/// @nodoc
class _$AssetTypeModelCopyWithImpl<$Res, $Val extends AssetTypeModel>
    implements $AssetTypeModelCopyWith<$Res> {
  _$AssetTypeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssetTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? iconKey = null,
    Object? colorKey = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            iconKey: null == iconKey
                ? _value.iconKey
                : iconKey // ignore: cast_nullable_to_non_nullable
                      as String,
            colorKey: null == colorKey
                ? _value.colorKey
                : colorKey // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AssetTypeModelImplCopyWith<$Res>
    implements $AssetTypeModelCopyWith<$Res> {
  factory _$$AssetTypeModelImplCopyWith(
    _$AssetTypeModelImpl value,
    $Res Function(_$AssetTypeModelImpl) then,
  ) = __$$AssetTypeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String iconKey, String colorKey});
}

/// @nodoc
class __$$AssetTypeModelImplCopyWithImpl<$Res>
    extends _$AssetTypeModelCopyWithImpl<$Res, _$AssetTypeModelImpl>
    implements _$$AssetTypeModelImplCopyWith<$Res> {
  __$$AssetTypeModelImplCopyWithImpl(
    _$AssetTypeModelImpl _value,
    $Res Function(_$AssetTypeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssetTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? iconKey = null,
    Object? colorKey = null,
  }) {
    return _then(
      _$AssetTypeModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        iconKey: null == iconKey
            ? _value.iconKey
            : iconKey // ignore: cast_nullable_to_non_nullable
                  as String,
        colorKey: null == colorKey
            ? _value.colorKey
            : colorKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetTypeModelImpl implements _AssetTypeModel {
  const _$AssetTypeModelImpl({
    required this.name,
    required this.iconKey,
    required this.colorKey,
  });

  factory _$AssetTypeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetTypeModelImplFromJson(json);

  @override
  final String name;
  @override
  final String iconKey;
  @override
  final String colorKey;

  @override
  String toString() {
    return 'AssetTypeModel(name: $name, iconKey: $iconKey, colorKey: $colorKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetTypeModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconKey, iconKey) || other.iconKey == iconKey) &&
            (identical(other.colorKey, colorKey) ||
                other.colorKey == colorKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, iconKey, colorKey);

  /// Create a copy of AssetTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetTypeModelImplCopyWith<_$AssetTypeModelImpl> get copyWith =>
      __$$AssetTypeModelImplCopyWithImpl<_$AssetTypeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetTypeModelImplToJson(this);
  }
}

abstract class _AssetTypeModel implements AssetTypeModel {
  const factory _AssetTypeModel({
    required final String name,
    required final String iconKey,
    required final String colorKey,
  }) = _$AssetTypeModelImpl;

  factory _AssetTypeModel.fromJson(Map<String, dynamic> json) =
      _$AssetTypeModelImpl.fromJson;

  @override
  String get name;
  @override
  String get iconKey;
  @override
  String get colorKey;

  /// Create a copy of AssetTypeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssetTypeModelImplCopyWith<_$AssetTypeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssetModel _$AssetModelFromJson(Map<String, dynamic> json) {
  return _AssetModel.fromJson(json);
}

/// @nodoc
mixin _$AssetModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get serialNumber => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  AssetTypeModel get assetType => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get purchaseDate => throw _privateConstructorUsedError;
  String? get warrantyEnd => throw _privateConstructorUsedError;

  /// Serializes this AssetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssetModelCopyWith<AssetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetModelCopyWith<$Res> {
  factory $AssetModelCopyWith(
    AssetModel value,
    $Res Function(AssetModel) then,
  ) = _$AssetModelCopyWithImpl<$Res, AssetModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String serialNumber,
    String status,
    AssetTypeModel assetType,
    String location,
    String purchaseDate,
    String? warrantyEnd,
  });

  $AssetTypeModelCopyWith<$Res> get assetType;
}

/// @nodoc
class _$AssetModelCopyWithImpl<$Res, $Val extends AssetModel>
    implements $AssetModelCopyWith<$Res> {
  _$AssetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? serialNumber = null,
    Object? status = null,
    Object? assetType = null,
    Object? location = null,
    Object? purchaseDate = null,
    Object? warrantyEnd = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            serialNumber: null == serialNumber
                ? _value.serialNumber
                : serialNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            assetType: null == assetType
                ? _value.assetType
                : assetType // ignore: cast_nullable_to_non_nullable
                      as AssetTypeModel,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            purchaseDate: null == purchaseDate
                ? _value.purchaseDate
                : purchaseDate // ignore: cast_nullable_to_non_nullable
                      as String,
            warrantyEnd: freezed == warrantyEnd
                ? _value.warrantyEnd
                : warrantyEnd // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of AssetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssetTypeModelCopyWith<$Res> get assetType {
    return $AssetTypeModelCopyWith<$Res>(_value.assetType, (value) {
      return _then(_value.copyWith(assetType: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AssetModelImplCopyWith<$Res>
    implements $AssetModelCopyWith<$Res> {
  factory _$$AssetModelImplCopyWith(
    _$AssetModelImpl value,
    $Res Function(_$AssetModelImpl) then,
  ) = __$$AssetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String serialNumber,
    String status,
    AssetTypeModel assetType,
    String location,
    String purchaseDate,
    String? warrantyEnd,
  });

  @override
  $AssetTypeModelCopyWith<$Res> get assetType;
}

/// @nodoc
class __$$AssetModelImplCopyWithImpl<$Res>
    extends _$AssetModelCopyWithImpl<$Res, _$AssetModelImpl>
    implements _$$AssetModelImplCopyWith<$Res> {
  __$$AssetModelImplCopyWithImpl(
    _$AssetModelImpl _value,
    $Res Function(_$AssetModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? serialNumber = null,
    Object? status = null,
    Object? assetType = null,
    Object? location = null,
    Object? purchaseDate = null,
    Object? warrantyEnd = freezed,
  }) {
    return _then(
      _$AssetModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        serialNumber: null == serialNumber
            ? _value.serialNumber
            : serialNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        assetType: null == assetType
            ? _value.assetType
            : assetType // ignore: cast_nullable_to_non_nullable
                  as AssetTypeModel,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        purchaseDate: null == purchaseDate
            ? _value.purchaseDate
            : purchaseDate // ignore: cast_nullable_to_non_nullable
                  as String,
        warrantyEnd: freezed == warrantyEnd
            ? _value.warrantyEnd
            : warrantyEnd // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetModelImpl implements _AssetModel {
  const _$AssetModelImpl({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.status,
    required this.assetType,
    required this.location,
    required this.purchaseDate,
    this.warrantyEnd,
  });

  factory _$AssetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String serialNumber;
  @override
  final String status;
  @override
  final AssetTypeModel assetType;
  @override
  final String location;
  @override
  final String purchaseDate;
  @override
  final String? warrantyEnd;

  @override
  String toString() {
    return 'AssetModel(id: $id, name: $name, serialNumber: $serialNumber, status: $status, assetType: $assetType, location: $location, purchaseDate: $purchaseDate, warrantyEnd: $warrantyEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.assetType, assetType) ||
                other.assetType == assetType) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.warrantyEnd, warrantyEnd) ||
                other.warrantyEnd == warrantyEnd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    serialNumber,
    status,
    assetType,
    location,
    purchaseDate,
    warrantyEnd,
  );

  /// Create a copy of AssetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetModelImplCopyWith<_$AssetModelImpl> get copyWith =>
      __$$AssetModelImplCopyWithImpl<_$AssetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetModelImplToJson(this);
  }
}

abstract class _AssetModel implements AssetModel {
  const factory _AssetModel({
    required final String id,
    required final String name,
    required final String serialNumber,
    required final String status,
    required final AssetTypeModel assetType,
    required final String location,
    required final String purchaseDate,
    final String? warrantyEnd,
  }) = _$AssetModelImpl;

  factory _AssetModel.fromJson(Map<String, dynamic> json) =
      _$AssetModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get serialNumber;
  @override
  String get status;
  @override
  AssetTypeModel get assetType;
  @override
  String get location;
  @override
  String get purchaseDate;
  @override
  String? get warrantyEnd;

  /// Create a copy of AssetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssetModelImplCopyWith<_$AssetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
