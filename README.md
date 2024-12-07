# Modification

This launcher was created for a cooperative modification for GTA:SA called [CoopAndreas](https://github.com/Tornamic/CoopAndreas)

[![GitHub](https://img.shields.io/badge/CoopAndreas-000000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Tornamic/CoopAndreas)
[![Discord](https://img.shields.io/badge/CoopAndreas-5865F2?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/Z3ugSgFJMU)

## Building

**Build application**
1. Install Android Studio [Android Studio](https://developer.android.com/studio)
2. Download Flutter SDK 3.24.3 or higher [Flutter SDK](https://docs.flutter.dev/get-started/install/windows/desktop#159-tab-panel) and follow the instructions
3. Install plugins (Dart, Flutter, Flutter Intl)
4. In the file ```pubspec.yaml``` click ```Pub get``` that get all packages of the project.
5. Verify if your current folder in terminal is "coopandreas_launcher" and type command
```ps
flutter build windows
```
**Build game runner**

Open cmd in the repository directory and run
```cmd
cd native
mkdir build
cmake -S . -B build -A Win32
cmake --build build --config MinSizeRel
```
