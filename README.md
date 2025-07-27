# 📂 File Listing with FileManager

A native iOS app that lists and displays files from the Documents directory using **UIKit**, **MVVM**, and **Clean Architecture** principles.

## 🚀 Features

- List all files in the app’s Documents directory
- View file details: size, creation date, type
- Pull-to-refresh functionality
- Icons for common file types (PDF, JPG, MP4, etc.)
- Coordinator-based navigation for clean flow

## 🧠 Architecture

- **MVVM** for presentation logic
- **Coordinator Pattern** for navigation
- **Repository Pattern** for data access
- **Clean Architecture** with separated layers:
  - `Presentation` (Views, ViewModels, Coordinators)
  - `Domain` (Entities, Use Cases, Repositories)
  - `Data` (FileRepository implementation)

## 📱 UI Highlights

- Custom UITableViewCells for file items
- Detail screen with formatted metadata and icons
- Empty state and graceful refresh handling

## 📂 Project Structure

```
File Listing/
├── Domain/
│   ├── Entities/
│   │   └── FileItem.swift              # Core file entity with FileType enum
│   ├── Repositories/
│   │   └── FileRepositoryProtocol.swift # Repository contract
│   └── UseCases/
│       ├── GetFilesUseCase.swift       # Fetch files use case
│       └── GetFileDetailsUseCase.swift # Fetch file details use case
├── Data/
│   └── Repositories/
│       └── FileRepository.swift        # FileManager implementation
├── Presentation/
│   ├── Coordinators/
│   │   ├── Coordinator.swift           # Base coordinator protocol
│   │   ├── RootCoordinator.swift       # App-level coordinator
│   │   └── FileListCoordinator.swift   # Feature-level coordinator
│   ├── ViewModels/
│   │   ├── FileListViewModel.swift     # File list business logic
│   │   └── FileDetailViewModel.swift   # File detail business logic
│   └── Views/
│       ├── FileListViewController.swift    # File list UI
│       ├── FileDetailViewController.swift  # File detail UI
│       └── FileTableViewCell.swift     # Custom table cell
├── Utils/
│   └── SampleFileGenerator.swift       # Helper for creating test files
├── Delegates/
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
└── ViewController.swift                # App entry point
```

## 🧪 Tests

- ViewModel logic
- File reading and formatting
- Sample file generator

## 🛠️ Requirements

- iOS 13+
- Swift 5+
- Xcode 12+

## 🧰 Setup

```bash
git clone https://github.com/alimadhoun/FileListingApp
open "File\ Listing.xcodeproj"
