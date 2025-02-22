import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:coopandreas_launcher/theme/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future getAuthorsDialog(BuildContext context, ThemeProvider themeProvider) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 110.0, vertical: 92.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(13.0))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 5.0),
            Center(
              child: Text(AppLocalizations.of(context)!.authors,
                  style: TextStyle(
                      color: !themeProvider.isDarkMode
                          ? Colors.black
                          : Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "${AppLocalizations.of(context)!.mod}: ",
                          style: TextStyle(
                              color: !themeProvider.isDarkMode
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: 'Tornamic, sr_milton',
                            style: TextStyle(
                                color: !themeProvider.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600))
                      ])),
                  RichText(
                      text: TextSpan(
                          text: "${AppLocalizations.of(context)!.launcher}: ",
                          style: TextStyle(
                              color: !themeProvider.isDarkMode
                                  ? Colors.black
                                  : Colors.white,
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: 'EOS',
                            style: TextStyle(
                                color: !themeProvider.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w600))
                      ])),
                  FittedBox(
                    child: RichText(
                        text: TextSpan(
                            text: AppLocalizations.of(context)!.special_thanks,
                            style: TextStyle(
                                color: !themeProvider.isDarkMode
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(
                              text: 'Lone.Rider, The Empty Prod.',
                              style: TextStyle(
                                  color: !themeProvider.isDarkMode
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w600)),
                        ])),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "CoopAndreas Discord ${AppLocalizations.of(context)!.community}",
                          style: const TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 5.0),
                      const Icon(
                        FontAwesomeIcons.solidHeart,
                        color: Colors.red,
                        size: 16.0,
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.close,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: !themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            )
          ]),
    ),
  );
}
