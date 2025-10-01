# news_app

A new Flutter project.

## Getting Started

## Flutter version
    3.35.4

## env/keys
    API_KEY= 6e2c4aacf87c4ff0b4c1bde9cfbda7d8
    BASE_URL= https://newsapi.org/v2/top-headlines


## Architecture overview
    Purpose: a 2‑screen News app (List + Detail).
    Components:
    API layer: Dio client that calls a News API (e.g., newsapi.org). Converts JSON -> domain models.
    Repository layer: exposes methods like Future<List<Article>> fetchTopHeadlines({page, pageSize}), caches results in-memory (or simple local cache) and abstracts paging/error handling.
    Presentation layer (UI): Widgets / pages that consume repository via a state manager (Bloc). List screen shows summaries (title, date, thumbnail); Detail screen shows full content + open-in-browser action.
    App entry / DI: main.dart — should register repositories and top-level state blocs and set up routes.
    Data flow: UI -> calls Bloc -> calls Repository -> calls API client -> returns domain models -> UI renders.

## Packages overview
    dio: ^5.9.0
    equatable: ^2.0.7
    flutter_dotenv: ^6.0.0
    url_launcher: ^6.3.2
    flutter_bloc: ^9.1.1
    intl: ^0.20.2

## Assumptions/trade-offs
1. API Provider & Data Shape
Assumption: Using a public News API (e.g., newsapi.org) with fields like title, description, url, urlToImage, publishedAt, and source.name.
Trade-off: Easy initial integration, but swapping providers may require changing both API client logic and model mapping.

2. API Key Handling
Assumption: API keys is not be hardcoded.
Trade-off: Secure and CI-friendly, but adds slight build complexity and requires clear documentation in README.

3. Dependencies
Assumption: Minimal baseline dependencies; add only what's needed per feature.
Trade-off: Keeps project lightweight, but requires manual dependency management as features grow.

4. App Structure: List → Detail
Assumption: Two-screen app; list state (including scroll position) must persist when navigating back.
Trade-off: Better UX, but requires shared state (e.g., top-level Bloc or repository) to avoid re-fetching.

5. State Management
Assumption: Used Bloc pattern state management.
Trade-off: Bloc offers better testability and structure at the cost of extra boilerplate.

6. UI States (Loading / Empty / Error)
Assumption: List screen must clearly handle and show all 3 states.
Trade-off: Improves UX and testability, but requires creating reusable widgets and conditional logic.

7. Image Handling
Assumption: Images may be missing or large; use caching and placeholders.
Trade-off: Using cached_network_image improves performance and UX, but adds a dependency and placeholder assets.


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
