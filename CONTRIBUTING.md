# Contributing Guide

Thank you for considering contributing to our iOS application. This document provides guidelines for contributing to ensure a consistent and efficient approach to extending the application while adhering to the established MVVM architecture.

## Project Structure

The project follows the Model-View-ViewModel (MVVM) architecture pattern closely to ensure code separation, maintainability, and testability. Here's a brief overview of the project's directory structure relevant to MVVM:

- `Models`: Contains the data access layer and business logic.
- `Views`: UI components, including storyboards, XIBs, and SwiftUI views.
- `ViewModels`: Bridges between models and views, handling UI logic.
- `Services`: Contains services like network requests, database access, etc.
- `Util`: Utilities and helpers, including extensions and theme management.

## Adding New Functionalities

When adding new features, ensure they fit within the MVVM framework:

### Nota Bene: Screens

- **Location**: `CartingApp/Core`
- **Responsibility**: Define the Screen groups within which the screen logic will persist. Each screen group should encapsulate all related components necessary for a complete user interface section of the application. This includes mandatory `Views`, `ViewModels`, and optional `Services`.
- **Guideline**: Organize the screen groups in a way that each represents a distinct functional area of the application. For example, an "Authentication" group might include `LoginView`, `RegistrationView`, `LoginViewModel`, `RegistrationViewModel`, and optionally, an `AuthService` to handle authentication with a backend service.
  
  Ensure each screen is self-contained with its necessary components for easier navigation, maintenance, and scalability. When adding a new screen:
  
  1. **Create a New Group**: Under `CartingApp/Core`, create a new group for the screen if it represents a new functional area.
  2. **Implement Views**: Add SwiftUI views to the `Views` subdirectory within the screen group.
  3. **Develop ViewModels**: Add corresponding ViewModels in the `ViewModels` subdirectory, ensuring they handle all logic for the views.
  4. **Integrate Services**: If the screen requires external data or functionalities, add a service within the screen group or utilize an existing service from `CartingApp/Services`.
  
  Adhering to this structure promotes a clean separation of concerns and enhances the modularity of the application.

### Models

- **Location**: `CartingApp/Models`
- **Responsibility**: Define the data structure and logic of your business model.
- **Guideline**: Keep models focused on the domain layer, without any UI or presentation logic.


### Views

- **Location**: `CartingApp/Core/<ScreenName>/Views`
- **Responsibility**: Define the UI elements. In the case of SwiftUI, this includes the View structs.
- **Guideline**: Views should remain dumb and delegate user actions to the ViewModel. Avoid embedding business logic here.

### ViewModels

- **Location**: `CartingApp/Core/<ScreenName>/ViewModels`
- **Responsibility**: Serve as the intermediary between Models and Views, handling presentation logic and state.
- **Guideline**: Implement data binding between Models and Views here, exposing observable properties the Views can react to.

### Services

- **Location**: `CartingApp/Services`
- **Responsibility**: Handle external interactions such as API calls, database access, etc.
- **Guideline**: Services should be protocol-driven to allow for mocking in tests.

## Constants and Colors

- **Constants**: Place global constants in `CartingApp/Util/Constants.swift`. If the constant is feature-specific, define it within the respective ViewModel.
- **Colors**: Define new colors in the `Assets.xcassets` directory. Use semantic names (e.g., `PrimaryTextColor`) and reference them using `Color("PrimaryTextColor")` in your views.

## Adding Translations

- **Location**: `CartingApp/Localizable.xcstrings`
- **Guideline**: Add a new entry for each string in the form `"key" = "value";`. Ensure you add translations for all supported languages.

## Contribution Process

1. **Fork and Clone**: Fork the repo and clone it locally.
2. **Branch**: Create a branch for your feature or fix.
3. **Develop**: Make your changes, adhering to the guidelines above.
4. **Test**: Ensure your changes do not break existing functionality.
5. **Pull Request**: Submit a PR against the main branch with a clear list of what you've done.

## Coding Standards

- Follow Swift's official style guide.
- Write clean, readable, and well-documented code.
- Ensure your code compiles without warnings or errors.

## Final Notes

Your contributions are crucial to the growth and improvement of this project. By following these guidelines, we can maintain a high-quality codebase and a productive development environment. Thank you for your contributions!

