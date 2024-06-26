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

which technology to use? Yes indeed, in nowadays still the mature applications are written with UI kit, and swiftui. But having a side project is an excellent opportunity to try out new technologies. So in this one I'm gonna work with SwiftUI as opposed to UI kid. Testing is supposed to exit test. And navigation stack as opposed to U I kid container containing and navigating SwiftUI and UI views.
Use case: orcastrator
Repository: fetchers

Why use case consuming the repository and not web service and persistence directly, so the use case will be agnostic to the implementation of fetching and only repositories will be aware of it. Optimazation of the dependency graph.
Why do we need Entity and DTO? Entities encapsulate both data and behavior of real-world objects in an application. DTOs are lightweight objects used solely for transferring data from the network and persiastance, without containing behavior.

Should we start with data in repository or in view model?
in cases where a state should be accessed in several places in the app, it's a good idea to hold it in the repository and let the ViewModel be notified with Combine. This is an important and interesting use case to handle, and I’ll tackle it in this side project

 90% of the scenarios in the app do not need that kind of complexity and transferring data from the server or persistence to the ViewModel through the repository and use case is enough. Storing it in the repository and utilizing Combine would be overengineering.

why do I have mod protocol? When I was creating the previews module I needed to import only the domain mock. Unfortunately, the entity mock was not recognized without importing domain. I was expecting domain to be recognized without this import, but a unfortunately, expert has troubles cascading import. So in order for me not to import the entire domain into the previews module. I am separating between domain declaration and its implementation. So when I am importing the needed domain, I can import only the domain protocol.
