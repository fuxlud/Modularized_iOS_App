# Modulazied iOS App Tamplate

A demo for trying out new APIs and iOS ideas.
This project showcases the setup of a SwiftUI app with modularized Clean Architecture.
It can be used as a starting point for a project. Simply delete unneeded targets/packages and rename entities as needed.

## Key features

* Vanilla **SwiftUI** implementation
* Decoupled **Presentation**, **Business Logic**, and **Data Access** layers
* **Modularized** with SPM - Designed for scalability. It can be used as a reference for building large production apps
* Simple yet flexible vanila **Networking Layer** built on Generics
* Unit Test Coverage with **Swift Testing**
* Reactive State Management of shared state with **Combine**

## Tech Backlog
* Replace Combine publisher with AsyncStream to avoid @preconcurrency

**Now**
* Add Combine to the first tab.
* Add a clear user-facing error for TLS/ATS failures (explain TLS inspection).
* Remove the unused x-api-key header for dog.ceo (or make it host-specific).
* Centralize network error -> ErrorEntity mapping for consistent UI messages.
* Add non-interesting files to .gitignore (breakpoints, user interface state).

**Next**
* Add in-memory cache for breeds list to avoid refetch on tab switch.
* Improve image loading with caching + retry.
* Add loading skeletons for list/grid screens.

**Later**
* Unit test BreedDetailsUseCase favorite-merge logic.
* Unit test FavoritesManager persistence (save/load/toggle).
* Snapshot tests for BreedsView and BreedImagesScreen.
* Remove or document unused recipe models in MainApplication/Models.
* Add a small architecture diagram to README.
* Add a short perf note in README about async let.
  
