import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../classes/controllers/page_controllers_manipulate.dart';
import '../classes/controllers/tab_controllers_manipulate.dart';
import '../classes/controllers/text_controllers_manipulate.dart';
import '../classes/fields/manipulate.dart';
import '../theme/dark.dart';
import '../theme/light.dart';
import '../theme/main_colors.dart';
import '../theme/theme_provider.dart';
import '../classes/misc/mouse_hover_state.dart';
import '../utils/constants.dart';
import '../language/language_provider.dart';
import 'widgets/main_tab/authors.dart';
import 'widgets/main_tab/settings/serial_key/reminder.dart';
import 'widgets/main_tab/settings/settings.dart';
import 'widgets/main_tab/mod_info.dart';
import 'widgets/misc/custom_appbar.dart';
import 'widgets/misc/custom_tab.dart';
import 'widgets/main_tab/connect_to_server.dart';
import 'widgets/main_tab/create_server.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    FieldsManipulate.init(setState);
    TextControllerManipulate.init();
    TabControllersManipulate.init(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (TextControllerManipulate.isSerialKeyEmpty) {
        SerialKeyReminder.init(context);
      }
    });
  }

  @override
  void dispose() {
    TextControllerManipulate.dispose();
    FieldsManipulate.dispose();
    TabControllersManipulate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
        appBar: CustomAppBar(
          actions: [
            MouseRegion(
              onEnter: (_) =>
                  setState(() => MouseHoverState.enableMouseHovered()),
              onExit: (_) =>
                  setState(() => MouseHoverState.disableMouseHovered()),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        color: !themeProvider.isDarkMode
                            ? lightLightGreyColor
                            : darkGreyColor,
                        FontAwesomeIcons.info,
                      ),
                      iconSize: 20.0,
                      onPressed: () =>
                          getAuthorsDialog(context, themeProvider)),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.gear,
                        color: PageControllersManipulate.getCurrentPage == 1
                            ? (!themeProvider.isDarkMode
                                ? darkColor
                                : Colors.white)
                            : (!themeProvider.isDarkMode
                                ? lightLightGreyColor
                                : darkGreyColor)),
                    iconSize: 20.0,
                    onPressed: () {
                      PageControllersManipulate.animateToPage(1);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.minimize,
                        color: !themeProvider.isDarkMode
                            ? lightLightGreyColor
                            : darkGreyColor),
                    iconSize: 20.0,
                    onPressed: () {
                      windowManager.minimize();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close,
                        color: !themeProvider.isDarkMode
                            ? lightLightGreyColor
                            : darkGreyColor),
                    iconSize: 20.0,
                    onPressed: () {
                      windowManager.close();
                    },
                  )
                ],
              ),
            )
          ],
          leadingWidth: 180,
          leading: TabBar(
              labelColor: PageControllersManipulate.getCurrentPage == 0
                  ? (!themeProvider.isDarkMode ? darkColor : Colors.white)
                  : (!themeProvider.isDarkMode
                      ? lightLightGreyColor
                      : darkGreyColor),
              controller: TabControllersManipulate.getController,
              indicatorColor: Colors.transparent,
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.center,
              indicatorSize: TabBarIndicatorSize.label,
              onTap: (index) {
                if (PageControllersManipulate.getCurrentPage == 1) {
                  PageControllersManipulate.animateToPage(0);
                }

                setState(() {
                  TabControllersManipulate.disableFocusPage();
                });
              },
              tabs: [
                CustomTab(
                    iconData: FontAwesomeIcons.plug,
                    data: AppLocalizations.of(context)!.connect,
                    tabController: TabControllersManipulate.getController,
                    currentPage: PageControllersManipulate.getCurrentPage,
                    tabIndex: 0),
                CustomTab(
                    iconData: FontAwesomeIcons.server,
                    data: AppLocalizations.of(context)!.server,
                    tabController: TabControllersManipulate.getController,
                    currentPage: PageControllersManipulate.getCurrentPage,
                    tabIndex: 1)
              ]),
          title: Text(
            'CoopAndreas',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            PageView(
                controller: PageControllersManipulate.getController,
                onPageChanged: (page) {
                  setState(() {
                    PageControllersManipulate.setCurrentPage(page);
                  });
                },
                children: [
                  TabBarView(
                      controller: TabControllersManipulate.getController,
                      children: [ConnectToServerTab(), CreateServerTab()]),
                  LauncherSettings(onSelectedLanguageChanged: (String? value) {
                    setState(() {
                      languageProvider.setLocale(Locale(Constants
                          .launcherLanguages.entries
                          .firstWhere((item) => item.value == value!)
                          .key));
                    });
                  })
                ]),
            ModInfo()
          ],
        ));
  }
}
