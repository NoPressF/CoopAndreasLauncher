import 'package:coopandreas_launcher/classes/controllers/version_controller.dart';
import 'package:coopandreas_launcher/classes/fields/manipulate.dart';
import 'package:coopandreas_launcher/classes/settings/unique_system_id/unique_system_id.dart';
import 'package:coopandreas_launcher/launcher/widgets/main_tab/settings/custom_widgets/setting_background.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:clipboard/clipboard.dart';
import '../../../../classes/controllers/text_controllers_manipulate.dart';
import '../../../../classes/settings/game_path/game_path.dart';
import '../../../../utils/constants.dart';
import '../../../../language/language_provider.dart';
import '../../../../theme/theme_provider.dart';
import 'custom_widgets/setting_string_background.dart';
import 'custom_widgets/text_field.dart';

class LauncherSettings extends StatefulWidget {
  final ValueChanged<String> onSelectedLanguageChanged;

  const LauncherSettings({super.key, required this.onSelectedLanguageChanged});

  @override
  State<LauncherSettings> createState() => _LauncherSettingsState();
}

class _LauncherSettingsState extends State<LauncherSettings> {
  late UndoHistoryController undoHistoryController = UndoHistoryController();

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CustomSettingBackground(
        themeProvider: themeProvider,
        children: [
          IconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: child.key == const ValueKey('moon')
                    ? Tween(begin: 0.75, end: 1.0).animate(animation)
                    : Tween(begin: 0.25, end: 1.0).animate(animation),
                child: ScaleTransition(scale: animation, child: child),
              ),
              child: themeProvider.isDarkMode
                  ? const Icon(Icons.dark_mode_rounded, key: ValueKey('moon'))
                  : const Icon(Icons.light_mode, key: ValueKey('sun')),
            ),
            onPressed: () async {
              themeProvider.toggleTheme();
            },
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.5),
                child: Text(
                  AppLocalizations.of(context)!.switch_theme,
                  style: TextStyle(
                      color: !themeProvider.isDarkMode
                          ? Colors.black
                          : Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
      CustomSettingBackground(
        themeProvider: themeProvider,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 7.0, top: 5.0),
            child: Icon(Icons.translate, size: 23.0),
          ),
          Row(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                    iconStyleData: IconStyleData(
                        iconEnabledColor: !themeProvider.isDarkMode
                            ? Colors.black
                            : Colors.white,
                        iconSize: 30),
                    value: Constants.launcherLanguages.entries
                        .firstWhere((item) =>
                            item.key == languageProvider.locale.languageCode)
                        .value,
                    onChanged: (String? value) {
                      widget.onSelectedLanguageChanged(value!);
                    },
                    buttonStyleData: const ButtonStyleData(
                        height: 40,
                        decoration: BoxDecoration(color: Colors.transparent),
                        overlayColor:
                            WidgetStatePropertyAll(Colors.transparent)),
                    items: Constants.launcherLanguages.entries
                        .map((item) => DropdownMenuItem(
                              value: item.value,
                              child: Text(
                                item.value,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: !themeProvider.isDarkMode
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ))
                        .toList()),
              ),
            ],
          ),
        ],
      ),
      CustomSettingStringBackground(
        themeProvider: themeProvider,
        firstWidget: IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () async {
              String? selectedDirectory = await FilePicker.platform
                  .getDirectoryPath(lockParentWindow: true);
              setState(() {
                if (selectedDirectory != null) {
                  GamePath.setPath(selectedDirectory);
                  Provider.of<VersionController>(context, listen: false)
                      .update();
                }
              });
            }),
        additionallyWidgets: [
          SelectableText(
            GamePath.getPathEx(context),
            style: TextStyle(
                color: !GamePath.isGameFilesValid()
                    ? Colors.red
                    : !themeProvider.isDarkMode
                        ? Colors.black
                        : Colors.white,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
      CustomTextField(
        themeProvider: themeProvider,
        icon: Icon(Icons.key),
        widgets: [
          Theme(
            data: Theme.of(context).copyWith(
                inputDecorationTheme:
                    InputDecorationTheme(border: InputBorder.none)),
            child: Flexible(
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                child: SizedBox(
                  height: 25,
                  child: TextField(
                    style: TextStyle(fontWeight: FontWeight.w500),
                    controller: TextControllerManipulate.getController(
                        TextController.serialKey),
                    focusNode: FieldsManipulate.getFocusNode(Field.serialKey),
                    undoController: undoHistoryController,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter,
                      LengthLimitingTextInputFormatter(
                          Constants.maxSerialKeyCharacters)
                    ],
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 11),
                        hintText: AppLocalizations.of(context)!.serial_key,
                        hintStyle: TextStyle(
                            color: !themeProvider.isDarkMode
                                ? Colors.grey.shade700
                                : Colors.grey.shade400,
                            fontWeight: FontWeight.w500)),
                    onTapOutside: (_) {
                      TextControllerManipulate.saveInputUserSerialKey();
                      FocusScope.of(context).unfocus();
                    },
                    onSubmitted: (_) {
                      TextControllerManipulate.saveInputUserSerialKey();
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3.0, right: 8.0),
            child: Container(
              padding: EdgeInsets.only(left: 1),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: !themeProvider.isDarkMode
                      ? Colors.grey.shade400
                      : Colors.grey.shade800),
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 25,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.copy),
                      iconSize: 16,
                      onPressed: () async {
                        await FlutterClipboard.copy(
                            UniqueSystemId.getUniqueSystemIdCommand);
                      },
                    ),
                  ),
                  SelectableText(
                    UniqueSystemId.getUniqueSystemIdCommand,
                    style: TextStyle(
                        color: !UniqueSystemId.isUniqueSystemIdValid
                            ? Colors.red
                            : !themeProvider.isDarkMode
                                ? Colors.black
                                : Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    ]);
  }
}
