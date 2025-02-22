import 'package:coopandreas_launcher/classes/controllers/page_controllers_manipulate.dart';
import 'package:coopandreas_launcher/classes/controllers/version_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/constants.dart';
import '../../../theme/theme_provider.dart';

class ModInfo extends StatelessWidget {
  const ModInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  color:
                      !themeProvider.isDarkMode ? Colors.black : Colors.white,
                  iconSize: 19.0,
                  icon: const Icon(FontAwesomeIcons.github),
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () async {
                    final Uri url = Uri.parse(Constants.coopAndreasGitHubUrl);
                    await launchUrl(url);
                  },
                ),
                IconButton(
                  color: const Color(0xFF5662F6),
                  iconSize: 19.0,
                  icon: const Icon(FontAwesomeIcons.discord),
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () async {
                    final Uri url =
                        Uri.parse(Constants.coopAndreasDiscordChannelUrl);
                    await launchUrl(url);
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: PageControllersManipulate.getCurrentPage == 1,
                    child: Text(
                      "${AppLocalizations.of(context)!.launcher}: ${VersionController.currentLauncherVersion.toString()}",
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    PageControllersManipulate.getCurrentPage == 0
                        ? VersionController.currentModVersion.toString()
                        : "${AppLocalizations.of(context)!.mod}: ${VersionController.currentModVersion.toString()}",
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
