import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'constants.dart';

enum LaunchResultType {
  success,
  gameFolderPathNotSet,
  parseError,
  gameExecutableNotFound,
  gameExecutableLauncherNotFound,
  modNotFound,
  emptySerialKey
}

class LaunchResult {
  static bool _isVisibilityFailedLaunch = false;

  static bool get isVisibilityFailedLaunch => _isVisibilityFailedLaunch;

  static void toggleVisibilityFailedLaunch(bool visibility) =>
      _isVisibilityFailedLaunch = visibility;

  static String getFailedLaunchResult(
      BuildContext context, LaunchResultType launchResult) {
    switch (launchResult) {
      case LaunchResultType.success:
        return "";
      case LaunchResultType.gameFolderPathNotSet:
        return AppLocalizations.of(context)!.game_folder_path_not_set;
      case LaunchResultType.parseError:
        return AppLocalizations.of(context)!.failed_parse_ip_and_port;
      case LaunchResultType.gameExecutableLauncherNotFound:
        return AppLocalizations.of(context)!.game_executable_launcher_not_found;
      case LaunchResultType.gameExecutableNotFound:
        return AppLocalizations.of(context)!.game_not_found;
      case LaunchResultType.modNotFound:
        return AppLocalizations.of(context)!
            .mod_not_found(Constants.gameModName);
      case LaunchResultType.emptySerialKey:
        return "";
    }
  }
}
