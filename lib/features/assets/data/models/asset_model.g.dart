// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssetTypeModelImpl _$$AssetTypeModelImplFromJson(Map<String, dynamic> json) =>
    _$AssetTypeModelImpl(
      name: json['name'] as String,
      iconKey: json['iconKey'] as String,
      colorKey: json['colorKey'] as String,
    );

Map<String, dynamic> _$$AssetTypeModelImplToJson(
  _$AssetTypeModelImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'iconKey': instance.iconKey,
  'colorKey': instance.colorKey,
};

_$AssetModelImpl _$$AssetModelImplFromJson(Map<String, dynamic> json) =>
    _$AssetModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      serialNumber: json['serialNumber'] as String,
      status: json['status'] as String,
      assetType: AssetTypeModel.fromJson(
        json['assetType'] as Map<String, dynamic>,
      ),
      location: json['location'] as String,
      purchaseDate: json['purchaseDate'] as String,
      warrantyEnd: json['warrantyEnd'] as String?,
    );

Map<String, dynamic> _$$AssetModelImplToJson(_$AssetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'serialNumber': instance.serialNumber,
      'status': instance.status,
      'assetType': instance.assetType,
      'location': instance.location,
      'purchaseDate': instance.purchaseDate,
      'warrantyEnd': instance.warrantyEnd,
    };
