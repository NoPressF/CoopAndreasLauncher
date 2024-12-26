import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../../../../classes/controllers/page_controllers_manipulate.dart';
import '../../../../../theme/theme_provider.dart';
import '../../../../../utils/constants.dart';

class SerialKeyReminder {
  static int _timeLeft = Constants.serialKeyReminderTimeLeft;
  static Timer? _timer;
  static late ThemeProvider _themeProvider;

  static void init(BuildContext context) {
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog(
        context: context,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter dialogSetState) {
                _timer ??= Timer.periodic(Duration(seconds: 1), (Timer timer) {
                  if (_timeLeft > 0) {
                    dialogSetState(() {
                      _timeLeft--;
                    });
                  } else {
                    _timer?.cancel();
                  }
                });
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.serial_key,
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold),
                            softWrap: false,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: FittedBox(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .important_info_about_serial_key,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: AbsorbPointer(
                            absorbing: _timeLeft > 0,
                            child: TextButton(
                              onPressed: () {
                                if (_timeLeft == 0) {
                                  PageControllersManipulate.animateToPage(1);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                _timeLeft > 0
                                    ? _timeLeft.toString()
                                    : AppLocalizations.of(context)!
                                        .go_to_settings,
                                style: TextStyle(
                                    color: !_themeProvider.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }
}
