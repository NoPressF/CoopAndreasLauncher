import 'package:flutter/material.dart';
import '../utils/constants.dart';

class L10n {
  static final all =
      Constants.launcherLanguages.keys.map((code) => Locale(code)).toList();
}
