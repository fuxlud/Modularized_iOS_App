# Clean Architecture for SwiftUI

A demo project showcasing the setup of the SwiftUI app with Clean Architecture.

The app uses the [spoonacular.com](https://spoonacular.com/food-api) REST API to show the list of recipes and details about them.

## Key features
* Vanilla **SwiftUI** implementation
* Decoupled **Presentation**, **Business Logic**, and **Data Access** layers
* **Modularized** with SPM - Designed for scalability. It can be used as a reference for building large production apps
* Simple yet flexible networking layer built on Generics

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
 - Project with 1 package that describes all the submodules.
This project utilized the third approach. All the modules described in the Package file and can be used in other parts of the code if imported
 <img width="281" alt="Screenshot 2024-06-24 at 22 38 10" src="https://github.com/fuxlud/Clean-Architecture-SwiftUI/assets/1950116/056b5ad4-72d9-4b3d-b62f-dba06456c96d">
 <img width="719" alt="Screenshot 2024-06-24 at 22 37 50" src="https://github.com/fuxlud/Clean-Architecture-SwiftUI/assets/1950116/cd416171-3040-4779-ab19-0b3b499d0115">

## Project Overview

In this project, I am exploring new technologies for building mature applications, diverging from the traditional UIKit. Here’s the stack I’m using:

- **SwiftUI** instead of UIKit.
- **Swift Testing** using XCtest.
- **Navigation Stack** to manage and navigate SwiftUI and UIKit views, as opposed to using UIKit containers.

## FAQ

### Why is there a UseCase and Repository?

- **UseCase:** Acts as the orchestrator.
- **Repository:** Handles data fetching.

### Why should the UseCase consume the Repository and not the web service and persistence directly?

UseCase is agnostic to the data fetching implementation. Only the repositories are aware of the fetching details. Additionally it's optimizing the dependency graph.

### Why do we need Entity and DTO?

- **Entities:** Encapsulate data and behavior through the application.
- **DTOs:** Lightweight objects used for transferring data from the network and persistence layers without behavior.

### Where should data be stored: in the Repository or ViewModel?

For states accessed in multiple places in the app, data is stored in the Repository and the ViewModel is notified using Combine. However, 90% of scenarios do not require this complexity. Simple data transfer through the Repository and Use Case to the ViewModel suffices. Storing data in the Repository and responding to it with Combine for these cases would be overengineering.

### Why do I have a ModelProtocol package?

While creating the previews module, I needed to import only the DomainMock. However, the entity mock wasn't recognized without importing the entire Domain. To avoid this, I separated the domain declaration from its implementation. This allows importing only the domain protocol needed, without the entire Domain.
