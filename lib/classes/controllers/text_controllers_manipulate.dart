import 'package:flutter/cupertino.dart';
import '../data/storage_data.dart';

enum TextController {
  nickName,
  connectIpPort,
  serverPort,
  serverMaxPlayers,
  serialKey
}

class TextControllerManipulate {
  static late Map<TextController, TextEditingController> controllers;

  static void init() {
    controllers = {
      TextController.nickName:
          TextEditingController(text: StorageData.getNickName),
      TextController.connectIpPort:
          TextEditingController(text: StorageData.getConnectIpPort),
      TextController.serverPort:
          TextEditingController(text: StorageData.getServerPort.toString()),
      TextController.serverMaxPlayers: TextEditingController(
          text: StorageData.getServerMaxPlayers.toString()),
      TextController.serialKey:
          TextEditingController(text: StorageData.getSerialKey)
    };
  }

  static void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
  }

  static TextEditingController getController(TextController controller) =>
      controllers[controller]!;

  static get isSerialKeyEmpty =>
      controllers[TextController.serialKey]!.text.isEmpty;

  static void saveInputUserNickName() {
    StorageData.setStorageStringFieldData(StorageField.nickName,
        TextControllerManipulate.getController(TextController.nickName).text);
  }

  static void saveInputUserConnectIpPort() {
    StorageData.setStorageStringFieldData(
        StorageField.connectIpPort,
        TextControllerManipulate.getController(TextController.connectIpPort)
            .text);
  }

  static void saveInputUserServerPort() {
    StorageData.setStorageIntFieldData(
        StorageField.serverPort,
        int.parse(
            TextControllerManipulate.getController(TextController.serverPort)
                .text));
  }

  static void saveInputUserServerMaxPlayers() {
    StorageData.setStorageIntFieldData(
        StorageField.serverMaxPlayers,
        int.parse(TextControllerManipulate.getController(
                TextController.serverMaxPlayers)
            .text));
  }

  static void saveInputUserSerialKey() {
    final String serialKeyControllerText =
        TextControllerManipulate.getController(TextController.serialKey).text;
    StorageData.setSerialKeyValue(serialKeyControllerText);
    StorageData.setStorageStringFieldData(
        StorageField.serialKey, serialKeyControllerText);
  }
}
