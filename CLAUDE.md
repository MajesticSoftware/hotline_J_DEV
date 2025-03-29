# CLAUDE.md - Hotlines Mobile App Development Guide

## Build and Run Commands
```bash
flutter clean                      # Clean the project
flutter pub get                    # Get dependencies
flutter analyze                    # Run static analysis
flutter run                        # Run the app on connected device
flutter run --debug                # Run in debug mode
flutter run --profile              # Run in profile mode
flutter run --release              # Run in release mode

# Testing
flutter test                       # Run all tests
flutter test test/path_to_test.dart # Run a specific test file
flutter test --name="test name"    # Run a specific test by name

# iOS specific
cd ios && pod install              # Install iOS dependencies
open ios/Runner.xcworkspace        # Open in Xcode

# Code generation
flutter packages pub run build_runner build # Generate code once
flutter packages pub run build_runner watch # Generate code continuously
```

## Code Style Guidelines
- **Architecture**: Uses GetX for state management and MVC pattern
- **Naming Conventions**:
  - Controllers: Suffix with `Controller` or `_con` (e.g., `ProfileController`, `game_listing_con.dart`)
  - Models: Suffix with `Model` (e.g., `UserModel`)
  - Repositories: Suffix with `Repo` (e.g., `AuthRepo`)
  - Files: Use snake_case (e.g., `game_listing_screen.dart`)
  - Variables/Methods: Use camelCase
- **Formatting**: Follow standard Flutter linting rules from `flutter_lints` package (see analysis_options.yaml)
- **Error Handling**: Use custom exceptions in `api_exception.dart` and consistent try-catch blocks
- **State Management**: Use GetX controllers for state and dependency injection
- **Organization**: 
  - Follow project structure with separate directories for models, views, and controllers
  - Keep related components in feature-specific directories
- **Imports**: Group imports by Flutter, packages, and local files with blank lines between groups
- **UI Patterns**: 
  - Extract reusable widgets to widgets/ directory
  - Use responsive sizing with ScreenUtil package for cross-device compatibility
- **Extension Methods**: Utilize extension methods for concise code (see extension.dart)
- **Theme Management**: Support light/dark modes via theme/ directory
- **Constants**: Organize constants in dedicated files (app_strings.dart, constant.dart)
- **Security**: Use `flutter_dotenv` for sensitive information, store in assets/.env file

## Troubleshooting
If you encounter issues running the app:
1. `flutter clean`
2. `flutter pub get`
3. `flutter run`