import 'package:flutter_test/flutter_test.dart';
import 'package:itam_app/features/tickets/data/models/ticket_model.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

void main() {
  // Jeu de donnees de reference : reponse complete de l'API pour un ticket.
  Map<String, dynamic> fullJson() => {
    'id': 12,
    'reference': 'TKT-2026-00042',
    'type': 'INCIDENT',
    'status': 'IN_PROGRESS',
    'priority': 'HIGH',
    'title': 'Ecran ne s allume plus',
    'description': 'Aucun affichage au demarrage',
    'createdAt': '2026-03-14T09:30:00.000Z',
    'updatedAt': '2026-03-14T11:00:00.000Z',
    'dueDate': '2026-03-16T17:00:00.000Z',
    'resolvedAt': '2026-03-15T08:15:00.000Z',
    'requester': {
      'id': 3,
      'firstName': 'Claire',
      'lastName': 'Martin',
      'email': 'claire.martin@exemple.fr',
    },
    'assignee': {
      'id': 7,
      'firstName': 'Paul',
      'lastName': 'Durand',
      'email': 'paul.durand@exemple.fr',
    },
    'asset': {
      'id': 21,
      'name': 'Ecran Dell P2419H',
      'brand': 'Dell',
      'model': 'P2419H',
      'serialNumber': 'SN-8891',
      'iconKey': 'monitor',
      'colorKey': 'blue',
    },
    'comments': [
      {
        'id': 100,
        'content': 'Prise en charge en cours',
        'createdAt': '2026-03-14T10:00:00.000Z',
        'author': {
          'id': 7,
          'firstName': 'Paul',
          'lastName': 'Durand',
          'email': 'paul.durand@exemple.fr',
        },
      },
    ],
  };

  // Jeu de donnees minimal : seuls les champs obligatoires sont presents.
  Map<String, dynamic> minimalJson() => {
    'id': 1,
    'reference': 'TKT-2026-00001',
    'type': 'REQUEST',
    'status': 'OPEN',
    'priority': 'LOW',
    'title': 'Demande de casque',
    'createdAt': '2026-01-05T08:00:00.000Z',
    'updatedAt': '2026-01-05T08:00:00.000Z',
    'requester': {'id': 4, 'firstName': 'Sofia', 'lastName': 'Ben Ali'},
    'comments': <dynamic>[],
  };

  group('TicketUserModel', () {
    test('deserialise un utilisateur complet', () {
      final model = TicketUserModel.fromJson({
        'id': 3,
        'firstName': 'Claire',
        'lastName': 'Martin',
        'email': 'claire.martin@exemple.fr',
      });

      expect(model.id, 3);
      expect(model.firstName, 'Claire');
      expect(model.lastName, 'Martin');
      expect(model.email, 'claire.martin@exemple.fr');
    });

    test('accepte un email absent', () {
      final model = TicketUserModel.fromJson({
        'id': 4,
        'firstName': 'Sofia',
        'lastName': 'Ben Ali',
      });

      expect(model.email, isNull);
    });

    test('deux instances de memes valeurs sont egales', () {
      final a = TicketUserModel.fromJson({
        'id': 3,
        'firstName': 'Claire',
        'lastName': 'Martin',
      });
      final b = TicketUserModel.fromJson({
        'id': 3,
        'firstName': 'Claire',
        'lastName': 'Martin',
      });

      expect(a, equals(b));
    });
  });

  group('TicketAssetModel', () {
    test('deserialise un equipement complet', () {
      final model = TicketAssetModel.fromJson({
        'id': 21,
        'name': 'Ecran Dell P2419H',
        'brand': 'Dell',
        'model': 'P2419H',
        'serialNumber': 'SN-8891',
        'iconKey': 'monitor',
        'colorKey': 'blue',
      });

      expect(model.id, 21);
      expect(model.name, 'Ecran Dell P2419H');
      expect(model.brand, 'Dell');
      expect(model.serialNumber, 'SN-8891');
      expect(model.iconKey, 'monitor');
      expect(model.colorKey, 'blue');
    });

    test('accepte les champs optionnels absents', () {
      final model = TicketAssetModel.fromJson({
        'id': 22,
        'name': 'Poste sans details',
      });

      expect(model.brand, isNull);
      expect(model.model, isNull);
      expect(model.serialNumber, isNull);
      expect(model.iconKey, isNull);
      expect(model.colorKey, isNull);
    });
  });

  group('TicketCommentModel', () {
    test('deserialise un commentaire et son auteur', () {
      final model = TicketCommentModel.fromJson({
        'id': 100,
        'content': 'Prise en charge en cours',
        'createdAt': '2026-03-14T10:00:00.000Z',
        'author': {'id': 7, 'firstName': 'Paul', 'lastName': 'Durand'},
      });

      expect(model.id, 100);
      expect(model.content, 'Prise en charge en cours');
      expect(model.author.firstName, 'Paul');
    });
  });

  group('TicketModel.fromJson', () {
    test('deserialise un ticket complet', () {
      final model = TicketModel.fromJson(fullJson());

      expect(model.id, 12);
      expect(model.reference, 'TKT-2026-00042');
      expect(model.type, 'INCIDENT');
      expect(model.status, 'IN_PROGRESS');
      expect(model.priority, 'HIGH');
      expect(model.title, 'Ecran ne s allume plus');
      expect(model.description, 'Aucun affichage au demarrage');
      expect(model.dueDate, '2026-03-16T17:00:00.000Z');
      expect(model.resolvedAt, '2026-03-15T08:15:00.000Z');
    });

    test('deserialise les relations imbriquees', () {
      final model = TicketModel.fromJson(fullJson());

      expect(model.requester.firstName, 'Claire');
      expect(model.assignee, isNotNull);
      expect(model.assignee!.lastName, 'Durand');
      expect(model.asset, isNotNull);
      expect(model.asset!.name, 'Ecran Dell P2419H');
      expect(model.comments, hasLength(1));
      expect(model.comments.first.author.firstName, 'Paul');
    });

    test(
      'accepte un ticket sans assigne, sans equipement et sans commentaire',
      () {
        final model = TicketModel.fromJson(minimalJson());

        expect(model.assignee, isNull);
        expect(model.asset, isNull);
        expect(model.comments, isEmpty);
        expect(model.description, isNull);
        expect(model.dueDate, isNull);
        expect(model.resolvedAt, isNull);
      },
    );
  });

  group('TicketModel.toEntity - champs simples', () {
    test('reporte les champs scalaires sur l entite', () {
      final entity = TicketModel.fromJson(fullJson()).toEntity();

      expect(entity.id, 12);
      expect(entity.reference, 'TKT-2026-00042');
      expect(entity.title, 'Ecran ne s allume plus');
      expect(entity.description, 'Aucun affichage au demarrage');
    });

    test('convertit les dates texte en DateTime', () {
      final entity = TicketModel.fromJson(fullJson()).toEntity();

      expect(entity.createdAt, DateTime.parse('2026-03-14T09:30:00.000Z'));
      expect(entity.updatedAt, DateTime.parse('2026-03-14T11:00:00.000Z'));
      expect(entity.dueDate, DateTime.parse('2026-03-16T17:00:00.000Z'));
      expect(entity.resolvedAt, DateTime.parse('2026-03-15T08:15:00.000Z'));
    });

    test('laisse les dates optionnelles a null quand elles sont absentes', () {
      final entity = TicketModel.fromJson(minimalJson()).toEntity();

      expect(entity.dueDate, isNull);
      expect(entity.resolvedAt, isNull);
    });
  });

  group('TicketModel.toEntity - relations', () {
    test('convertit le demandeur', () {
      final entity = TicketModel.fromJson(fullJson()).toEntity();

      expect(entity.requester.id, 3);
      expect(entity.requester.firstName, 'Claire');
      expect(entity.requester.email, 'claire.martin@exemple.fr');
    });

    test('convertit l assigne quand il est present', () {
      final entity = TicketModel.fromJson(fullJson()).toEntity();

      expect(entity.assignee, isNotNull);
      expect(entity.assignee!.id, 7);
      expect(entity.assignee!.lastName, 'Durand');
    });

    test('convertit l equipement associe', () {
      final entity = TicketModel.fromJson(fullJson()).toEntity();

      expect(entity.asset, isNotNull);
      expect(entity.asset!.id, 21);
      expect(entity.asset!.brand, 'Dell');
      expect(entity.asset!.iconKey, 'monitor');
      expect(entity.asset!.colorKey, 'blue');
    });

    test('convertit les commentaires et leurs auteurs', () {
      final entity = TicketModel.fromJson(fullJson()).toEntity();

      expect(entity.comments, hasLength(1));
      final comment = entity.comments.first;
      expect(comment.id, 100);
      expect(comment.content, 'Prise en charge en cours');
      expect(comment.createdAt, DateTime.parse('2026-03-14T10:00:00.000Z'));
      expect(comment.author.firstName, 'Paul');
    });

    test('laisse assigne et equipement a null quand ils sont absents', () {
      final entity = TicketModel.fromJson(minimalJson()).toEntity();

      expect(entity.assignee, isNull);
      expect(entity.asset, isNull);
      expect(entity.comments, isEmpty);
    });
  });

  group('TicketModel.toEntity - conversion des enumerations', () {
    Ticket entityWith({String? type, String? status, String? priority}) {
      final json = minimalJson();
      if (type != null) json['type'] = type;
      if (status != null) json['status'] = status;
      if (priority != null) json['priority'] = priority;
      return TicketModel.fromJson(json).toEntity();
    }

    test('convertit chaque type de ticket', () {
      expect(entityWith(type: 'INCIDENT').type, TicketType.incident);
      expect(entityWith(type: 'REQUEST').type, TicketType.request);
    });

    test('convertit chaque statut de ticket', () {
      expect(entityWith(status: 'OPEN').status, TicketStatus.open);
      expect(entityWith(status: 'IN_PROGRESS').status, TicketStatus.inProgress);
      expect(entityWith(status: 'RESOLVED').status, TicketStatus.resolved);
      expect(entityWith(status: 'CLOSED').status, TicketStatus.closed);
    });

    test('convertit chaque priorite de ticket', () {
      expect(entityWith(priority: 'LOW').priority, TicketPriority.low);
      expect(entityWith(priority: 'MEDIUM').priority, TicketPriority.medium);
      expect(entityWith(priority: 'HIGH').priority, TicketPriority.high);
    });

    test('retombe sur une valeur par defaut si la valeur est inconnue', () {
      expect(entityWith(type: 'AUTRE').type, TicketType.incident);
      expect(entityWith(status: 'AUTRE').status, TicketStatus.open);
      expect(entityWith(priority: 'AUTRE').priority, TicketPriority.medium);
    });
  });

  group('Serialisation des sous-modeles de ticket', () {
    test('serialise un utilisateur de ticket', () {
      final model = TicketUserModel.fromJson({
        'id': 3,
        'firstName': 'Claire',
        'lastName': 'Martin',
      });
      final json = model.toJson();

      expect(json['id'], 3);
      expect(json['firstName'], 'Claire');
      expect(json['lastName'], 'Martin');
    });

    test('serialise un equipement de ticket', () {
      final model = TicketAssetModel.fromJson({
        'id': 21,
        'name': 'Ecran Dell',
        'brand': 'Dell',
        'iconKey': 'monitor',
        'colorKey': 'blue',
      });
      final json = model.toJson();

      expect(json['id'], 21);
      expect(json['name'], 'Ecran Dell');
      expect(json['iconKey'], 'monitor');
    });

    test('serialise un commentaire et son auteur', () {
      final model = TicketCommentModel.fromJson({
        'id': 100,
        'content': 'Prise en charge',
        'createdAt': '2026-03-14T10:00:00.000Z',
        'author': {'id': 7, 'firstName': 'Paul', 'lastName': 'Durand'},
      });
      final json = model.toJson();

      expect(json['id'], 100);
      expect(json['content'], 'Prise en charge');
      expect(json['author'], isA<TicketUserModel>());
    });

    test('un aller-retour preserve les valeurs', () {
      final original = TicketUserModel.fromJson({
        'id': 3,
        'firstName': 'Claire',
        'lastName': 'Martin',
        'email': 'claire@exemple.fr',
      });

      expect(TicketUserModel.fromJson(original.toJson()), equals(original));
    });

    test('copyWith remplace uniquement le champ demande', () {
      final model = TicketUserModel.fromJson({
        'id': 3,
        'firstName': 'Claire',
        'lastName': 'Martin',
      });
      final updated = model.copyWith(lastName: 'Dupont');

      expect(updated.lastName, 'Dupont');
      expect(updated.firstName, 'Claire');
      expect(updated.id, 3);
    });
  });
}
