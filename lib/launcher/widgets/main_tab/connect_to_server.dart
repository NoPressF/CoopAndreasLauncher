import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../../classes/controllers/page_controllers_manipulate.dart';
import '../../../classes/controllers/text_controllers_manipulate.dart';
import '../../../classes/fields/manipulate.dart';
import '../../../classes/main/start_game.dart';
import '../../../theme/main_colors.dart';
import '../../../utils/launch_result.dart';
import '../../../utils/constants.dart';
import '../../../theme/theme_provider.dart';

class ConnectToServerTab extends StatefulWidget {
  const ConnectToServerTab({super.key});

  @override
  State<ConnectToServerTab> createState() => _ConnectToServerTabState();
}

class _ConnectToServerTabState extends State<ConnectToServerTab> {
  late UndoHistoryController undoHistoryController = UndoHistoryController();

  LaunchResultType _lastLaunchResult = LaunchResultType.success;
  Timer? _hideFailedLaunchResultTimer;

  @override
  void initState() {
    super.initState();

    final String nickName =
        TextControllerManipulate.getController(TextController.nickName).text;
    final String ipPort =
        TextControllerManipulate.getController(TextController.connectIpPort)
            .text;

    FieldsManipulate.toggleValid(
        Field.nickName, Constants.playerNickNameRegExp.hasMatch(nickName));
    FieldsManipulate.toggleValid(
        Field.connectIpPort, Constants.connectIpPortRegExp.hasMatch(ipPort));
  }

  @override
  void dispose() {
    undoHistoryController.dispose();
    _hideFailedLaunchResultTimer?.cancel();
    LaunchResult.toggleVisibilityFailedLaunch(false);
    super.dispose();
  }

  void onPressedConnectButton() async {
    FocusScope.of(context).unfocus();

    bool isNickNameValid = FieldsManipulate.isValid(Field.nickName);
    bool isIpPortValid = FieldsManipulate.isValid(Field.connectIpPort);

    if (!isNickNameValid || !isIpPortValid) {
      setState(() {
        if (!FieldsManipulate.hasFocus(Field.nickName) ||
            !FieldsManipulate.hasFocus(Field.connectIpPort)) {
          FieldsManipulate.toggleExtendedData(
              ExtendedField.connectPressed, true);
        }
      });
    }

    if (!(isNickNameValid & isIpPortValid)) {
      return;
    }

    _lastLaunchResult = await StartGame.tryStartGame();

    if (_lastLaunchResult != LaunchResultType.success) {
      if (_lastLaunchResult == LaunchResultType.emptySerialKey) {
        PageControllersManipulate.animateToPage(1);
        FieldsManipulate.getFocusNode(Field.serialKey).requestFocus();
        return;
      }

      LaunchResult.toggleVisibilityFailedLaunch(true);
      _hideFailedLaunchResultTimer?.cancel();
      _hideFailedLaunchResultTimer =
          Timer(const Duration(seconds: 2, milliseconds: 500), () {
        setState(() {
          LaunchResult.toggleVisibilityFailedLaunch(false);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)!.title_connect_to_server,
              style:
                  const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75.0),
            child: TextField(
              controller: TextControllerManipulate.getController(
                  TextController.nickName),
              focusNode: FieldsManipulate.getFocusNode(Field.nickName),
              undoController: undoHistoryController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.nickname,
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: !FieldsManipulate.isValidEx(
                              Field.nickName, ExtendedField.connectPressed)
                          ? Colors.red
                          : (!themeProvider.isDarkMode
                              ? darkColor
                              : Colors.white)),
                  errorText: !FieldsManipulate.isValidEx(
                          Field.nickName, ExtendedField.connectPressed)
                      ? AppLocalizations.of(context)!.invalid_nickname(
                          Constants.minPlayerNicknameCharacters,
                          Constants.maxPlayerNicknameCharacters)
                      : null),
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
                LengthLimitingTextInputFormatter(32)
              ],
              onTapOutside: (_) {
                TextControllerManipulate.saveInputUserNickName();
                if (!FieldsManipulate.getExtendedData(
                    ExtendedField.connectButtonHovered)) {
                  FocusScope.of(context).unfocus();
                }
              },
              onSubmitted: (_) {
                TextControllerManipulate.saveInputUserNickName();
              },
              onChanged: (value) {
                setState(() {
                  FieldsManipulate.toggleValid(Field.nickName,
                      Constants.playerNickNameRegExp.hasMatch(value));
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75.0),
            child: TextField(
              controller: TextControllerManipulate.getController(
                  TextController.connectIpPort),
              focusNode: FieldsManipulate.getFocusNode(Field.connectIpPort),
              undoController: undoHistoryController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!
                      .ip_port(AppLocalizations.of(context)!.port),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: !FieldsManipulate.isValidEx(
                              Field.connectIpPort, ExtendedField.connectPressed)
                          ? Colors.red
                          : (!themeProvider.isDarkMode
                              ? darkColor
                              : Colors.white)),
                  errorText: !FieldsManipulate.isValidEx(
                          Field.connectIpPort, ExtendedField.connectPressed)
                      ? AppLocalizations.of(context)!
                          .invalid_ip_port(Constants.defaultServerAddress)
                      : null),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter,
                LengthLimitingTextInputFormatter(19)
              ],
              onTapOutside: (_) {
                TextControllerManipulate.saveInputUserConnectIpPort();
                if (!FieldsManipulate.getExtendedData(
                    ExtendedField.connectButtonHovered)) {
                  FocusScope.of(context).unfocus();
                }
              },
              onSubmitted: (_) {
                TextControllerManipulate.saveInputUserConnectIpPort();
                onPressedConnectButton();
              },
              onChanged: (value) {
                setState(() {
                  FieldsManipulate.toggleValid(Field.connectIpPort,
                      Constants.connectIpPortRegExp.hasMatch(value));
                });
              },
            ),
          ),
          Visibility(
              visible: LaunchResult.isVisibilityFailedLaunch,
              child: Text(
                LaunchResult.getFailedLaunchResult(context, _lastLaunchResult),
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w600),
              )),
          MouseRegion(
            onEnter: (_) => setState(() => FieldsManipulate.toggleExtendedData(
                ExtendedField.connectButtonHovered, true)),
            onExit: (_) => setState(() => FieldsManipulate.toggleExtendedData(
                ExtendedField.connectButtonHovered, false)),
            child: TextButton(
                style: const ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(128.0, 0.0))),
                onPressed: onPressedConnectButton,
                child: AnimatedSwitcher(
                    switchInCurve: Curves.ease,
                    switchOutCurve: Curves.ease,
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: FieldsManipulate.getExtendedData(
                            ExtendedField.connectButtonHovered)
                        ? Icon(FontAwesomeIcons.play,
                            color: !themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black)
                        : Text(AppLocalizations.of(context)!.connect,
                            style: TextStyle(
                                color: !themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold)))),
          )
        ]
            .map((e) => Padding(padding: const EdgeInsets.all(5.0), child: e))
            .toList());
  }
}
