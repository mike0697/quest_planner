import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {

  int _livello = 1;
  int _punti = 1;
  String _stringValue = '';

  String get stringValue => _stringValue;

  int get livello => _livello;
  int get punti => _punti;

  void setStringValue(String newValue) {
    _stringValue = newValue;
    notifyListeners();
  }

  void setLivello(int liv){
    _livello = liv;
    notifyListeners();
  }

  void addPunti(int punti){
    _punti += punti;
    saliDiLivello();
    notifyListeners();
  }

  void saliDiLivello(){}


}