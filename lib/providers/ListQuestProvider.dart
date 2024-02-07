import 'package:flutter/material.dart';

import '../models/Quest.dart';


class ListQuestProvider extends ChangeNotifier {

  static int index = 0;
  List<Quest> _listaVuota = [];
  List<Quest> get currentListQuest => _listaVuota;

  void removeQuestPosition(int count){
    _listaVuota.removeAt(count);
    notifyListeners();
  }

  void removeQuestId(int id) {
    for (int i = 0; i < _listaVuota.length; i++) {
      if (_listaVuota[i].id == id) {
        _listaVuota.removeAt(i);
      }
    }
    notifyListeners();
  }

  int getLenght(){
    return _listaVuota.length;
  }

  void addQuest(String titolo, String desc, {double esp = 1, double dif = 1,int ric = 1}){
    Quest nuova = new Quest(titolo: titolo, descrizione: desc, esperienza: esp, difficolta: dif, ricompensa: ric, id: index);
    _listaVuota.add(nuova);
    ++index;
    notifyListeners();

  }
}

