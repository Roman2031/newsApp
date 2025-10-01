<!--
Short, focused instructions to help AI coding agents be productive in this repo.
Do not add aspirational advice — only document patterns and commands visible in the tree.
-->
# Copilot / Agent quick-start for news_app

Purpose
- This repo is a Flutter application scaffold intended to become a 2‑page News app (see `README.md`).
- Current `lib/main.dart` is the default Flutter counter app; most feature work will replace or extend it.

Big picture (what an agent needs to know)
- Target: Flutter (stable), null-safety (pubspec SDK ^3.9.2). Multi-platform folders exist: `android/`, `ios/`, `web/`, `linux/`, `macos/`.
- Expected architecture (from README): 2 screens (List & Detail), clear separation: API layer -> repository -> UI. Implementations are NOT present yet; add under `lib/` (e.g. `lib/src/api`, `lib/src/repo`, `lib/src/features/news/*`).
- Key existing files to reference:
  - `README.md` — project requirements, API-key handling examples and delivery checklist.
  - `pubspec.yaml` — current dependency list (minimal). Add packages here (e.g. `http`, `flutter_bloc`, `flutter_dotenv`, `url_launcher`) as needed and run `flutter pub get`.
  - `lib/main.dart` — current app entry (placeholder). Replace wiring here to register routes, providers/blocs, and repositories.
  - `analysis_options.yaml` — linting rules (follow when making edits).
  - `test/widget_test.dart` — baseline test file; run with `flutter test`.

Developer workflows & commands (PowerShell examples)
- Install deps / fetch packages:
  ```powershell
  flutter pub get
  ```
- Run app (pass API key at runtime using --dart-define as shown in `README.md`):
  ```powershell
  flutter run --dart-define=NEWS_API_KEY=your_key_here
  ```
- Build APK (example):
  ```powershell
  flutter build apk --dart-define=NEWS_API_KEY=your_key_here
  ```
- Static checks and formatting:
  ```powershell
  flutter analyze
  dart format .
  ```
- Tests:
  ```powershell
  flutter test
  ```
- Git bundle (used by the README for submissions):
  ```powershell
  git bundle create flutter_news.bundle main
  git bundle verify flutter_news.bundle
  ```

Project-specific conventions & patterns (discoverable)
- API key handling: README shows two supported approaches — prefer `--dart-define` and read with:
  ```dart
  const newsApiKey = String.fromEnvironment('NEWS_API_KEY');
  ```
  Or use `flutter_dotenv` and a non-committed `.env` file. Do NOT hard-code keys in source.
- State & navigation: README requires preserving list state when returning from Detail screen — implement scrolling/list state retention (keep repository/cache separate from widget rebuilds).
- Error/empty/loading states: The list screen must show distinct UI states (loading spinner, empty message, and retry for errors). Look at `test/widget_test.dart` for test wiring patterns.
- Packages are intentionally minimal in `pubspec.yaml`; add and pin new packages when you add features and run `flutter pub get`.

Integration points & external deps
- External service: News API (e.g., `newsapi.org`) — network calls will be required. No HTTP client exists in the current code; add one (and update `pubspec.yaml`).
- Platform considerations: Android builds rely on local Android SDK (see `android/local.properties` — not committed). For iOS/macOS builds, Xcode and macOS toolchain are required.

Where to make common changes
- App entry & DI: `lib/main.dart` — set up dependency injection, route table, and top-level providers/blocs here.
- Feature code: create `lib/src/features/news/` with `models/`, `api/`, `repository/`, `widgets/`, `pages/`.
- Tests: add unit/widget tests under `test/` mirroring `lib/` structure.

Quality gates an agent should run before proposing a PR
- `flutter analyze` (no new lints), `dart format .` (consistent formatting), `flutter test` (preferred for CI), and manual smoke run with `flutter run --dart-define=NEWS_API_KEY=...`.

If something is missing or unclear
- The repository is scaffolded: if you need conventions not present here (preferred DI framework, state-management choice), propose one in the PR description and wire a small example (a minimal repository + a simple bloc/provider) so reviewers can evaluate.

Please review this file and tell me if you'd like more examples (sample repo class, sample API client, or CI workflow) added.
