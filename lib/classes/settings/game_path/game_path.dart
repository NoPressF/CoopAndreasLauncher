import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../../../utils/constants.dart';
import '../../data/storage_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GamePath {
  static String _folderPath = '';
  static String _executablePath = '';
  static String _executableLauncherPath = '';
  static String _modPath = '';

  static String exePath = Platform.resolvedExecutable;
  static String exeDirectory = File(exePath).parent.path;

  static get getFolderPath => _folderPath;

  static get getExecutablePath => _executablePath;

  static get getExecutableLauncherPath => _executableLauncherPath;

  static get getModPath => _modPath;

  static get isFolderPathEmpty => _folderPath.isEmpty;

  static bool isGameExecutableAbsentInPath() {
    File gameExecutableFile = File(_executablePath);

    return gameExecutableFile.existsSync();
  }

  static bool isGameModAbsentInPath() {
    File gameModeFile = File(_modPath);

    return gameModeFile.existsSync();
  }

  static bool isGameFilesValid() {
    if (GamePath.isFolderPathEmpty ||
        !isGameExecutableAbsentInPath() ||
        !isGameModAbsentInPath()) {
      return false;
    }

    return true;
  }

  static String getPathEx(BuildContext context) {
    if (GamePath.isFolderPathEmpty) {
      return AppLocalizations.of(context)!.game_folder_path_not_set;
    }

    if (!isGameExecutableAbsentInPath()) {
      return AppLocalizations.of(context)!.game_not_found;
    }

    if (!isGameModAbsentInPath()) {
      return AppLocalizations.of(context)!.mod_not_found(Constants.gameModName);
    }

    return GamePath.getFolderPath;
  }

  static void setPath(String path) {
    _folderPath = path;
    _executablePath = '$path\\gta_sa.exe';
    _executableLauncherPath = '$exeDirectory\\launcher.exe';
    _modPath = '$path\\${Constants.gameModName}';
    StorageData.setStorageStringFieldData(StorageField.gameFolderPath, path);
  }
}
