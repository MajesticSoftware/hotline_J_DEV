# CLAUDE.md - Flutter Project Guidelines

## Build & Development Commands
- `flutter run` - Run app in debug mode
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app
- `flutter analyze` - Run static analysis
- `flutter format lib/` - Format code
- `flutter test [path_to_test]` - Run specific test

## Code Style
- **Imports:** Order: 1) Dart SDK 2) Flutter 3) Third-party 4) App-specific
- **Format:** 2-space indentation, 80-char line length
- **Naming:** PascalCase (classes), camelCase (vars/methods), snake_case (files)
- **Architecture:** GetX for state management, MVC pattern
- **Types:** Use nullable types with `?` when appropriate
- **Error Handling:** Try-catch blocks, use ResponseItem for API returns
- **Async:** Use async/await pattern with proper error handling
- **Widgets:** Prefer const constructors when possible
- **Dependencies:** Get, http, SVG, caching and UI utilities

## Development Best Practices
- Follow Flutter lint rules in analysis_options.yaml
- Create tests for new features
- Handle errors consistently using ApiException
- Use GetX for navigation and state management