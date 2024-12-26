import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                    }),
                IconButton(
                  padding: const EdgeInsets.only(right: 17),
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
                )
              ],
            ),
          ),
        ),
        const Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 8, right: 12),
              child: Text(
                Constants.modVersion,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
            ))
      ],
    );
  }
}
