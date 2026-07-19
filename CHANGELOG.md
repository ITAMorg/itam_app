# Changelog

Toutes les modifications notables apportées à ce projet sont documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.1.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-07-19

### Ajouté
- Version finale destinée au dossier RNCP.
- Correctifs UX intégrés : login, listes assets, tickets, page QR code.
- Suppression du cache au logout pour garantir l'isolation entre sessions.
- Amélioration des filtres de recherche et de la barre de recherche.
- Assignation d'une location à un asset depuis l'application mobile.
- Suite de 16 tests Flutter (flutter_test + mocktail + Riverpod) :
  - 4 tests unitaires sur l'AuthState (immutabilité, copyWith)
  - 3 tests d'intégration AuthNotifier avec repository mocké
  - 3 tests AssetsNotifier (filtrage RBAC côté client par rôle et location)
  - 3 tests TicketNotifier (chargement, propagation d'erreur, refresh)
  - 3 tests widget sur LoginPage (rendu, masquage password, interactions)

### Modifié
- Refonte visuelle des widgets core partagés (composants réutilisables).
- Réglages de bugs UX identifiés lors des phases de test terrain.
- Gestion de la reconnexion réseau améliorée.

## [0.9.0] - 2026-04-16

### Ajouté
- Version bêta — parcours utilisateurs complets fonctionnels sur l'ensemble des modules.
- Logique complète d'état pour tickets et assets synchronisée avec l'API.
- Rafraîchissement automatique de la liste des assets.

## [0.4.0] - 2026-04-15

### Ajouté
- Fonctionnalité de scan de QR code : lecture d'un asset par photo depuis l'appareil.
- Génération d'affichage QR code pour un asset dans la fiche détail.
- Intégration `qr_flutter` pour l'affichage et `gal` pour la sauvegarde.

## [0.3.0] - 2026-04-13

### Ajouté
- Module tickets complet : liste, création, détail, historique.
- Page de création de ticket accessible depuis un asset (contextuel).
- Stepper animé sur la page détail ticket.
- Gestion des filtres et de l'assignation.
- Réouverture de ticket depuis la fiche détail.

## [0.2.0] - 2026-04-12

### Ajouté
- Module assets complet : liste, détail, filtres.
- Fiche détail asset avec top bar personnalisée.
- Connexion à l'API assets avec affichage en cartes.
- Routes de navigation `go_router` pour les pages assets.

## [0.1.0] - 2026-03-28

### Ajouté
- Authentification JWT avec écran de login dédié.
- Persistance des tokens via `flutter_secure_storage` (avec fallback `TokenStore` singleton pour la fiabilité Web).
- Thème de l'application (dark theme, tokens de design centralisés `AppColors`, `AppTextStyles`).
- Logo et identité visuelle ITAM.

### Sécurité
- Stockage sécurisé des tokens JWT.
- Redirection automatique vers login en cas de token expiré.

## [Fondations]

### Ajouté
- Initialisation du projet Flutter (Android + Windows desktop pour dev).
- Pipeline d'intégration continue (GitHub Actions) : analyze, test, build APK.
- Structure de projet basée sur Clean Architecture.
- Configuration Riverpod avec code generation (`riverpod_annotation`, Freezed).