import 'package:flutter/material.dart';

class StringProvider extends ChangeNotifier {
  String _stringValue = '';

  String get stringValue => _stringValue;

  void setStringValue(String newValue) {
    _stringValue = newValue;
    notifyListeners();
  }
}