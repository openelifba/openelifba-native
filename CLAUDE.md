# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter application built as an educational language learning app (Elifba) using clean architecture principles with MobX for state management and dependency injection via GetIt.

## Development Commands

### Setup & Dependencies
```bash
flutter pub get
```

### Code Generation
Run after modifying MobX stores, JSON models, or Retrofit APIs:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

Watch mode (auto-regenerates on file changes):
```bash
flutter packages pub run build_runner watch
```

### Build & Run
```bash
flutter run
```

Quick build and run (generates code first):
```bash
./build.sh
```

### Testing
```bash
flutter test
```

## Architecture

The app follows a layered clean architecture pattern with dependency injection:

### Core Layers
- **Data Layer** (`lib/data/`): Network APIs, local storage, repositories
- **Domain Layer** (`lib/domain/`): Business logic, entities, use cases
- **Presentation Layer** (`lib/presentation/`): UI screens, MobX stores

### Key Components

#### Dependency Injection
- Uses GetIt service locator pattern (accessed via `getIt` global instance)
- Configuration in `lib/di/service_locator.dart` initializes all layers sequentially
- Each layer has its own injection module:
  - `DataLayerInjection` → `LocalModule`, `NetworkModule`, `RepositoryModule`
  - `DomainLayerInjection` → Use cases
  - `PresentationLayerInjection` → Stores and UI dependencies
- All dependencies are registered as singletons during app initialization in `main.dart`

#### State Management
- **MobX** for reactive state management
- Store classes are located in respective feature folders under `presentation/*/store/`
- Generated files (`.g.dart`) are created by `build_runner` - these should not be edited manually

#### Network Layer
- **Dio** HTTP client with interceptor chain (order matters):
  1. `AuthInterceptor` - Adds Bearer token to requests
  2. `AuthRetryInterceptor` - Retries failed auth requests with token refresh
  3. `ErrorInterceptor` - Handles network errors and broadcasts via EventBus
  4. `LoggingInterceptor` - Logs requests/responses
- **Retrofit** for type-safe API generation (generates `.g.dart` files)
- API definitions in `lib/data/network/apis/`: `UserApi`, `CategoryApi`, `ExercisesApi`, `MemoryApi`
- Network configuration constants in `lib/data/network/constants/endpoints.dart`

#### Local Storage
- **Sembast** for local database
- **SharedPreferences** for simple key-value storage
- **XXTEA** encryption for sensitive data

#### Features & Screens
The app includes these main features organized by presentation module:
- **Auth** (`presentation/auth/`) - Login/register with JWT token storage
- **Home** (`presentation/home/`) - Main navigation
- **Category** (`presentation/category/`) - Browse learning categories
- **Exercise** (`presentation/exercise/`) - Interactive exercises with audio playback
- **Splash** (`presentation/splash/`) - App initialization screen
- Multi-language support with localization files in `assets/lang/`
- Dark/light theme support with custom theme extensions

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
Generated `.g.dart` files should never be manually edited. Run code generation after modifying:
- MobX store classes (annotated with `@observable`, `@action`, `@computed`)
- JSON serializable models (annotated with `@JsonSerializable()`)
- Retrofit API interfaces (annotated with `@RestApi()`)

### App Initialization Flow
1. `main.dart` initializes Flutter bindings and error handling
2. `ServiceLocator.configureDependencies()` sets up all DI layers
3. `MyApp` widget launches with pre-configured dependencies
4. All stores and services are available via `getIt<Type>()`

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