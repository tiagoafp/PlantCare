# PlantCare Base Architecture

This document describes the current app architecture based on the existing SwiftUI views and supporting layers.

## Core Architecture

The app follows a clean MVVM-style architecture with the following responsibilities:

- `RootView` components
  - Initialize view models
  - Provide navigation stacks and destination routing
  - Host sheets and environment adapters
- `View` components
  - Render UI based on view model state
  - Forward user actions to the view model
  - Remain lightweight and declarative
- `ViewModel` components
  - Own feature state, navigation state, and business logic
  - Expose plain input and output values via `@Published`
  - Use dependency injection through `Input` structs
- `Destination` enums
  - Model navigation and sheet destinations in a type-safe way
  - Decouple routing from view implementation

## Current Feature Layers

### App Entry

- `PlantCareApp.swift`
  - Starts SwiftData `ModelContainer`
  - Bootstraps app database
  - Sets the root view to `DashboardRootView`
  - Wraps the app with a palette environment using `PaletteHostView`

### Dashboard

- `DashboardRootView.swift`
  - Contains `NavigationStack(path: $viewModel.path)`
  - Presents `DashboardView`
  - Handles sheet and navigation destination routing
- `DashboardView.swift`
  - Renders the dashboard UI state
  - Displays empty state and primary actions
- `DashboardViewModel.swift`
  - Manages navigation path, sheet destination, and dashboard state
  - Exposes `addPlant()` action

### Plant Type Selector

- `PlantTypeSelectorRootView.swift`
  - Configures API dependencies (`TrefleAPI` and `PlantnetAPI`)
  - Hosts a nested navigation stack for search and selection flows
  - Routes to `AddPlantRootView` when a species is selected
- `PlantTypeSelectorView.swift`
  - Renders search, list, camera capture card, and loading states
  - Uses `.task`, `.searchable`, and `.sheet` for async flows and image capture
- `PlantTypeSelectorViewModel.swift`
  - Fetches plant lists and search results
  - Supports pagination and image-based identification
  - Manages navigation and sheet state through `NavigationPath`

### Add Plant

- `AddPlantRootView.swift`
  - Builds `AddPlantViewModel` with initial input values
  - Provides sheet and navigation destination handling
- `AddPlantView.swift`
  - Renders the add-plant form fields and upload UI
- `AddPlantViewModel.swift`
  - Manages selected plant type, image upload, and nickname input
  - Tracks submit readiness and view state

## Supporting Layers

### Network

- `PlantCare/Configuration/Network/` contains API gateway implementations and endpoints for:
  - `PlantnetAPI`
  - `TrefleAPI`
- Dependencies are injected into feature view models via `Input`.

### Database

- `AppDataBase.swift` and `AppDataBaseBootstrap.swift`
  - Define the SwiftData model container and initial seeding logic
- `PlantRecord.swift`
  - Represents the local persistence model for plants

### Utilities

- `AppSecrets.swift`
  - Stores API keys and secrets
- `ImageStorageManager.swift`
  - Manages local image persistence
- `Strings+AppLocalization.swift`
  - Centralizes localized strings for the app

## Existing Patterns

- Generic view components use protocols, e.g. `AddPlantViewModelProtocol`
- `RootView` components keep navigation/routing separate from UI
- `ViewModel.Input` structs are used for dependency injection
- `NavigationPath` is used for type-safe stack navigation
- API calls are performed with async/await in view models

## Recommended Base Architecture

To keep the architecture scalable:

- Keep `RootView` responsible for routing only
- Keep `View` focused on rendering state and actions
- Keep `ViewModel` responsible for business rules, navigation, state transformations, and service calls
- Introduce a `Feature` folder structure for each flow:
  - `Views/<Feature>/RootView.swift`
  - `Views/<Feature>/<Feature>View.swift`
  - `Views/<Feature>/<Feature>ViewModel.swift`
  - `Views/<Feature>/Models/`
  - `Views/<Feature>/<Feature>Destination.swift`
- Prefer protocols for view models to enable testable views and mockable dependency injection
- Consider adding a lightweight `AppCoordinator` if navigation complexity increases

## Summary Diagram

```
PlantCareApp
  └─ DashboardRootView
       └─ DashboardView
       └─ PlantTypeSelectorRootView
            └─ PlantTypeSelectorView
            └─ AddPlantRootView
                 └─ AddPlantView
```

```
Feature Module
  ├─ RootView
  ├─ View
  ├─ ViewModel
  ├─ Destination
  └─ Models / Adapters
```
