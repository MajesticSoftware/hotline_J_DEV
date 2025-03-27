# hotlines

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


#### ANDROID SETUP FOR MAC #####
To download and install Android Studio on macOS, follow these steps:

1. **Download Android Studio**: You can download it from the [official website](https://developer.android.com/studio).

2. **Install Android Studio**:
    - Open the Android Studio DMG file.
    - Drag and drop Android Studio into the Applications folder.
    - Open Android Studio and follow bellow command.

3. **Install Flutter and Dart plugins in Android Studio**:
    - Open Android Studio.
    - Go to `Android Studio` -> `Preferences` -> `Plugins`.
    - In the marketplace tab, search for `Flutter` and click on `Install`.
    - It will prompt you to install `Dart` plugin as well, click `Yes`.
    - Click `Apply` and then `OK`.
    - Restart Android Studio.

4. **Download and Extract Flutter SDK**:
    - Download the stable version of Flutter SDK from the [Flutter official website](https://flutter-ko.dev/get-started/install/macos).
    - Extract the zip file and place the contained `flutter` in the desired installation location for the Flutter SDK (for example, `~/development/flutter`).

5. **Update your environment variable**:
    - Open Terminal.
    - Enter `nano ~/.zshrc` to open your shell profile.
    - At the end of the file, add the following line: `export PATH="$PATH:`<PATH_TO_FLUTTER_DIRECTORY>`/flutter/bin"`.
    - Replace `<PATH_TO_FLUTTER_DIRECTORY>` with the path where you placed your Flutter SDK.
    - Press `Control + X` to save the file, and confirm with `Y`, then press `Enter`.
    - Run `source ~/.zshrc` to refresh your profile.

6. **Verify your installation**:
    - Open a new Terminal window.
    - Run the command `flutter doctor`. This command checks your environment and displays a report of the status of your Flutter installation. Make sure everything is checked and properly installed.

Now, you should be able to create and run Flutter projects using Android Studio.

flutter packages pub run build_runner build

#### DIRECT APP RUN ON XCODE ####

1. Drag and Drop to machine terminal or Right click on IOS folder and open with terminal.
2. Run below command in terminal.
    - pod install
3. Right click on IOS folder and open with Xcode.
4. Select your device to run app.
5. Click on Play button to run app.
6. If you face any issue then run below command in android studio terminal.
    - flutter clean
    - flutter pub get
    - flutter run



#### IF FACE ANY ISSUE IN RUN APP ####
1. flutter clean
2. flutter pub get
3. flutter run
