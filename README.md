📱 Pokedex App (SwiftUI)

A modern iOS Pokedex application built with SwiftUI, following MVVM architecture and clean code principles.
The app allows users to search and explore Pokémon details using the public PokeAPI.

🚀 Features:

🔍 Search Pokémon by name, ID or type
📋 Dynamic Pokémon list
📄 Detail view with:
Images (default & shiny)
Pokémon types
Base stats visualization
🔄 Navigation between list and detail views
🎯 Tap on a Pokémon type to filter the list automatically

🛠️ Tech Stack:

SwiftUI
MVVM Architecture
Async/Await (Concurrency)
Combine (@Published)
NavigationStack (iOS 16+)
Kingfisher (for remote image loading)

📦 Dependencies:

Kingfisher
Used for efficient image downloading and caching.
📡 API:

This app uses the public API:

https://pokeapi.co/

📱 Minimum Requirements:
iOS 26.2+
Xcode latest version recommended

🧠 Architecture:

The project follows a simplified Clean Architecture + MVVM approach:


Pokedex


    ├── Core
    |    ├── Constants
    |    ├── Extensions
    |    └── Components
    │
    ├── Data
    │   └── Network
    │
    ├── Domain
    │   └── Models
    │
    └── Features
        └──├── Views
           ├── ViewModel
           └── Models
           
View → UI layer (SwiftUI)
ViewModel → State & business logic
Data layer → API calls
Core → Shared UI components & utilities

🔄 App Flow:

The app loads an initial list of Pokémon.
The user can:
Search by name or ID
Filter by type
Selecting a Pokémon navigates to the detail screen.
In the detail view:
The app fetches Pokémon details
Displays images, stats, and types
Tapping a Pokémon type:
Returns to the list
Automatically filters Pokémon by that type

🖼️ Image Handling:

Images are loaded using Kingfisher, which provides:

Async image loading
Caching
Placeholder support
Error handling
⚙️ Future Improvements
Pagination support
Offline caching
Unit testing (ViewModel & UseCases)
Better error handling UI

👨‍💻 Author:

Rigoberto Dominguez
Mobile Developer (iOS & Android)
