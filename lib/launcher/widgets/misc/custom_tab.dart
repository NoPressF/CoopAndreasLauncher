import 'package:coopandreas_launcher/classes/misc/mouse_hover_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../theme/dark.dart';
import '../../../theme/light.dart';
import '../../../theme/main_colors.dart';
import '../../../theme/theme_provider.dart';

class CustomTab extends StatefulWidget {
  final TabController tabController;
  final int currentPage;
  final String data;
  final IconData iconData;
  final int tabIndex;

  const CustomTab(
      {super.key,
      required this.tabController,
      required this.currentPage,
      required this.data,
      required this.iconData,
      required this.tabIndex});

  @override
  State<CustomTab> createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MouseRegion(
      onEnter: (_) => setState(() => MouseHoverState.enableMouseHovered()),
      onExit: (_) => setState(() => MouseHoverState.disableMouseHovered()),
      child: Tab(
          icon: Icon(widget.iconData, size: 21.0),
          child: Text(widget.data,
              style: TextStyle(
                fontSize: 10,
                color: widget.tabController.index == widget.tabIndex &&
                        widget.currentPage == 0
                    ? (!themeProvider.isDarkMode ? darkColor : Colors.white)
                    : (!themeProvider.isDarkMode
                        ? lightLightGreyColor
                        : darkGreyColor),
              ))),
    );
  }
}
