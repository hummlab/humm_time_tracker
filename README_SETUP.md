# Time Tracker - Firebase Setup & Deployment

This guide covers technical setup and deployment for self-hosting Time Tracker.

## Prerequisites

- Flutter SDK (stable)
- Dart SDK (matching Flutter)
- Node.js 22+
- Firebase CLI
- A new Firebase project dedicated to this instance

Install Firebase CLI:

```bash
npm install -g firebase-tools
```

## Required Project Files

To run this project correctly, these files should be present.

### Committed in repository (required)

- `pubspec.yaml`
- `lib/main.dart`
- `lib/firebase_options.dart` (generated once locally, then kept for your environment)
- `firebase.json` (Firestore/Hosting/Functions config)
- `firestore.rules`
- `firestore.indexes.json`
- `functions/package.json`
- `functions/index.js`

### Generated locally (do not commit)

- `.firebaserc` (created by `firebase use --add`)
- platform Firebase files if used:
  - `android/app/google-services.json`
  - `ios/Runner/GoogleService-Info.plist`

### Must be generated per environment

- `lib/firebase_options.dart` via:

```bash
flutterfire configure
```

If `lib/firebase_options.dart` is missing or not configured, app startup will fail until you generate it.

## Step-by-Step: Configure Your Own Firebase Project

### 1. Create Firebase project

In Firebase Console create a **new** project (not production).
Enable:

- Authentication (Email/Password)
- Cloud Firestore
- Cloud Functions
- Hosting

If required in your region/plan, enable billing for Functions.

### 2. Link local repo with your Firebase project

From repository root:

```bash
firebase login
firebase use --add
```

Select your Firebase project and set it as default for this local clone.
This creates a local `.firebaserc` file (ignored by Git).

### 3. Generate Flutter Firebase config

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This generates/updates `lib/firebase_options.dart` for your own Firebase project.
It can also write Flutter platform mappings into `firebase.json` locally.

### 4. Install dependencies

```bash
flutter pub get
npm --prefix functions install
```

### 5. Deploy backend in correct order

```bash
firebase deploy --only firestore:rules
firebase deploy --only firestore:indexes
firebase deploy --only functions
```

### 6. Build and deploy web hosting

```bash
flutter build web
firebase deploy --only hosting
```

### 7. Run locally

```bash
flutter run -d chrome
```

Then:

- create first account
- create first organization
- invite team member
- verify invite/join flow

## One-Command Full Deploy (After Verification)

```bash
flutter build web && firebase deploy --only firestore:rules,firestore:indexes,functions,hosting
```

## Suggested Environment Strategy

Use 3 Firebase projects:

- `time-tracker-dev`
- `time-tracker-staging`
- `time-tracker-prod`

Set them per machine/session:

```bash
firebase use dev
# or
firebase use staging
# or
firebase use prod
```

Regenerate `lib/firebase_options.dart` for each environment workflow as needed.

## Troubleshooting

### `FAILED_PRECONDITION` (index required)

```bash
firebase deploy --only firestore:indexes
```

Wait until indexes finish building in Firebase Console.

### `permission-denied`

Usually one of:

- user is not member of selected organization
- wrong active organization in app state
- rules not deployed after changes

Re-deploy rules:

```bash
firebase deploy --only firestore:rules
```

### Functions deploy error

Check:

```bash
npm --prefix functions install
npm --prefix functions run lint
```

## Data Model (Multi-Org)

Main app data is scoped per organization:

- `organizations/{orgId}/members/{uid}`
- `organizations/{orgId}/clients/{clientId}`
- `organizations/{orgId}/projects/{projectId}`
- `organizations/{orgId}/teamMembers/{memberId}`
- `organizations/{orgId}/tags/{tagId}`
- `organizations/{orgId}/timeEntries/{entryId}`
- `organizations/{orgId}/settings/{docId}`
- `organizations/{orgId}/clickup_tasks/{taskId}`

Global user profile:

- `users/{uid}`

## Notes for Contributors

When changing Firestore queries/rules/functions, deploy in order:

1. `firestore:rules`
2. `firestore:indexes`
3. `functions`

If frontend depends on backend changes, deploy `hosting` after `flutter build web`.
