import 'package:flutter/material.dart';

class ColorProviderCreaQuest extends ChangeNotifier {
String _myString = 'red';

String get myString => _myString;

void setString(String value) {
  _myString = value;
  notifyListeners();
}

void setColor(Color c2) {
  String colorAsString = c2.value.toRadixString(16);
  _myString = colorAsString;
  notifyListeners();
}
}