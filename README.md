# HOMECENTER TEST APP

Sample app for product search, paginated listing, and shopping cart integration. Built with Flutter using Clean Architecture and BLoC for state management.

## Architecture

Three main layers plus infrastructure configuration:

- **Presentation**
  - UI Widgets (Pages and Widgets): `features/products/presentation/pages`, `widgets`
  - State management with `flutter_bloc`: `bloc/products` and `bloc/shopping_cart`
  - Simple navigation via `Navigator`

- **Domain**
  - Immutable entities: `Product`, `ProductCart`
  - Use cases: `GetProducts`, `GetAllProductsOnShoppingCart`, `AddProductToShoppingCart`, `RemoveProductFromShoppingCart`, `ClearShoppingCart`, `UpdateQualityProductOnShoppingCart`
  - Repository interfaces: `ProductsRepository`, `ShoppingCartRepository`

- **Data**
  - Data sources
    - Remote: `Dio` + `dio_cache_interceptor` (base `DioSource` and `ProductsRemoteSource`)
    - Local: simple cart storage `ShoppingCartLocalDatabase`
  - Concrete repositories: `ProductsRepositoryImple`, `ShoppingCartRepositoryImple`
  - Models: `ProductModel` (JSON -> Entity mapping)

- **Core**
  - Dependency Injection with `get_it`: `core/dependencys/injection_get_it.dart`
  - Theme and styles: `core/theme`
  - App root: `core/app.dart`

Key flow:

1) UI dispatches BLoC events (e.g., `LoadProducts`, `AddProductToShoppingCartEvent`).
2) BLoC executes domain use cases.
3) Use cases query repositories.
4) Repositories orchestrate data sources and return Entities.
5) BLoC emits states for UI rendering.


## Getting Started

### Prerequisites

- Flutter SDK 3.x (recommended)
- Dart SDK matching your Flutter version
- Android Studio / Xcode for emulators or physical devices
- Dependencies (pubspec):
  - flutter_bloc
  - equatable
  - dio
  - dio_cache_interceptor
  - http_cache_drift_store
  - path_provider
  - get_it
  - stream_transform
  - bloc_concurrency
  - (dev) flutter_test, bloc_test, mocktail

### Installation

- Clone the repository
  - `git clone <repo-url>`
  - `cd homecenter_flutter`

- Install dependencies
  - `flutter pub get`

- Generate code (before running)
  - One-off: `flutter pub run build_runner build --delete-conflicting-outputs`
  - Watch (optional): `flutter pub run build_runner watch --delete-conflicting-outputs`

- Run the app
  - `flutter run` (select a device/emulator)

- Run tests
  - All: `flutter test`
  - Specific folder: `flutter test test/features/products`

### Project Structure (overview)

```
lib/
├─ core/                                 # Core files
│  ├─ dependencys/                       # Dependency injection files (get_it)
│  ├─ theme/                             # Theme and visual styles
│  ├─ app.dart                           # App root (MaterialApp)
│
├─ features/                             # Features (each feature follows the same structure)
│  └─ products/
│     ├─ data/                           # Data layer
│     │  ├─ datasource/                  # Remote (API) and Local data sources
│     │  │   ├─ remote/
│     │  │   └─ local/
│     │  ├─ models/                      # DTOs / data models
│     │  └─ repositories/                # Repository implementations
│     │
│     ├─ domain/                         # Business logic layer
│     │  ├─ entities/                    # Core business entities
│     │  ├─ repositories/                # Repository interfaces
│     │  └─ usecases/                    # Business use cases
│     │
│     └─ presentation/                   # UI layer
│        ├─ bloc/                        # State management (BLoC pattern)
│        ├─ pages/                       # Screen widgets
│        └─ widgets/                     # Reusable UI components
│
└─ main.dart                             # App entry point
```
