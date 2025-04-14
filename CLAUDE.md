# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Development Commands
- `flutter run` - Run app in debug mode
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app
- `flutter analyze` - Run static analysis
- `flutter format lib/` - Format code
- `flutter test [path_to_test]` - Run specific test
- `flutter pub get` - Install dependencies

## Code Style
- **Imports:** Order: 1) Dart SDK 2) Flutter 3) Third-party 4) App-specific
- **Format:** 2-space indentation, 80-char line length
- **Naming:** PascalCase (classes), camelCase (vars/methods), snake_case (files)
- **Architecture:** GetX for state management, MVC pattern
- **Types:** Use nullable types with `?` when appropriate
- **Error Handling:** Try-catch blocks, use ResponseItem for API returns
- **Async:** Use async/await pattern with proper error handling
- **Environment:** Use flutter_dotenv for env variables and keys
- **Widgets:** Prefer const constructors when possible

## Development Best Practices
- Follow Flutter lint rules in analysis_options.yaml
- Create tests for new features
- Handle errors consistently using ApiException
- Use GetX for navigation and state management
- Use repositories for API calls
- Keep .env files secure (never commit secrets)