# La Baguette 🥖

Application d'engagement civique pour suivre l'activité parlementaire française.

## Fonctionnalités

- **Authentification** : Connexion/Inscription (Mocké pour la démo).
- **Lois** : Consultation des propositions de loi, détails, et vote.
- **Députés** : Liste des députés, profils détaillés, score de cohésion.
- **Statistiques** : Visualisation des votes de la communauté (Baguette Bar).
- **Gamification** : Badges pour l'engagement citoyen.

## Configuration

### Pré-requis

- Flutter SDK (3.10+)
- Dart SDK

### Installation

1.  Cloner le dépôt.
2.  Installer les dépendances :
    ```bash
    flutter pub get
    ```

### Lancer l'application

Pour lancer l'application avec les données de test (Mock) :

```bash
flutter run
```

### Identifiants de test

Pour la connexion (Login), vous pouvez utiliser n'importe quel email/mot de passe, ou les valeurs par défaut pré-remplies :
- **Email** : `test@test.com`
- **Mot de passe** : `password`

## Architecture

- **State Management** : Riverpod
- **Navigation** : GoRouter
- **Backend** : Supabase (Mocké via `MockService` pour cette version de démonstration).

## Structure du projet

- `lib/core` : Thèmes, constantes.
- `lib/features` : Écrans et logique métier par fonctionnalité (Auth, Home, Laws, Deputies, Profile).
- `lib/models` : Modèles de données.
- `lib/services` : Services d'accès aux données (Repositories).
- `lib/widgets` : Widgets réutilisables.
