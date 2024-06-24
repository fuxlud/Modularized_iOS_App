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

