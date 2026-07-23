enum AssetStatus { inService, broken, inStock, maintenance }

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

class TicketSummary {
  final int id;
  final String reference;
  final String title;
  final String status;
  final String priority;
  final String type;
  final DateTime createdAt;

  const TicketSummary({
    required this.id,
    required this.reference,
    required this.title,
    required this.status,
    required this.priority,
    required this.type,
    required this.createdAt,
  });

  bool get isActive => status == 'OPEN' || status == 'IN_PROGRESS';
}

class Asset {
  final String id;
  final String name;
  final String? serialNumber;
  final AssetStatus status;
  final AssetType assetType;
  final AssetLocation? location;
  final AssetSupplier? supplier;
  final String? brand;
  final String? model;
  final DateTime purchaseDate;
  final DateTime? warrantyEnd;
  final List<TicketSummary> tickets;

  const Asset({
    required this.id,
    required this.name,
    this.serialNumber,
    required this.status,
    required this.assetType,
    this.location,
    this.supplier,
    this.brand,
    this.model,
    required this.purchaseDate,
    this.warrantyEnd,
    this.tickets = const [],
  });

  TicketSummary? get activeTicket =>
      tickets.where((t) => t.isActive).firstOrNull;
}