# notes_app
https://github.com/Abdoula223/D-CLIC_NOTES_Projet-Semaine-6-.git

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=flat-square&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-00B4AB?style=flat-square&logo=dart)](https://dart.dev)
[![SQLite](https://img.shields.io/badge/SQLite-Local-003B57?style=flat-square&logo=sqlite)](https://www.sqlite.org)
[![License](https://img.shields.io/badge/License-DCLIC-blue?style=flat-square)](LICENSE)

Application mobile de gestion de notes développée avec Flutter et SQLite, réalisée dans le cadre de la formation DCLIC Développement Mobile niveau intermédiaire - Session Aout-Septembre

## Aperçu

D-CLIC Notes est une application de prise de notes sécurisée permettant aux utilisateurs de :
- Se connecter avec authentification SHA256
- Créer, lire, modifier et supprimer des notes
- Stocker les données localement avec SQLite
- Accéder à une interface intuitive et responsive

## Caractéristiques

- **Authentification sécurisée** : Mots de passe hashés en SHA256
- **CRUD complet** : Créer, lire, modifier, supprimer des notes
- **Base de données locale** : SQLite pour la persistance des données
- **Interface moderne** : Design Material Design avec palette DCLIC
- **Responsive** : Adapté aux différentes tailles d'écran
- **Gestion d'erreurs** : Messages clairs et validation des formulaires
- **Déconnexion sécurisée** : Retour automatique à l'authentification

## Prérequis

- Flutter SDK 3.0 ou supérieur
- Dart SDK 3.0 ou supérieur
- Émulateur Android/iOS ou appareil physique
- Git (optionnel)

## Installation

### 1. Cloner le projet

```bash
git clone https://github.com/Abdoula223/D-CLIC_NOTES_Projet-Semaine-6-.git
cd notes_app
```
Ou télécharger le ZIP et extraire le dossier.

### 2. Installer les dépendances

```bash
flutter pub get
```

### 3. Lancer l'application

```bash
flutter run
```
Pour un émulateur spécifique :

```bash
flutter run -d <device-id>
```

### 4. Construire en release

```bash
flutter build apk
flutter build ios
```

## Configuration rapide

Vérifiez que Flutter est correctement installé :

```bash
flutter doctor
```

Créez un émulateur si nécessaire :

```bash
flutter emulators --create --name default
flutter emulators --launch default
```

## Utilisation

### Première connexion

Utilisez les identifiants de test :
- Nom d'utilisateur : `diallot@dclic.org`
- Mot de passe : `motdepasse123`

### Écrans principaux

**Accueil**
- Logo D-CLIC avec background coloré
- Bouton "Se connecter"

**Connexion**
- Saisie du nom d'utilisateur
- Saisie du mot de passe
- Messages d'erreur en cas d'échec
- Lien "Mot de passe oublié?"

**Mes Notes**
- Liste de toutes les notes créées
- Bouton "+" pour ajouter une note
- Menu de suppression par note
- Pull-to-refresh pour actualiser

**Édition**
- Champs titre et contenu
- Boutons "Enregistrer" et "Annuler"
- Validation des données

## Structure du projet
notes_app/
├── Document/
│   └── PROJET SEMAINE 6 # Documentation du projet avec capture
├── lib/
│   ├── main.dart # Point d'entrée
│   ├── models/
│   │   ├── user.dart # Modèle utilisateur
│   │   └── note.dart # Modèle note
│   ├── database/
│   │   └── database_helper.dart # Gestion SQLite
│   ├── screens/
│   │   ├── splash_screen.dart # Écran d'accueil
│   │   ├── login_screen.dart # Authentification
│   │   ├── notes_screen.dart # Liste des notes
│   │   └── edit_note_screen.dart # Créer/modifier
│   └── widgets/
│       └── note_card.dart # Affichage note
├── assets/
│   └── images/
│       └── dclic_background.png # Background
├── pubspec.yaml # Dépendances
└── README.md # Ce fichier

## Architecture

L'application suit le pattern Model-View-Controller :

### Modèles
- `User` : Représente un utilisateur (username, password)
- `Note` : Représente une note (id, title, content, dates)

### Database
- `DatabaseHelper` (Singleton) : Gère SQLite
- CRUD complet pour les notes
- Authentification utilisateur
- Hashage des mots de passe

### Écrans
- `SplashScreen` : Accueil
- `LoginScreen` : Authentification
- `NotesScreen` : Affichage principal
- `EditNoteScreen` : Création/modification

### Widgets
- `NoteCard` : Affichage d'une note avec menu

## Base de données

### Table users

| Colonne | Type | Description |
|---------|------|-------------|
| id | INTEGER PRIMARY KEY | Identifiant unique |
| username | TEXT UNIQUE | Nom d'utilisateur |
| password | TEXT | Mot de passe hashé |

### Table notes

| Colonne | Type | Description |
|---------|------|-------------|
| id | INTEGER PRIMARY KEY | Identifiant unique |
| title | TEXT | Titre de la note |
| content | TEXT | Contenu de la note |
| createdAt | TEXT | Date de création ISO8601 |
| updatedAt | TEXT | Date de modification ISO8601 |

## Sécurité

- Mots de passe hashés en SHA256
- Parameter binding pour prévenir l'injection SQL
- Base de données locale (données privées)
- Pas de transmission réseau
- Authentification obligatoire

## Dépendances

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0       # SQLite
  path: ^1.8.3          # Gestion des chemins
  crypto: ^3.0.3        # Hashage SHA256
```

## Dépannage

### Flutter not found

Ajouter Flutter au PATH :

```bash
export PATH="$PATH:/chemin/vers/flutter/bin"
```

### Erreur Gradle

```bash
flutter clean
flutter pub get
flutter run
```

### Pas d'appareil

Créer un émulateur :

```bash
flutter emulators
flutter emulators --create --name=default
flutter emulators --launch default
```

### Port occupé

Trouver le processus :

```bash
lsof -i :8888
kill -9 <PID>
```

## Wireframes

Les wireframes de l'application sont disponibles dans le dossier `Document/PROJET SEMAINE 6`

Cinq écrans principaux :
1. Écran d'accueil
2. Formulaire de connexion
3. Liste des notes
4. Édition d'une note
5. Dialogs de confirmation

## Tests

L'application a été testée pour :
- Authentification (succès et échec)
- Création de note
- Affichage de la liste
- Modification de note
- Suppression de note
- Déconnexion
- Navigation entre écrans

Pour exécuter les tests (si disponibles) :

```bash
flutter test
```

## Performance

- Utilise FutureBuilder pour le chargement asynchrone
- ListView avec scrolling efficace
- Singleton DatabaseHelper pour une seule instance BD
- Requêtes optimisées avec parameter binding

## Améliorations futures

- [ ] Recherche et filtrage de notes
- [ ] Catégorisation des notes
- [ ] Export en PDF
- [ ] Synchronisation cloud (Firebase)
- [ ] Mode sombre
- [ ] Partage de notes
- [ ] Notifications locales
- [ ] Tests unitaires
- [ ] Authentification externe (OAuth)

## Compatibilité

- Android 5.0+ (API 21+)
- iOS 11.0+
- Web (à implémenter)

## Formation

Projet réalisé dans le cadre de la formation DCLIC "Formez-vous au numérique avec l'OIF"

- Niveau : Intermédiaire
- Durée : 8 heures (Semaine 6)
- Année : 2026

## Auteur
DIALLO 
- Ingénieur IT 
- Localisation : Dakar, Sénégal

## Support

Pour toute question ou problème, consulter la documentation ou ouvrir une issue.

## License

Projet DCLIC 2026. Tous droits réservés.

---

Dernière mise à jour : Septembre 2026