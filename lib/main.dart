import 'package:coopandreas_launcher/classes/controllers/version_controller.dart';
import 'package:coopandreas_launcher/classes/settings/unique_system_id/unique_system_id.dart';
import 'package:coopandreas_launcher/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:coopandreas_launcher/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'classes/data/storage_data.dart';
import 'classes/misc/wmi_provider.dart';
import 'language/language_provider.dart';
import 'launcher/main_page.dart';
import 'theme/dark.dart';
import 'theme/light.dart';
import 'utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowManager.instance.setMaximizable(false);

  WindowOptions windowOptions = WindowOptions(
      title: "CoopAndreas Launcher",
      size: Constants.windowScreenSize,
      minimumSize: Constants.windowScreenSize,
      maximumSize: Constants.windowScreenSize,
      titleBarStyle: TitleBarStyle.hidden,
      center: true);

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await StorageData.init();
  UniqueSystemId.init(await WMIProvider.getUniqueSystemId());

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
              WidgetsBinding.instance.platformDispatcher.platformBrightness),
        ),
        ChangeNotifierProvider(create: (_) => VersionController())
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
        return Consumer<LanguageProvider>(
            builder: (context, languageProvider, __) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              supportedLocales: L10n.all,
              locale: languageProvider.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              home: MainPage());
        });
      })));
}
