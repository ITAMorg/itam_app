enum AssetStatus { inService, broken, inStock }

class AssetType {
  final String name;
  final String iconKey;
  final String colorKey;

  const AssetType({
    required this.name,
    required this.iconKey,
    required this.colorKey,
  });
}

class Asset {
  final String id;
  final String name;
  final String serialNumber;
  final AssetStatus status;
  final AssetType assetType;
  final String location;
  final DateTime purchaseDate;
  final DateTime? warrantyEnd;

  const Asset({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.status,
    required this.assetType,
    required this.location,
    required this.purchaseDate,
    this.warrantyEnd,
  });
}