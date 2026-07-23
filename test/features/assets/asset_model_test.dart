import 'package:flutter_test/flutter_test.dart';
import 'package:itam_app/features/assets/data/models/asset_model.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';

void main() {
  // Reponse complete de l'API pour un equipement.
  Map<String, dynamic> fullJson() => {
    'id': 21,
    'name': 'Ecran Dell P2419H',
    'serialNumber': 'SN-8891',
    'status': 'IN_SERVICE',
    'type': {
      'id': 2,
      'name': 'Ecran',
      'iconKey': 'monitor',
      'colorKey': 'blue',
    },
    'location': {'id': 5, 'name': 'Batiment A - Etage 2'},
    'supplier': {'id': 9, 'name': 'Fournisseur Nord'},
    'brand': 'Dell',
    'model': 'P2419H',
    'purchaseDate': '2024-09-01T00:00:00.000Z',
    'warrantyEnd': '2027-09-01T00:00:00.000Z',
    'tickets': [
      {
        'id': 12,
        'reference': 'TKT-2026-00042',
        'title': 'Ecran ne s allume plus',
        'status': 'IN_PROGRESS',
        'priority': 'HIGH',
        'type': 'INCIDENT',
        'createdAt': '2026-03-14T09:30:00.000Z',
      },
    ],
  };

  // Reponse minimale : seuls les champs obligatoires sont presents.
  Map<String, dynamic> minimalJson() => {
    'id': 30,
    'name': 'Clavier sans marque',
    'serialNumber': 'SN-0001',
    'status': 'IN_STOCK',
    'type': {
      'id': 4,
      'name': 'Peripherique',
      'iconKey': 'keyboard',
      'colorKey': 'gray',
    },
    'purchaseDate': '2025-02-10T00:00:00.000Z',
  };

  group('AssetTypeModel', () {
    test('deserialise un type d equipement', () {
      final model = AssetTypeModel.fromJson({
        'id': 2,
        'name': 'Ecran',
        'iconKey': 'monitor',
        'colorKey': 'blue',
      });

      expect(model.id, 2);
      expect(model.name, 'Ecran');
      expect(model.iconKey, 'monitor');
      expect(model.colorKey, 'blue');
    });

    test('deux instances de memes valeurs sont egales', () {
      final a = AssetTypeModel.fromJson({
        'id': 2,
        'name': 'Ecran',
        'iconKey': 'monitor',
        'colorKey': 'blue',
      });
      final b = AssetTypeModel.fromJson({
        'id': 2,
        'name': 'Ecran',
        'iconKey': 'monitor',
        'colorKey': 'blue',
      });

      expect(a, equals(b));
    });
  });

  group('AssetLocationModel et AssetSupplierModel', () {
    test('deserialise un site', () {
      final model = AssetLocationModel.fromJson({
        'id': 5,
        'name': 'Batiment A',
      });

      expect(model.id, 5);
      expect(model.name, 'Batiment A');
    });

    test('deserialise un fournisseur', () {
      final model = AssetSupplierModel.fromJson({
        'id': 9,
        'name': 'Fournisseur Nord',
      });

      expect(model.id, 9);
      expect(model.name, 'Fournisseur Nord');
    });
  });

  group('TicketSummaryModel', () {
    test('deserialise le resume d un ticket', () {
      final model = TicketSummaryModel.fromJson({
        'id': 12,
        'reference': 'TKT-2026-00042',
        'title': 'Ecran ne s allume plus',
        'status': 'IN_PROGRESS',
        'priority': 'HIGH',
        'type': 'INCIDENT',
        'createdAt': '2026-03-14T09:30:00.000Z',
      });

      expect(model.id, 12);
      expect(model.reference, 'TKT-2026-00042');
      expect(model.status, 'IN_PROGRESS');
      expect(model.priority, 'HIGH');
      expect(model.type, 'INCIDENT');
    });
  });

  group('AssetModel.fromJson', () {
    test('deserialise un equipement complet', () {
      final model = AssetModel.fromJson(fullJson());

      expect(model.id, 21);
      expect(model.name, 'Ecran Dell P2419H');
      expect(model.serialNumber, 'SN-8891');
      expect(model.status, 'IN_SERVICE');
      expect(model.brand, 'Dell');
      expect(model.model, 'P2419H');
      expect(model.purchaseDate, '2024-09-01T00:00:00.000Z');
      expect(model.warrantyEnd, '2027-09-01T00:00:00.000Z');
    });

    test('lit le type d equipement depuis la cle type du JSON', () {
      final model = AssetModel.fromJson(fullJson());

      expect(model.assetType.id, 2);
      expect(model.assetType.name, 'Ecran');
    });

    test('deserialise le site et le fournisseur', () {
      final model = AssetModel.fromJson(fullJson());

      expect(model.location, isNotNull);
      expect(model.location!.name, 'Batiment A - Etage 2');
      expect(model.supplier, isNotNull);
      expect(model.supplier!.name, 'Fournisseur Nord');
    });

    test('deserialise les tickets associes', () {
      final model = AssetModel.fromJson(fullJson());

      expect(model.tickets, hasLength(1));
      expect(model.tickets.first.reference, 'TKT-2026-00042');
    });

    test('accepte un equipement sans site, fournisseur ni marque', () {
      final model = AssetModel.fromJson(minimalJson());

      expect(model.location, isNull);
      expect(model.supplier, isNull);
      expect(model.brand, isNull);
      expect(model.model, isNull);
      expect(model.warrantyEnd, isNull);
    });

    test('retourne une liste de tickets vide quand la cle est absente', () {
      final model = AssetModel.fromJson(minimalJson());

      expect(model.tickets, isEmpty);
    });

    test('retourne une liste de tickets vide quand la cle vaut null', () {
      final json = minimalJson()..['tickets'] = null;
      final model = AssetModel.fromJson(json);

      expect(model.tickets, isEmpty);
    });
  });

  group('AssetModel.toEntity - champs simples', () {
    test('convertit l identifiant numerique en chaine', () {
      final entity = AssetModel.fromJson(fullJson()).toEntity();

      expect(entity.id, '21');
    });

    test('reporte les champs scalaires sur l entite', () {
      final entity = AssetModel.fromJson(fullJson()).toEntity();

      expect(entity.name, 'Ecran Dell P2419H');
      expect(entity.serialNumber, 'SN-8891');
      expect(entity.brand, 'Dell');
      expect(entity.model, 'P2419H');
    });

    test('convertit les dates texte en DateTime', () {
      final entity = AssetModel.fromJson(fullJson()).toEntity();

      expect(entity.purchaseDate, DateTime.parse('2024-09-01T00:00:00.000Z'));
      expect(entity.warrantyEnd, DateTime.parse('2027-09-01T00:00:00.000Z'));
    });

    test('laisse la fin de garantie a null quand elle est absente', () {
      final entity = AssetModel.fromJson(minimalJson()).toEntity();

      expect(entity.warrantyEnd, isNull);
    });
  });

  group('AssetModel.toEntity - relations', () {
    test('convertit le type d equipement', () {
      final entity = AssetModel.fromJson(fullJson()).toEntity();

      expect(entity.assetType.id, 2);
      expect(entity.assetType.name, 'Ecran');
      expect(entity.assetType.iconKey, 'monitor');
      expect(entity.assetType.colorKey, 'blue');
    });

    test('convertit le site et le fournisseur quand ils sont presents', () {
      final entity = AssetModel.fromJson(fullJson()).toEntity();

      expect(entity.location, isNotNull);
      expect(entity.location!.id, 5);
      expect(entity.supplier, isNotNull);
      expect(entity.supplier!.id, 9);
    });

    test('laisse site et fournisseur a null quand ils sont absents', () {
      final entity = AssetModel.fromJson(minimalJson()).toEntity();

      expect(entity.location, isNull);
      expect(entity.supplier, isNull);
    });

    test('convertit les tickets associes et leurs dates', () {
      final entity = AssetModel.fromJson(fullJson()).toEntity();

      expect(entity.tickets, hasLength(1));
      final ticket = entity.tickets.first;
      expect(ticket.id, 12);
      expect(ticket.reference, 'TKT-2026-00042');
      expect(ticket.title, 'Ecran ne s allume plus');
      expect(ticket.createdAt, DateTime.parse('2026-03-14T09:30:00.000Z'));
    });
  });

  group('AssetModel.toEntity - conversion du statut', () {
    Asset entityWithStatus(String status) {
      final json = minimalJson()..['status'] = status;
      return AssetModel.fromJson(json).toEntity();
    }

    test('convertit chaque statut connu', () {
      expect(entityWithStatus('IN_SERVICE').status, AssetStatus.inService);
      expect(entityWithStatus('BROKEN').status, AssetStatus.broken);
      expect(entityWithStatus('IN_STOCK').status, AssetStatus.inStock);
      expect(entityWithStatus('MAINTENANCE').status, AssetStatus.maintenance);
    });

    test('retombe sur en stock si le statut est inconnu', () {
      expect(entityWithStatus('AUTRE').status, AssetStatus.inStock);
    });
  });
  
  group('AssetModel - numero de serie absent', () {
    test('accepte un equipement sans numero de serie', () {
      final json = minimalJson()..remove('serialNumber');
      final model = AssetModel.fromJson(json);
  
      expect(model.serialNumber, isNull);
      expect(model.toEntity().serialNumber, isNull);
    });
  });

  group('Serialisation des sous-modeles d equipement', () {
    test('serialise un type d equipement', () {
      final json = AssetTypeModel.fromJson({
        'id': 2,
        'name': 'Ecran',
        'iconKey': 'monitor',
        'colorKey': 'blue',
      }).toJson();

      expect(json['id'], 2);
      expect(json['iconKey'], 'monitor');
      expect(json['colorKey'], 'blue');
    });

    test('serialise un site et un fournisseur', () {
      expect(
        AssetLocationModel.fromJson({
          'id': 5,
          'name': 'Batiment A',
        }).toJson()['name'],
        'Batiment A',
      );
      expect(
        AssetSupplierModel.fromJson({
          'id': 9,
          'name': 'Fournisseur Nord',
        }).toJson()['id'],
        9,
      );
    });

    test('serialise le resume d un ticket', () {
      final json = TicketSummaryModel.fromJson({
        'id': 12,
        'reference': 'TKT-2026-00042',
        'title': 'Ecran hors service',
        'status': 'OPEN',
        'priority': 'HIGH',
        'type': 'INCIDENT',
        'createdAt': '2026-03-14T09:30:00.000Z',
      }).toJson();

      expect(json['reference'], 'TKT-2026-00042');
      expect(json['priority'], 'HIGH');
    });

    test('un aller-retour preserve les valeurs', () {
      final original = AssetTypeModel.fromJson({
        'id': 2,
        'name': 'Ecran',
        'iconKey': 'monitor',
        'colorKey': 'blue',
      });

      expect(AssetTypeModel.fromJson(original.toJson()), equals(original));
    });

    test('copyWith remplace uniquement le champ demande', () {
      final model = AssetTypeModel.fromJson({
        'id': 2,
        'name': 'Ecran',
        'iconKey': 'monitor',
        'colorKey': 'blue',
      });
      final updated = model.copyWith(name: 'Moniteur');

      expect(updated.name, 'Moniteur');
      expect(updated.iconKey, 'monitor');
    });
  });
}
