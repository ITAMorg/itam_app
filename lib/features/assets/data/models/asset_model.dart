import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';

part 'asset_model.freezed.dart';
part 'asset_model.g.dart';

@freezed
class AssetTypeModel with _$AssetTypeModel {
  const factory AssetTypeModel({
    required String name,
    required String iconKey,
    required String colorKey,
  }) = _AssetTypeModel;

  factory AssetTypeModel.fromJson(Map<String, dynamic> json) =>
      _$AssetTypeModelFromJson(json);
}

@freezed
class AssetModel with _$AssetModel {
  const factory AssetModel({
    required String id,
    required String name,
    required String serialNumber,
    required String status,
    required AssetTypeModel assetType,
    required String location,
    required String purchaseDate,
    String? warrantyEnd,
  }) = _AssetModel;

  factory AssetModel.fromJson(Map<String, dynamic> json) =>
      _$AssetModelFromJson(json);
}

extension AssetModelMapper on AssetModel {
  Asset toEntity() {
    return Asset(
      id: id,
      name: name,
      serialNumber: serialNumber,
      status: _mapStatus(status),
      assetType: AssetType(
        name: assetType.name,
        iconKey: assetType.iconKey,
        colorKey: assetType.colorKey,
      ),
      location: location,
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