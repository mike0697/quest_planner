import 'package:flutter/material.dart';
import 'package:quest_planner/Cloud.dart';

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

  void addPunti(int point){
    _punti += point;
    saliDiLivello();
    Cloud().updateLivelloPunti(punti: punti, livello: livello);
    notifyListeners();
  }

  void setPunti(int point){
    _punti = point;
    notifyListeners();
  }

  void saliDiLivello(){
    if(_punti >= 100){
      _livello = _livello + 1;
      _punti = _punti - 100;
    }
  }

  void resetPuntiLivello(){
    _punti = 1;
    _livello = 1;
    Cloud().updateLivelloPunti(punti: punti, livello: livello);
    notifyListeners();
  }

}