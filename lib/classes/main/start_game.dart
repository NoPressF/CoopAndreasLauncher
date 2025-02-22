import 'dart:io';
import 'package:coopandreas_launcher/classes/controllers/text_controllers_manipulate.dart';
import '../../utils/constants.dart';
import '../../utils/launch_result.dart';
import '../settings/game_path/game_path.dart';
import '../settings/unique_system_id/unique_system_id.dart';

class StartGame {
  static List<dynamic> parseIpPort(String value) {
    RegExp regex = RegExp(
        r'\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?):\d{1,4}\b');
    Match? match = regex.firstMatch(value);
    bool result = false;
    String? ip;
    int? port;

    if (match != null) {
      List<String> parts = match.group(0)!.split(':');
      ip = parts[0];
      port = int.parse(parts[1]);
      result = true;
    }

    return [result, ip, port];
  }

  static Future<LaunchResultType> tryStartGame({bool debug = false}) async {
    final String gameFolderPath = GamePath.getFolderPath;

    if (gameFolderPath.isEmpty) {
      return LaunchResultType.gameFolderPathNotSet;
    }

    final String gameExecutableFilePath = GamePath.getExecutablePath;
    final String gameExecutableLauncherFilePath =
        GamePath.getExecutableLauncherPath;
    final String modPath = '$gameFolderPath\\${Constants.gameModName}';

    File gameExecutableFile = File(gameExecutableFilePath);
    if (!gameExecutableFile.existsSync()) {
      return LaunchResultType.gameExecutableNotFound;
    }

    File gameExecutableLauncherFile = File(gameExecutableLauncherFilePath);
    if (!gameExecutableLauncherFile.existsSync()) {
      return LaunchResultType.gameExecutableLauncherNotFound;
    }

    File modFile = File(modPath);

    if (!modFile.existsSync()) {
      return LaunchResultType.modNotFound;
    }

    final String ipPort =
        TextControllerManipulate.getController(TextController.connectIpPort)
            .text;
    List<dynamic> parseData = StartGame.parseIpPort(ipPort);

    if (!parseData[0]) {
      return LaunchResultType.parseError;
    }

    if (TextControllerManipulate.isSerialKeyEmpty) {
      return LaunchResultType.emptySerialKey;
    }

    String? ip;
    int? port;

    ip = parseData[1];
    port = parseData[2];

    List<String> args = [
      GamePath.getExecutablePath,
      '-name',
      TextControllerManipulate.getController(TextController.nickName).text,
      '-ip',
      ip!,
      '-port',
      port.toString(),
      '-id',
      UniqueSystemId.getUniqueSystemId,
      '-serial',
      TextControllerManipulate.getController(TextController.serialKey).text,
      debug.toString()
    ];

    Process.runSync(gameExecutableLauncherFilePath, args,
        workingDirectory: gameFolderPath);

    return LaunchResultType.success;
  }
}
