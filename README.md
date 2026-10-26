# AfPay Companion

**Your Guide to Digital Payments in Afghanistan**

AfPay Companion is a public-facing, multilingual FinTech information and utility product for finding payment services, understanding payment issues, learning safer digital-payment practices, and preparing support information.

> AfPay Companion is an independent informational application. It is not automatically an official application of APS, DAB, a bank, EMI, payment institution, or government organization.

## Current implementation

Phase 1 and the Phase 2 foundation are implemented:

- Original AfPay Companion visual identity and Material 3 design system
- Responsive onboarding, Home, Explore, Map boundary, Help, and Profile
- English, Dari, and Pashto ARB localization with live switching and RTL support
- Light, dark, and system themes
- GoRouter stateful bottom navigation
- Riverpod preferences and favorites
- Organization domain model and repository boundary
- Bank, EMI, and payment-institution directories
- Global organization/service search
- Organization details, source/freshness status, favorites, and reporting entry point
- Loading, empty, error, and clearly labeled development-data states
- Unit tests and GitHub Actions validation

The included organization records are fictional development samples and must not be treated as operational information.

## Repository layout

```text
AfPayCompanion/
├── mobile/       Flutter application
├── docs/         Architecture, security, API and delivery documentation
├── backend/      Reserved for Phase 7 FastAPI service
├── admin/        Reserved for Phase 8 React administration portal
└── .github/      CI workflows
```

## Mobile setup

Requirements: Flutter 3.47+, Dart 3.13+, Android SDK or Xcode.

```bash
cd mobile
flutter pub get
flutter gen-l10n
flutter analyze
flutter test
flutter run
```

Build Android:

```bash
flutter build apk --release
```

## Environments

The product will support `development`, `staging`, and `production` configuration. Phase 1 uses an injected mock repository. Real endpoints will be provided using compile-time environment configuration without committing credentials.

## Security and privacy

Never collect or store PINs, CVVs, OTPs, card passwords, banking credentials, private keys, or institutional credentials. Location is requested only in context and is not continuously tracked. See [security.md](docs/security.md).

## Testing

```bash
cd mobile
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

## Roadmap

See [roadmap.md](docs/roadmap.md). Backend, admin, verified map data, FCM, and production deployment are deliberately phased and are not represented by fake integrations.

## Contributing

Use a feature branch, preserve localization and accessibility, add tests for business logic, and ensure formatting/analyzer/tests pass. Public data must include a source, source URL, verification status, and verification date.

## Screenshots

Screenshots will be added after device QA for the first tagged mobile release.
