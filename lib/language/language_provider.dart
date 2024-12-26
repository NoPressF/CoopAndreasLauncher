import 'package:flutter/material.dart';
import '../classes/data/storage_data.dart';
import '../utils/constants.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale _locale = const Locale(Constants.defaultLanguageCode);

  Locale get locale => _locale;

  LanguageProvider() {
    _locale = Locale(StorageData.getLanguageCode);
  }

  void setLocale(Locale locale) {
    if (_locale == locale) {
      return;
    }

    _locale = locale;
    StorageData.setStorageStringFieldData(
        StorageField.languageCode, _locale.languageCode);
    notifyListeners();
  }
}
