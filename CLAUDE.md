# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter application built as an educational language learning app (Elifba) using clean architecture principles with MobX for state management and dependency injection via GetIt.

## Development Commands

### Setup & Dependencies
```bash
flutter pub get
```

### Code Generation (Required after changes to models/stores)
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Watch Mode for Code Generation
```bash
flutter packages pub run build_runner watch
```

### Build & Run
```bash
flutter run
```

### Quick Build (uses build.sh)
```bash
./build.sh
```

## Architecture

The app follows a layered clean architecture pattern with dependency injection:

### Core Layers
- **Data Layer** (`lib/data/`): Network APIs, local storage, repositories
- **Domain Layer** (`lib/domain/`): Business logic, entities, use cases
- **Presentation Layer** (`lib/presentation/`): UI screens, MobX stores

### Key Components

#### Dependency Injection
- Uses GetIt service locator pattern
- Configuration in `lib/di/service_locator.dart`
- Each layer has its own injection module:
  - `DataLayerInjection.configureDataLayerInjection()`
  - `DomainLayerInjection.configureDomainLayerInjection()`
  - `PresentationLayerInjection.configurePresentationLayerInjection()`

#### State Management
- **MobX** for reactive state management
- Store classes are located in respective feature folders under `presentation/*/store/`
- Generated files (`.g.dart`) are created by `build_runner` - these should not be edited manually

#### Network Layer
- **Dio** for HTTP client with interceptors for auth, logging, and retry
- **Retrofit** for API generation (generates `.g.dart` files)
- API definitions in `lib/data/network/apis/`

#### Local Storage
- **Sembast** for local database
- **SharedPreferences** for simple key-value storage
- **XXTEA** encryption for sensitive data

#### Features
The app includes these main features:
- Authentication (login/register)
- Categories for learning content
- Exercises with memory tracking
- Multi-language support (Arabic fonts included)
- Dark/light theme support

## Project Structure

```
lib/
├── constants/          # App-wide constants (themes, colors, strings)
├── core/              # Core utilities and base classes
│   ├── data/          # Base data layer components
│   ├── domain/        # Base domain components  
│   └── stores/        # Shared MobX stores (error, form)
├── data/              # Data layer implementation
│   ├── network/       # API clients and network logic
│   ├── local/         # Local storage implementations
│   └── repository/    # Repository implementations
├── domain/            # Domain layer (business logic)
│   ├── entity/        # Data models/entities
│   ├── repository/    # Repository interfaces
│   └── usecase/       # Business use cases
├── presentation/      # UI layer
│   ├── */store/       # Feature-specific MobX stores
│   └── */             # Screen widgets per feature
├── utils/             # Utility functions
└── main.dart          # App entry point
```

## Important Notes

### Code Generation
- Run `flutter packages pub run build_runner build --delete-conflicting-outputs` after modifying:
  - MobX store classes
  - JSON serializable models
  - Retrofit API interfaces
- Generated `.g.dart` files should never be manually edited

### Assets
- Multiple Arabic fonts are included in `assets/fonts/`
- Localization files in `assets/lang/` (JSON format)
- Audio assets in `assets/audio/`

### Platform Support
- Supports Android, iOS, Web, macOS, Linux, and Windows
- Platform-specific configurations in respective folders

### Testing
- Test files in `test/` directory
- Widget tests included for basic components