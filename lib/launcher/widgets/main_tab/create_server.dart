import 'package:flutter/material.dart';
import 'package:coopandreas_launcher/classes/controllers/text_controllers_manipulate.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';
import '../../../theme/main_colors.dart';
import '../../../theme/dark.dart';
import '../../../theme/light.dart';
import '../../../theme/theme_provider.dart';

class CreateServerTab extends StatefulWidget {
  const CreateServerTab({super.key});

  @override
  State<CreateServerTab> createState() => _CreateServerState();
}

class _CreateServerState extends State<CreateServerTab> {
  late UndoHistoryController undoHistoryController = UndoHistoryController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    undoHistoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.title_start_a_new_server,
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 110.0),
            child: TextField(
                controller: TextControllerManipulate.getController(
                    TextController.serverPort),
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.port,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: !themeProvider.isDarkMode
                            ? darkColor
                            : Colors.white)),
                keyboardType: TextInputType.number,
                undoController: undoHistoryController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4)
                ],
                onTapOutside: (_) {
                  TextControllerManipulate.saveInputUserServerPort();
                },
                onSubmitted: (value) {
                  TextControllerManipulate.saveInputUserServerPort();
                }),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 110.0),
              child: TextField(
                controller: TextControllerManipulate.getController(
                    TextController.serverMaxPlayers),
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.max_players,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: !themeProvider.isDarkMode
                            ? darkColor
                            : Colors.white)),
                keyboardType: TextInputType.number,
                undoController: undoHistoryController,
                textInputAction: TextInputAction.done,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1)
                ],
                onTapOutside: (_) {
                  TextControllerManipulate.saveInputUserServerMaxPlayers();
                },
                onSubmitted: (_) {
                  TextControllerManipulate.saveInputUserServerMaxPlayers();
                },
              )),
          AnimatedButton(
            height: 30,
            width: 140,
            isReverse: true,
            selectedTextColor:
                !themeProvider.isDarkMode ? Colors.white : Colors.black,
            selectedBackgroundColor: Colors.green,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            backgroundColor: !themeProvider.isDarkMode
                ? lightButtonBackgroundColor
                : darkButtonBackgroundColor,
            text: AppLocalizations.of(context)!.start_server,
            borderRadius: 50,
            textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: !themeProvider.isDarkMode ? Colors.white : Colors.black),
            animatedOn: AnimatedOn.onHover,
            onPress: () {},
          ),
        ]
            .map((e) => Padding(padding: const EdgeInsets.all(5.0), child: e))
            .toList());
  }
}
