import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../fields/manipulate.dart';

class TabControllersManipulate {
  static late final TabController _tabController;

  static get getController => _tabController;

  static void init(TickerProvider vsync) {
    _tabController = TabController(
        vsync: vsync, length: Constants.maxMainTabControllerLength);
  }

  static void dispose() {
    _tabController.dispose();
  }

  static void disableFocusPage() {
    if (_tabController.index == 0 && _tabController.indexIsChanging) {
      FieldsManipulate.toggleExtendedData(ExtendedField.connectPressed, false);
      FieldsManipulate.toggleExtendedData(
          ExtendedField.connectButtonHovered, false);
    }
  }
}
