import 'package:coopandreas_launcher/classes/misc/mouse_hover_state.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? title;
  final TabBar? leading;
  final double? leadingWidth;

  const CustomAppBar(
      {super.key, this.actions, this.title, this.leading, this.leadingWidth});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        if (!MouseHoverState.isMouseHovered) {
          windowManager.startDragging();
        }
      },
      child: AppBar(
          actions: actions,
          title: title,
          titleSpacing: 0.0,
          centerTitle: true,
          leading: leading,
          leadingWidth: leadingWidth),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
