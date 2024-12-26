import 'package:flutter/material.dart';
import '../../../../../theme/theme_provider.dart';
import 'setting_background.dart';

class CustomSettingStringBackground extends StatelessWidget {
  final ThemeProvider themeProvider;
  final Widget firstWidget;
  final List<Widget>? additionallyWidgets;

  const CustomSettingStringBackground(
      {super.key,
      required this.themeProvider,
      required this.firstWidget,
      this.additionallyWidgets});

  @override
  Widget build(BuildContext context) {
    return CustomSettingBackground(
      themeProvider: themeProvider,
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      children: [
        firstWidget,
        Flexible(
            child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Color(0x2F000000)),
          child: Row(
            children: [
              SizedBox(width: 5.0),
              if (additionallyWidgets != null &&
                  additionallyWidgets!.isNotEmpty)
                ...additionallyWidgets!
            ],
          ),
        ))
      ],
    );
  }
}
