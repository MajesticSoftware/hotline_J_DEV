# CLAUDE.md - Hotlines Mobile App Development Guide

## Build and Run Commands
```bash
flutter clean                      # Clean the project
flutter pub get                    # Get dependencies
flutter run                        # Run the app on connected device
flutter analyze                    # Run static analysis
flutter test                       # Run all tests
flutter test test/path_to_test.dart # Run a single test
cd ios && pod install              # Install iOS dependencies
flutter packages pub run build_runner build # Generate code
```

## Code Style Guidelines
- **Architecture**: Uses GetX for state management and MVC pattern
- **Naming**:
  - Controllers: Suffix with `Controller` or `_con` (e.g., `ProfileController`)
  - Models: Suffix with `Model` (e.g., `UserModel`)
  - Repositories: Suffix with `Repo` (e.g., `AuthRepo`)
  - Files: Use snake_case (e.g., `game_listing_screen.dart`)
- **Formatting**: Follow standard Flutter linting rules from `flutter_lints` package
- **Error Handling**: Use custom exceptions in `api_exception.dart` and consistent try-catch blocks
- **State Management**: Use GetX controllers for state and dependency injection
- **Organization**: Follow project structure with separate directories for models, views, and controllers
- **Imports**: Group imports by Flutter, packages, and local files with blank lines between
- **UI Patterns**: Extract reusable widgets to widgets/ directory, use responsive sizing with ScreenUtil
- **Extension Methods**: Utilize extension methods for concise code (e.g., for responsive sizing)
- **Theme Management**: Support light/dark modes via theme/ directory
- **Constants**: Organize constants in dedicated files (app_strings.dart, constant.dart)
- **Security**: Use `flutter_dotenv` for sensitive information, store in assets/.env file