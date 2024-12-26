import 'package:coopandreas_launcher/theme/theme_provider.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final ThemeProvider themeProvider;
  final Icon icon;
  final List<Widget> widgets;

  const CustomTextField(
      {super.key,
      required this.themeProvider,
      required this.icon,
      required this.widgets});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
          margin: EdgeInsets.only(left: 10, top: 8.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              color: !themeProvider.isDarkMode
                  ? Color(0xFFD7D7D7)
                  : Color(0xFF1F1F1F)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: icon,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Color(0x2F000000)),
                  child: Row(
                    children: widgets,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
