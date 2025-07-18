# Shake & Stir 🍸

A modern, cocktail discovery application built with Flutter. Browse, search, filter, and save your favorite cocktail recipes with a clean, adaptive UI that works beautifully on both mobile and web.

---

## Table of Contents

- [About The Project](#about-the-project)
- [Features](#features)
- [Tech Stack & Architecture](#tech-stack--architecture)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation & Setup](#installation--setup)
- [Code Generation](#code-generation)
- [Roadmap](#roadmap)

## About The Project

Shake & Stir is a Flutter showcase application designed to demonstrate best practices in modern app development. It allows users to explore a vast database of cocktails from TheCocktailDB API, with a strong focus on clean architecture, modularity, performance, and a great offline experience.

## Features

✨ **Browse & Paginate:** Infinitely scroll through cocktails, fetched alphabetically.
🔍 **Advanced Search & Filtering:** Combine a text search with filters for category, glass type, and ingredients to find the perfect recipe.
💾 **Offline Caching:** Cocktails you view are automatically cached, making them available even without an internet connection.
❤️ **Favorites Management:** Save your favorite recipes to local storage for quick, offline access.
🎲 **Random Cocktail Discovery:** Use a "Surprise Me!" button or shake your phone (on mobile) to discover a random cocktail.
📱 **Adaptive UI:** The user interface gracefully adapts between mobile (list views, bottom navigation) and web/tablet (grid views, side navigation).
🌐 **Connectivity Awareness:** The app clearly indicates when you are offline and disables features that require an internet connection.

## Tech Stack & Architecture

This project is built with a strong emphasis on a clean, scalable, and testable architecture.

🧱 **Architecture**
- **Clean Architecture:** Strict separation of concerns between `Domain`, `Data`, and `Presentation` layers.
- **Modular (Feature-First):** Each feature (Browse, Search, Favorites, etc.) is its own independent package, promoting code ownership and scalability.
- **SOLID Principles:** The codebase adheres to SOLID principles for maintainable and extensible code.

⚙️ **Tech Stack**
- **Language:** **Dart**
- **Framework:** **Flutter**
- **State Management:** **`flutter_bloc` / `bloc`** for predictable and scalable state management.
- **Navigation:** **`go_router`** for a robust, URL-based routing strategy suitable for web and mobile.
- **Dependency Injection:** **`get_it`** for managing dependencies and inverting control.
- **Networking:** **`dio`** for powerful and flexible HTTP requests.
- **Local Storage:** **`shared_preferences`** for storing favorites and the offline cache.
- **Serialization:** **`json_serializable`** for automated JSON encoding/decoding.
- **Sensors & Haptics:** **`sensors_plus`** for the mobile shake gesture and Flutter's built-in **Haptic Feedback**.
- **Connectivity:** **`connectivity_plus`** for real-time network status detection.
- **Styling:** **`google_fonts`** and a custom `ThemeData` for a consistent visual identity.

## Project Structure

The project is organized into a multi-package monorepo to enforce architectural boundaries.
shake_and_stir/
├── lib/                  # Main application layer (DI coordination, theme, app entry point)
│   ├── di/
│   └── navigation/
└── packages/
├── core/             # Shared utilities, services (Connectivity), theme, core BLoCs
├── data/             # Repository implementations, API/local data sources, mappers
├── domain/           # Core business logic, models, use cases, repository contracts
├── navigation/       # Abstract route path definitions (AppRoutes)
└── features/
├── cocktail_browser/
├── cocktail_details/
├── favorites/
├── random_cocktail/
└── search_cocktails/

## Getting Started

Follow these instructions to get a local copy up and running for development.

### Prerequisites

- You must have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed (version 3.10 or higher recommended).
- An editor like VS Code or Android Studio.

### Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone https://your-repository-url/shake_and_stir.git
    cd shake_and_stir
    ```

2.  **Install dependencies for all packages:**
    ```bash
    flutter pub get
    ```

3.  **Run the code generators:**
    This project uses code generation for JSON serialization and other tasks. Run the following command from the **root directory**:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
    You may also need to run the localization generator in the `core` package:
    ```bash
    cd packages/core
    flutter gen-l10n
    cd ../..
    ```

4.  **Run the application:**
    -   **For Mobile (Android/iOS):**
        ```bash
        flutter run
        ```
    -   **For Web (IMPORTANT):**
        To avoid CORS errors during development, you must run Chrome with web security disabled.
        ```bash
        flutter run -d chrome --web-browser-flag "--disable-web-security"
        ```

## Code Generation

If you modify any file that has a `.g.dart` or `.freezed.dart` counterpart (e.g., entity classes), you need to re-run the build runner command from the root directory:
```bash
flutter pub run build_runner build --delete-conflicting-outputs

