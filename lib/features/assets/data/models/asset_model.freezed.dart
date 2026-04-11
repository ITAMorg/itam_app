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
  int get id => throw _privateConstructorUsedError;
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
  $Res call({int id, String name, String iconKey, String colorKey});
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
    Object? id = null,
    Object? name = null,
    Object? iconKey = null,
    Object? colorKey = null,
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
  $Res call({int id, String name, String iconKey, String colorKey});
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
    Object? id = null,
    Object? name = null,
    Object? iconKey = null,
    Object? colorKey = null,
  }) {
    return _then(
      _$AssetTypeModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
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
    required this.id,
    required this.name,
    required this.iconKey,
    required this.colorKey,
  });

  factory _$AssetTypeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetTypeModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String iconKey;
  @override
  final String colorKey;

  @override
  String toString() {
    return 'AssetTypeModel(id: $id, name: $name, iconKey: $iconKey, colorKey: $colorKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetTypeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.iconKey, iconKey) || other.iconKey == iconKey) &&
            (identical(other.colorKey, colorKey) ||
                other.colorKey == colorKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, iconKey, colorKey);

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
    required final int id,
    required final String name,
    required final String iconKey,
    required final String colorKey,
  }) = _$AssetTypeModelImpl;

  factory _AssetTypeModel.fromJson(Map<String, dynamic> json) =
      _$AssetTypeModelImpl.fromJson;

  @override
  int get id;
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

AssetLocationModel _$AssetLocationModelFromJson(Map<String, dynamic> json) {
  return _AssetLocationModel.fromJson(json);
}

