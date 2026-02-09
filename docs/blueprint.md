# Project Blueprint (Drop-In Rules + Templates)

This blueprint captures the rules and structure of the current app so you can create a new project that behaves the same way, with different APIs, DTOs, and Entities. It mirrors the working dog-breeds project.

## Goals

- Keep a strict layer separation: Presentation -> Domain -> Data -> Infrastructure.
- Build features as independent Presentation modules that depend only on Domain/Data + DesignSystem.
- Keep business logic in UseCases and Domain entities, not in Views.
- Make network and persistence swappable via protocols.

## Modules (SPM Targets)

Use the same module names to keep the architecture and imports consistent:

- `DomainLayer`
- `DataLayer`
- `InfrastructureLayer`
- `PresentationLayer_DesignSystem`
- `PresentationLayer_Features_AllScreen`
- `PresentationLayer_Features_DetailsScreen`
- `PresentationLayer_Features_FavoritesScreen`
- `PresentationLayer_Features_MainTabBar`

## Folder Structure

```
Submodules/
  Sources/
    DomainLayer/
    DataLayer/
    InfrastructureLayer/
    PresentationLayer/
      DesignSystem/
      Features/
        AllScreen/
        DetailsScreen/
        FavoritesScreen/
        MainTabBar/
```

### Rule
The folder structure does not define module names; module names are defined in `Submodules/Package.swift`. Targets must point at the proper folder via `path:`.

## Dependency Rules

- Presentation modules depend on:
  - `DomainLayer`
  - `DataLayer`
  - `PresentationLayer_DesignSystem`
  - (other Presentation feature modules only if a UI must embed them)
- `DomainLayer` depends on nothing.
- `DataLayer` depends on `DomainLayer` and `InfrastructureLayer`.
- `InfrastructureLayer` depends on nothing.

## Composition / DI Rules

- The app entry point calls `DIContainerRegistration.registerComponents()`.
- `AppDependencies.resolve()` pulls use cases from the DI container.
- The main root view creates ViewModels by injecting UseCases.

## ViewModel Rules

- ViewModels:
  - Are `@Observable` and `@MainActor` when they update UI state.
  - Expose `state: ViewState<[VM]>` for lists and `ViewState<VM>` for detail.
  - Use UseCases for all async work.
  - Map Domain entities to ViewModels in the Presentation layer.

## Networking Rules

- Use `RequestTypeProtocol` for any request that returns Decodable models.
- `WebService` acts as the entry point to all API calls.
- DTOs exist only in `DataLayer`.
- Map DTOs -> Domain entities via explicit mapping functions.

## Persistence Rules (Favorites)

- Use an actor (`FavoritesManager`) to manage shared state.
- Publish changes via Combine `AnyPublisher`.
- Persist to `UserDefaults` via `PersistenceProtocol`.

## Dog Project Example Flow (Reference)

- UI:
  - `BreedsView` -> `BreedsViewModel` -> `BreedsUseCase` -> `BreedsRepository` -> `WebService` -> `dog.ceo`
- Details:
  - `BreedImagesViewModel` -> `BreedDetailsUseCase` merges remote data + favorites
- Favorites:
  - `FavoritesViewModel` subscribes to `FetchFavoritesUseCase.itemsPublisher`

Use this flow as the template for any new API integration.
