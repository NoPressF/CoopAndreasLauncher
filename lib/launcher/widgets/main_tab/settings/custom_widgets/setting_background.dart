import 'package:flutter/material.dart';
import '../../../../../theme/theme_provider.dart';

class CustomSettingBackground extends StatelessWidget {
  final ThemeProvider themeProvider;
  final EdgeInsetsGeometry padding;
  final List<Widget> children;

  const CustomSettingBackground(
      {super.key,
      required this.themeProvider,
      this.padding = const EdgeInsets.symmetric(horizontal: 5.0),
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: EdgeInsets.only(left: 10, top: 8.0, right: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: !themeProvider.isDarkMode
              ? Color(0xFFD7D7D7)
              : Color(0xFF1F1F1F)),
      child: Row(
        children: children,
      ),
    );
  }
}
