import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import '../settings/game_path/game_path.dart';

enum StorageField {
  nickName,
  connectIpPort,
  serverPort,
  serverMaxPlayers,
  serialKey,
  isDarkMode,
  languageCode,
  gameFolderPath
}

class StorageData {
  static late final SharedPreferences _sharedPreferences;

  static late String _nickName;
  static late String _connectIpPort;
  static late int _serverPort;
  static late int _serverMaxPlayers;
  static late String _serialKey;
  static late bool _isDarkMode;
  static late String _languageCode;
  static late String _gameFolderPath;

  static get getNickName => _nickName;

  static get getConnectIpPort => _connectIpPort;

  static get getServerPort => _serverPort;

  static get getServerMaxPlayers => _serverMaxPlayers;

  static get getSerialKey => _serialKey;

  static get getIsDarkMode => _isDarkMode;

  static get getLanguageCode => _languageCode;

  static get getGameFolderPath => _gameFolderPath;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    GamePath.setPath(
        getStorageStringFieldData(StorageField.gameFolderPath) ?? '');
    _nickName = getStorageStringFieldData(StorageField.nickName) ?? '';
    _connectIpPort =
        getStorageStringFieldData(StorageField.connectIpPort) ?? '';
    _serverPort = getStorageIntFieldData(StorageField.serverPort) ??
        Constants.defaultServerPort;
    _serverMaxPlayers = getStorageIntFieldData(StorageField.serverMaxPlayers) ??
        Constants.maxServerPlayers;
    _serialKey = getStorageStringFieldData(StorageField.serialKey) ?? '';
    _isDarkMode = getStorageBoolFieldData(StorageField.isDarkMode) ?? false;
    _languageCode = getStorageStringFieldData(StorageField.languageCode) ??
        Constants.defaultLanguageCode;
    _gameFolderPath =
        getStorageStringFieldData(StorageField.gameFolderPath) ?? '';
  }

  static String _getFieldName(StorageField field) {
    return field.name;
  }

  static bool? getStorageBoolFieldData(StorageField field) {
    return _sharedPreferences.getBool(_getFieldName(field));
  }

  static void setStorageBoolFieldData(StorageField field, bool value) {
    _sharedPreferences.setBool(_getFieldName(field), value);
  }

  static int? getStorageIntFieldData(StorageField field) {
    return _sharedPreferences.getInt(_getFieldName(field));
  }

  static void setStorageIntFieldData(StorageField field, int value) {
    _sharedPreferences.setInt(_getFieldName(field), value);
  }

  static String? getStorageStringFieldData(StorageField field) {
    return _sharedPreferences.getString(_getFieldName(field));
  }

  static void setStorageStringFieldData(StorageField field, String value) {
    _sharedPreferences.setString(_getFieldName(field), value);
  }

  static void setSerialKeyValue(String value) {
    _serialKey = value;
  }
}
