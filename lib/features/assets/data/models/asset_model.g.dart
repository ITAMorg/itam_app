// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssetTypeModelImpl _$$AssetTypeModelImplFromJson(Map<String, dynamic> json) =>
    _$AssetTypeModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      iconKey: json['iconKey'] as String,
      colorKey: json['colorKey'] as String,
    );

Map<String, dynamic> _$$AssetTypeModelImplToJson(
  _$AssetTypeModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'iconKey': instance.iconKey,
  'colorKey': instance.colorKey,
};

_$AssetLocationModelImpl _$$AssetLocationModelImplFromJson(
  Map<String, dynamic> json,
) => _$AssetLocationModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$$AssetLocationModelImplToJson(
  _$AssetLocationModelImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$AssetSupplierModelImpl _$$AssetSupplierModelImplFromJson(
  Map<String, dynamic> json,
) => _$AssetSupplierModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$$AssetSupplierModelImplToJson(
  _$AssetSupplierModelImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$AssetModelImpl _$$AssetModelImplFromJson(
  Map<String, dynamic> json,
) => _$AssetModelImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  serialNumber: json['serialNumber'] as String,
  status: json['status'] as String,
  assetType: AssetTypeModel.fromJson(json['type'] as Map<String, dynamic>),
  location: json['location'] == null
      ? null
      : AssetLocationModel.fromJson(json['location'] as Map<String, dynamic>),
  supplier: json['supplier'] == null
      ? null
      : AssetSupplierModel.fromJson(json['supplier'] as Map<String, dynamic>),
  brand: json['brand'] as String?,
  model: json['model'] as String?,
  purchaseDate: json['purchaseDate'] as String,
  warrantyEnd: json['warrantyEnd'] as String?,
);

Map<String, dynamic> _$$AssetModelImplToJson(_$AssetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'serialNumber': instance.serialNumber,
      'status': instance.status,
      'type': instance.assetType,
      'location': instance.location,
      'supplier': instance.supplier,
      'brand': instance.brand,
      'model': instance.model,
      'purchaseDate': instance.purchaseDate,
      'warrantyEnd': instance.warrantyEnd,
    };
