import 'package:flutter/material.dart';

enum Field { nickName, connectIpPort, serialKey }

enum ExtendedField { connectPressed, connectButtonHovered }

class FieldsManipulate {
  static final Map<Field, FocusNode> _focusNodes = {};
  static final Map<Field, bool> _focus = {};
  static final Map<Field, bool> _valid = {};
  static final Map<ExtendedField, bool> _extendedData = {};
  static late final StateSetter _state;

  static FocusNode getFocusNode(Field field) => _focusNodes[field]!;

  static bool isValid(Field field) => _valid[field]!;

  static bool hasFocus(Field field) => _focus[field]!;

  static void init(StateSetter state) {
    _state = state;

    for (var field in Field.values) {
      _focusNodes[field] = FocusNode();
      _focus[field] = false;
      _valid[field] = false;

      _focusNodes[field]!.addListener(() {
        _onFocusChange(field);
      });
    }

    for (var extendedField in ExtendedField.values) {
      _extendedData[extendedField] = false;
    }
  }

  static void dispose() {
    for (final focusNode in _focusNodes.values) {
      focusNode.dispose();
    }
    _focusNodes.clear();
    _focus.clear();
    _valid.clear();
    _extendedData.clear();
    _state(() {});
  }

  static bool getExtendedData(ExtendedField extendedField) {
    return _extendedData[extendedField]!;
  }

  static void toggleExtendedData(ExtendedField extendedField, bool toggle) {
    _extendedData[extendedField] = toggle;
  }

  static bool isValidEx(Field field, ExtendedField extendedField) {
    if (!_focus[field]! && _extendedData[extendedField]! && !_valid[field]!) {
      return false;
    }

    return !(_focus[field]! && !_valid[field]!);
  }

  static void toggleFocus(Field field, bool focus) {
    if (focus) {
      _focusNodes[field]?.requestFocus();
    } else {
      _focusNodes[field]?.unfocus();
    }
    _focus[field] = focus;
  }

  static void toggleValid(Field field, bool valid) {
    _valid[field] = valid;
  }

  static void _onFocusChange(Field field) {
    if (field == Field.nickName || field == Field.connectIpPort) {
      if (_extendedData[ExtendedField.connectPressed]! && _focus[field]!) {
        _extendedData[ExtendedField.connectPressed] = false;
      }
    }

    _focus[field] = _focusNodes[field]!.hasFocus;
    _state(() {});
  }
}
