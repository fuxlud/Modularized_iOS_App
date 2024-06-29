# Clean Architecture for SwiftUI

A demo project showcasing the setup of the SwiftUI app with Clean Architecture.

The app uses the [spoonacular.com](https://spoonacular.com/food-api) REST API to show the list of recipes and details about them.

## Key features

* Vanilla **SwiftUI** implementation
* Decoupled **Presentation**, **Business Logic**, and **Data Access** layers
* **Modularized** with SPM - Designed for scalability. It can be used as a reference for building large production apps
* Simple yet flexible vanila **Networking Layer** built on Generics
* Unit Test Coverage with **Swift Testing**


## Roadmap

2. CI/CD
3. SwiftFormater, SwiftLint, Danger
4. OSLog instead of NetworkLogger
5. Latest Observation (SWiftUI)
6. Detail screen with proper navigation
7. Sandbox/Feature app
8. Dependency Container
9. Add and Edit screen with SwiftData
10. Search
11. Filter
12. Localization
13. Cool animations 

## Relevant Articles 
* [The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) on the Clean Coder Blog
* [Modularization](https://www.pointfree.co/episodes/ep171-modularization-part-1) by PointFree
* [MVVM + Clean + Modularized](https://www.aleksasimic.com/product/mvvm-clean-modularized-architecture) by Aleksa Simic
* [Clean Architecture and MVVM on iOS](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3) by Oleh Kudinov
* [How to modularize Monolith iOS App](https://vbat.dev/how-to-modularize-monolith-ios-app) by Vitaly Batrakov

## Modularization
There are a few approaches when approaching modularization: 
 - Workspace with multiple projects (usually paired with Tuist)
 - Project with multiple packages
 - Project with one package that describes all the submodules.
This project utilized the third approach. All the modules described in the Package file and can be used in other parts of the code if imported
 <img width="281" alt="Screenshot 2024-06-24 at 22 38 10" src="https://github.com/fuxlud/Clean-Architecture-SwiftUI/assets/1950116/056b5ad4-72d9-4b3d-b62f-dba06456c96d">
 <img width="719" alt="Screenshot 2024-06-24 at 22 37 50" src="https://github.com/fuxlud/Clean-Architecture-SwiftUI/assets/1950116/cd416171-3040-4779-ab19-0b3b499d0115">

## Project Overview

Mature applications usually developed with UIKit, as this is a pet project, I allow myself to experiment with the latest APIs.
- **SwiftUI** as opposed to UIKit.
- **Swift Testing** as opposed to XCtest.
- **NavigationStack** to manage and navigate as opposed to UIKit Containers.
- **async/await + actors** vs delegation and blocks

## FAQ

### Why are there UseCase and Repository?

- **UseCase:** Acts as the orchestrator.
- **Repository:** Handles data fetching.

### Why should the UseCase consume the Repository and not directly the WebService and Persistence directly?

UseCase is agnostic to the data fetching implementation. Only the repositories are aware of the fetching details. Additionally to optimize the dependency graph.

### Why are there Entity and DTO?

- **Entities:** Encapsulate data and behavior through the application.
- **DTOs:** Lightweight objects used for transferring data from the network and persistence layers without behavior.

### Where should data be stored: in the Repository or ViewModel?

For states accessed in multiple places in the app, data is stored in the Repository and the ViewModel is notified using **Combine**. However, 90% of scenarios do not require this complexity. Simple data transfer through the Repository and UsesCases to the ViewModel suffices. Storing data in the Repository and responding to it with Combine for these cases would be overengineering.

### Why ModelProtocol package? (Todo, implement down the line)

While creating the previews module, I intended to import only the DomainMock. However, the EntityMock wasn't recognized without importing the entire Domain. To avoid this, I separated the domain declaration (ModelProtocol) from its implementation. This allows importing only the ModelProtocol needed, without the entire Domain, which might become much bigger down the line.
