import 'package:flutter/material.dart';

class AddEditQuestProvider extends ChangeNotifier {
String _myColor = '';

String get myColor => _myColor;

void setColor(Color c2) {
  String colorAsString = c2.value.toRadixString(16);
  _myColor = colorAsString;
  notifyListeners();
}
}