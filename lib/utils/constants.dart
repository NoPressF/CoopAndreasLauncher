import 'package:flutter/material.dart';

class Constants {
  static const int minPlayerNicknameCharacters = 3;
  static const int maxPlayerNicknameCharacters = 32;
  static const int maxServerPlayers = 4;
  static const int maxSerialKeyCharacters = 12;
  static const int defaultServerPort = 6767;
  static const int serialKeyReminderTimeLeft = 10;
  static const int maxMainTabControllerLength = 2;
  static const double windowScreenSizeX = 500;
  static const double windowScreenSizeY = 350;
  static const Size windowScreenSize =
      Size(windowScreenSizeX, windowScreenSizeY);
  static RegExp playerNickNameRegExp = RegExp(r"^([a-zA-Z0-9_\[\]]{3,24})$");
  static RegExp connectIpPortRegExp = RegExp(
      r"\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?):\d{1,5}\b");
  static const String coopAndreasGitHubUrl =
      'https://github.com/Tornamic/CoopAndreas';
  static const String coopAndreasDiscordChannelUrl =
      'https://discord.gg/TwQsR4qxVx';
  static const String modVersion = '0.1.1b';
  static const String defaultLanguageCode = 'en';
  static const String defaultServerIp = '127.0.0.1';
  static const String defaultServerAddress =
      '$defaultServerIp:$defaultServerPort';
  static const String gameModName = 'CoopAndreasSA.dll';
  static const Map<String, String> launcherLanguages = {
    'en': 'English',
    'pt': 'Português',
    'nb': 'Norsk',
    'da': 'Dansk',
    'he': 'עִברִית',
    'ru': 'Русский',
    'uk': 'Українська'
  };
}
