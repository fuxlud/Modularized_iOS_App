# Template iOS App

A demo project showcasing the setup of the SwiftUI app with modularized Clean Architecture.
Can be used as a starting point for a project or a home assignment.

## Key features

* The app uses the [spoonacular.com](https://spoonacular.com/food-api) REST API to show the list of recipes and details about them.
* Vanilla **SwiftUI** implementation
* Decoupled **Presentation**, **Business Logic**, and **Data Access** layers
* **Modularized** with SPM - Designed for scalability. It can be used as a reference for building large production apps
* Simple yet flexible vanila **Networking Layer** built on Generics
* Unit Test Coverage with **Swift Testing**

## Inspiration
* [The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) on the Clean Coder Blog
* [Modularization](https://www.pointfree.co/episodes/ep171-modularization-part-1) by PointFree
* [MVVM + Clean + Modularized](https://www.aleksasimic.com/product/mvvm-clean-modularized-architecture) by Aleksa Simic
* [Clean Architecture and MVVM on iOS](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3) by Oleh Kudinov
* [How to modularize Monolith iOS App](https://vbat.dev/how-to-modularize-monolith-ios-app) by Vitaly Batrakov

## Modularization
Few words on the [Benefits of Modularization](https://www.ludafux.com/post/the-benefits-of-modularization)

## ViewState
Few words on the [Consolidated ViewState](https://www.ludafux.com/post/consolidated-viewstate)

## Tech Stack

Mature applications usually developed with UIKit, as this is a pet project, I allow myself to experiment with the latest APIs.
- **SwiftUI** as opposed to UIKit.
- **Swift Testing** as opposed to XCtest.
- **NavigationStack** to manage and navigate as opposed to UIKit Containers.
- **async/await + actors** vs delegation and blocks


