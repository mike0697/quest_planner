import 'package:flutter/material.dart';

class AddEditQuestProvider extends ChangeNotifier {
String _myString = '';

String get myString => _myString;

void setColor(Color c2) {
  String colorAsString = c2.value.toRadixString(16);
  _myString = colorAsString;
  notifyListeners();
}
}