enum AssetStatus { inService, broken, inStock }

class AssetType {
  final int id;
  final String name;
  final String iconKey;
  final String colorKey;

  const AssetType({
    required this.id,
    required this.name,
    required this.iconKey,
    required this.colorKey,
  });
}

class AssetLocation {
  final int id;
  final String name;

  const AssetLocation({required this.id, required this.name});
}

class AssetSupplier {
  final int id;
  final String name;

  const AssetSupplier({required this.id, required this.name});
}

class Asset {
  final String id;
  final String name;
  final String serialNumber;
  final AssetStatus status;
  final AssetType assetType;
  final AssetLocation? location;   // objet complet (pour la modification)
  final AssetSupplier? supplier;
  final String? brand;
  final String? model;
  final DateTime purchaseDate;
  final DateTime? warrantyEnd;

  const Asset({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.status,
    required this.assetType,
    this.location,
    this.supplier,
    this.brand,
    this.model,
    required this.purchaseDate,
    this.warrantyEnd,
  });
}