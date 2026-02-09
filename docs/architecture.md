# Architecture

This document provides a concise, diagram-first overview of the Modularized iOS App template. The diagrams are derived from the current codebase.

## System Overview

```mermaid
flowchart TB
  subgraph Apps
    MainApp["MainApplication\n(ApplicationNameApp)"]
    PreviewApp["CardPreviewApp\n(CardPreviewApp)"]
  end

  subgraph Presentation
    DesignSystem["DesignSystem"]
    AllBreeds["Features_AllBreeds"]
    Details["Features_DetailsScreen"]
    Favorites["Features_FavoritesScreen"]
    MainTab["Features_MainTabBar"]
  end

  subgraph Domain
    DomainLayer["DomainLayer"]
  end

  subgraph Data
    DataLayer["DataLayer"]
  end

  subgraph Infra
    InfraLayer["InfrastructureLayer"]
  end

  MainApp --> MainTab
  MainApp --> DataLayer

  PreviewApp --> AllBreeds
  PreviewApp --> DomainLayer

  MainTab --> AllBreeds
  MainTab --> Favorites
  MainTab --> Details
  MainTab --> DesignSystem
  MainTab --> DomainLayer
  MainTab --> DataLayer

  AllBreeds --> Details
  AllBreeds --> DesignSystem
  AllBreeds --> DomainLayer
  AllBreeds --> DataLayer

  Favorites --> Details
  Favorites --> DesignSystem
  Favorites --> DomainLayer
  Favorites --> DataLayer

  Details --> DesignSystem
  Details --> DomainLayer
  Details --> DataLayer

  DataLayer --> DomainLayer
  DataLayer --> InfraLayer
```

## Layered Architecture (Conceptual Flow)

```mermaid
flowchart TB
  UI["Presentation\nViews + ViewModels"]
  Domain["Domain\nEntities + UseCases + Protocols"]
  Data["Data\nRepositories + DTOs"]
  Infra["Infrastructure\nNetworking + Persistence"]

  UI --> Domain
  UI --> Data
  Data --> Domain
  Data --> Infra
```

## App Startup and Dependency Wiring

```mermaid
flowchart LR
  App["ApplicationNameApp.init()"] --> Register["DIContainerRegistration.registerComponents()"]
  Register --> DI["DIContainer.shared"]

  DI --> UseBreeds["BreedsUseCase"]
  DI --> UseDetails["BreedDetailsUseCase"]
  DI --> UseFavorites["FetchFavoritesUseCase"]
  DI --> UseFavoriting["FavoritingUseCase"]

  UseBreeds --> RepoBreeds["BreedsRepository"]
  UseDetails --> RepoDetails["BreedDetailsRepository"]
  UseFavorites --> RepoDetails
  UseFavoriting --> RepoDetails

  RepoBreeds --> Web["WebService"]
  RepoDetails --> Web
  RepoDetails --> FavMgr["FavoritesManager.shared"]
```

## Main Flow: All Breeds

```mermaid
sequenceDiagram
  actor User
  participant View as BreedsView
  participant VM as BreedsViewModel
  participant UC as BreedsUseCase
  participant Repo as BreedsRepository
  participant Web as WebService
  participant Router as NetworkRouter
  participant API as dog.ceo

  User->>View: Open All Breeds
  View->>VM: executeOnceOnAppear
  VM->>UC: getAllBreeds()
  UC->>Repo: getAllBreeds()
  Repo->>Web: getAllBreeds()
  Web->>Router: request(BreedRequest)
  Router->>API: HTTP GET /api/breeds/list/all
  API-->>Router: JSON
  Router-->>Web: Data
  Web-->>Repo: [BreedDTO]
  Repo-->>UC: [BreedEntity]
  UC-->>VM: [BreedEntity]
  VM-->>View: state = idle([BreedViewModel])
```

## Details Flow (Images + Favorites Merge)

```mermaid
sequenceDiagram
  actor User
  participant View as BreedImagesScreen
  participant VM as BreedImagesViewModel
  participant UC as BreedDetailsUseCase
  participant Repo as BreedDetailsRepository
  participant Web as WebService
  participant Router as NetworkRouter
  participant API as dog.ceo
  participant Fav as FavoritesManager

  User->>View: Open Details
  View->>VM: onAppear
  VM->>UC: getBreedDetails(breedName)
  UC->>Repo: getRemoteBreedDetails(breedName)
  Repo->>Web: getBreedDetails(breedName)
  Web->>Router: request(BreedImagesRequest)
  Router->>API: HTTP GET /api/breed/{name}/images
  API-->>Router: JSON
  Router-->>Web: Data
  Web-->>Repo: [BreedDetailsDTO]
  Repo-->>UC: [BreedDetailsEntity]

  UC->>Repo: fetchFavorites()
  Repo->>Fav: fetchFavorites()
  Fav-->>Repo: Set<BreedDetailsDTO>
  Repo-->>UC: Set<BreedDetailsEntity>
  UC-->>VM: [BreedDetailsEntity with isFavorite]
  VM-->>View: state = idle([BreedImageViewModel])
```

## Favorites Toggle Flow

```mermaid
sequenceDiagram
  actor User
  participant View as BreedImageView
  participant VM as BreedImageViewModel
  participant UC as FavoritingUseCase
  participant Repo as BreedDetailsRepository
  participant Fav as FavoritesManager
  participant Store as UserDefaults

  User->>View: Tap heart
  View->>VM: likeButtonTapped()
  VM->>UC: toggleLiking(breedDetails)
  UC->>Repo: toggleLiking(breedDetails)
  Repo->>Fav: toggleLiking(breedDetailsDTO)
  Fav->>Store: persist favorites (JSON)
  Fav-->>Repo: publishes updated favorites
```

## Networking Pipeline

```mermaid
flowchart LR
  RequestType["RequestTypeProtocol.execute()"] --> Router["NetworkRouter.request()"]
  Router --> Build["buildRequest(RequestProtocol)"]
  Build --> URLReq["URLRequest"]
  URLReq --> URLSession["URLSession.data(fromURLRequest)"]
  URLSession --> Data["Data"]
  Data --> Decode["JSONDecoder.decode(ResponseType)"]
  Decode --> DTO["DTO(s)"]
```

## Data Mapping (DTO -> Domain)

```mermaid
flowchart LR
  BreedDTO -->|toBreedEntity| BreedEntity
  BreedDetailsDTO -->|toBreedDetailsEntity| BreedDetailsEntity
  BreedDetailsEntity -->|toBreedDetailsDTO| BreedDetailsDTO
```

## Domain Model

```mermaid
classDiagram
  class BreedEntity {
    +String name
    +[BreedDetailsEntity] breedImages
  }

  class BreedDetailsEntity {
    +URL url
    +Bool isFavorite
  }

  class ErrorEntity {
    <<enum>>
    +general
  }

  BreedEntity "1" --> "0..*" BreedDetailsEntity
```

## ViewState Lifecycle

```mermaid
stateDiagram-v2
  [*] --> idle
  idle --> loading : fetch
  loading --> idle : success
  loading --> error : failure
  error --> loading : retry
```