/// @nodoc
mixin _$AssetLocationModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this AssetLocationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssetLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssetLocationModelCopyWith<AssetLocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetLocationModelCopyWith<$Res> {
  factory $AssetLocationModelCopyWith(
    AssetLocationModel value,
    $Res Function(AssetLocationModel) then,
  ) = _$AssetLocationModelCopyWithImpl<$Res, AssetLocationModel>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$AssetLocationModelCopyWithImpl<$Res, $Val extends AssetLocationModel>
    implements $AssetLocationModelCopyWith<$Res> {
  _$AssetLocationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssetLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AssetLocationModelImplCopyWith<$Res>
    implements $AssetLocationModelCopyWith<$Res> {
  factory _$$AssetLocationModelImplCopyWith(
    _$AssetLocationModelImpl value,
    $Res Function(_$AssetLocationModelImpl) then,
  ) = __$$AssetLocationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$AssetLocationModelImplCopyWithImpl<$Res>
    extends _$AssetLocationModelCopyWithImpl<$Res, _$AssetLocationModelImpl>
    implements _$$AssetLocationModelImplCopyWith<$Res> {
  __$$AssetLocationModelImplCopyWithImpl(
    _$AssetLocationModelImpl _value,
    $Res Function(_$AssetLocationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssetLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$AssetLocationModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetLocationModelImpl implements _AssetLocationModel {
  const _$AssetLocationModelImpl({required this.id, required this.name});

  factory _$AssetLocationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetLocationModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'AssetLocationModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetLocationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of AssetLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetLocationModelImplCopyWith<_$AssetLocationModelImpl> get copyWith =>
      __$$AssetLocationModelImplCopyWithImpl<_$AssetLocationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetLocationModelImplToJson(this);
  }
}

abstract class _AssetLocationModel implements AssetLocationModel {
  const factory _AssetLocationModel({
    required final int id,
    required final String name,
  }) = _$AssetLocationModelImpl;

  factory _AssetLocationModel.fromJson(Map<String, dynamic> json) =
      _$AssetLocationModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of AssetLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssetLocationModelImplCopyWith<_$AssetLocationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssetSupplierModel _$AssetSupplierModelFromJson(Map<String, dynamic> json) {
  return _AssetSupplierModel.fromJson(json);
}

/// @nodoc
mixin _$AssetSupplierModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this AssetSupplierModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssetSupplierModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssetSupplierModelCopyWith<AssetSupplierModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetSupplierModelCopyWith<$Res> {
  factory $AssetSupplierModelCopyWith(
    AssetSupplierModel value,
    $Res Function(AssetSupplierModel) then,
  ) = _$AssetSupplierModelCopyWithImpl<$Res, AssetSupplierModel>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$AssetSupplierModelCopyWithImpl<$Res, $Val extends AssetSupplierModel>
    implements $AssetSupplierModelCopyWith<$Res> {
  _$AssetSupplierModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssetSupplierModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AssetSupplierModelImplCopyWith<$Res>
    implements $AssetSupplierModelCopyWith<$Res> {
  factory _$$AssetSupplierModelImplCopyWith(
    _$AssetSupplierModelImpl value,
    $Res Function(_$AssetSupplierModelImpl) then,
  ) = __$$AssetSupplierModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$AssetSupplierModelImplCopyWithImpl<$Res>
    extends _$AssetSupplierModelCopyWithImpl<$Res, _$AssetSupplierModelImpl>
    implements _$$AssetSupplierModelImplCopyWith<$Res> {
  __$$AssetSupplierModelImplCopyWithImpl(
    _$AssetSupplierModelImpl _value,
    $Res Function(_$AssetSupplierModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssetSupplierModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$AssetSupplierModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetSupplierModelImpl implements _AssetSupplierModel {
  const _$AssetSupplierModelImpl({required this.id, required this.name});

  factory _$AssetSupplierModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetSupplierModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'AssetSupplierModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetSupplierModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of AssetSupplierModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetSupplierModelImplCopyWith<_$AssetSupplierModelImpl> get copyWith =>
      __$$AssetSupplierModelImplCopyWithImpl<_$AssetSupplierModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetSupplierModelImplToJson(this);
  }
}

abstract class _AssetSupplierModel implements AssetSupplierModel {
  const factory _AssetSupplierModel({
    required final int id,
    required final String name,
  }) = _$AssetSupplierModelImpl;

  factory _AssetSupplierModel.fromJson(Map<String, dynamic> json) =
      _$AssetSupplierModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of AssetSupplierModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssetSupplierModelImplCopyWith<_$AssetSupplierModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssetModel _$AssetModelFromJson(Map<String, dynamic> json) {
  return _AssetModel.fromJson(json);
}

/// @nodoc
mixin _$AssetModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get serialNumber => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  AssetTypeModel get assetType => throw _privateConstructorUsedError;
  AssetLocationModel? get location => throw _privateConstructorUsedError;
  AssetSupplierModel? get supplier => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
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
    int id,
    String name,
    String serialNumber,
    String status,
    @JsonKey(name: 'type') AssetTypeModel assetType,
    AssetLocationModel? location,
    AssetSupplierModel? supplier,
    String? brand,
    String? model,
    String purchaseDate,
    String? warrantyEnd,
  });

  $AssetTypeModelCopyWith<$Res> get assetType;
  $AssetLocationModelCopyWith<$Res>? get location;
  $AssetSupplierModelCopyWith<$Res>? get supplier;
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
    Object? location = freezed,
    Object? supplier = freezed,
    Object? brand = freezed,
    Object? model = freezed,
    Object? purchaseDate = null,
    Object? warrantyEnd = freezed,
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
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as AssetLocationModel?,
            supplier: freezed == supplier
                ? _value.supplier
                : supplier // ignore: cast_nullable_to_non_nullable
                      as AssetSupplierModel?,
            brand: freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String?,
            model: freezed == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
                      as String?,
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

  /// Create a copy of AssetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssetLocationModelCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $AssetLocationModelCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of AssetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssetSupplierModelCopyWith<$Res>? get supplier {
    if (_value.supplier == null) {
      return null;
    }

    return $AssetSupplierModelCopyWith<$Res>(_value.supplier!, (value) {
      return _then(_value.copyWith(supplier: value) as $Val);
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
    int id,
    String name,
    String serialNumber,
    String status,
    @JsonKey(name: 'type') AssetTypeModel assetType,
    AssetLocationModel? location,
    AssetSupplierModel? supplier,
    String? brand,
    String? model,
    String purchaseDate,
    String? warrantyEnd,
  });

  @override
  $AssetTypeModelCopyWith<$Res> get assetType;
  @override
  $AssetLocationModelCopyWith<$Res>? get location;
  @override
  $AssetSupplierModelCopyWith<$Res>? get supplier;
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
    Object? location = freezed,
    Object? supplier = freezed,
    Object? brand = freezed,
    Object? model = freezed,
    Object? purchaseDate = null,
    Object? warrantyEnd = freezed,
  }) {
    return _then(
      _$AssetModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
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
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as AssetLocationModel?,
        supplier: freezed == supplier
            ? _value.supplier
            : supplier // ignore: cast_nullable_to_non_nullable
                  as AssetSupplierModel?,
        brand: freezed == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String?,
        model: freezed == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
                  as String?,
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
    @JsonKey(name: 'type') required this.assetType,
    this.location,
    this.supplier,
    this.brand,
    this.model,
    required this.purchaseDate,
    this.warrantyEnd,
  });

  factory _$AssetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String serialNumber;
  @override
  final String status;
  @override
  @JsonKey(name: 'type')
  final AssetTypeModel assetType;
  @override
  final AssetLocationModel? location;
  @override
  final AssetSupplierModel? supplier;
  @override
  final String? brand;
  @override
  final String? model;
  @override
  final String purchaseDate;
  @override
  final String? warrantyEnd;

  @override
  String toString() {
    return 'AssetModel(id: $id, name: $name, serialNumber: $serialNumber, status: $status, assetType: $assetType, location: $location, supplier: $supplier, brand: $brand, model: $model, purchaseDate: $purchaseDate, warrantyEnd: $warrantyEnd)';
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
            (identical(other.supplier, supplier) ||
                other.supplier == supplier) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.model, model) || other.model == model) &&
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
    supplier,
    brand,
    model,
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
    required final int id,
    required final String name,
    required final String serialNumber,
    required final String status,
    @JsonKey(name: 'type') required final AssetTypeModel assetType,
    final AssetLocationModel? location,
    final AssetSupplierModel? supplier,
    final String? brand,
    final String? model,
    required final String purchaseDate,
    final String? warrantyEnd,
  }) = _$AssetModelImpl;

  factory _AssetModel.fromJson(Map<String, dynamic> json) =
      _$AssetModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get serialNumber;
  @override
  String get status;
  @override
  @JsonKey(name: 'type')
  AssetTypeModel get assetType;
  @override
  AssetLocationModel? get location;
  @override
  AssetSupplierModel? get supplier;
  @override
  String? get brand;
  @override
  String? get model;
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
