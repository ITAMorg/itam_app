import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';

part 'asset_model.freezed.dart';
part 'asset_model.g.dart';

@freezed
class AssetTypeModel with _$AssetTypeModel {
  const factory AssetTypeModel({
    required int id,
    required String name,
    required String iconKey,
    required String colorKey,
  }) = _AssetTypeModel;

  factory AssetTypeModel.fromJson(Map<String, dynamic> json) =>
      _$AssetTypeModelFromJson(json);
}

@freezed
class AssetLocationModel with _$AssetLocationModel {
  const factory AssetLocationModel({
    required int id,
    required String name,
  }) = _AssetLocationModel;

  factory AssetLocationModel.fromJson(Map<String, dynamic> json) =>
      _$AssetLocationModelFromJson(json);
}

@freezed
class AssetSupplierModel with _$AssetSupplierModel {
  const factory AssetSupplierModel({
    required int id,
    required String name,
  }) = _AssetSupplierModel;

  factory AssetSupplierModel.fromJson(Map<String, dynamic> json) =>
      _$AssetSupplierModelFromJson(json);
}

@freezed
class AssetModel with _$AssetModel {
  const factory AssetModel({
    required int id,
    required String name,
    required String serialNumber,
    required String status,
    required AssetTypeModel assetType,
    AssetLocationModel? location,
    AssetSupplierModel? supplier,
    String? brand,
    String? model,
    required String purchaseDate,
    String? warrantyEnd,
  }) = _AssetModel;

  factory AssetModel.fromJson(Map<String, dynamic> json) =>
    AssetModel(
      id: json['id'] as int,
      name: json['name'] as String,
      serialNumber: json['serialNumber'] as String,
      status: json['status'] as String,
      assetType: AssetTypeModel.fromJson(json['type'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : AssetLocationModel.fromJson(json['location'] as Map<String, dynamic>),
      purchaseDate: json['purchaseDate'] as String,
      warrantyEnd: json['warrantyEnd'] as String?,
    );
}

extension AssetModelMapper on AssetModel {
  Asset toEntity() {
    return Asset(
      id: id.toString(),
      name: name,
      serialNumber: serialNumber,
      status: _mapStatus(status),
      assetType: AssetType(
        id: assetType.id,
        name: assetType.name,
        iconKey: assetType.iconKey,
        colorKey: assetType.colorKey,
      ),
      location: location != null
          ? AssetLocation(id: location!.id, name: location!.name)
          : null,
      supplier: supplier != null
          ? AssetSupplier(id: supplier!.id, name: supplier!.name)
          : null,
      brand: brand,
      model: model,
      purchaseDate: DateTime.parse(purchaseDate),
      warrantyEnd: warrantyEnd != null ? DateTime.parse(warrantyEnd!) : null,
    );
  }

  AssetStatus _mapStatus(String status) {
    switch (status) {
      case 'IN_SERVICE':
        return AssetStatus.inService;
      case 'BROKEN':
        return AssetStatus.broken;
      case 'IN_STOCK':
        return AssetStatus.inStock;
      default:
        return AssetStatus.inStock;
    }
  }
}