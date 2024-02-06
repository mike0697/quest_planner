import 'package:flutter/material.dart';

import '../models/Quest.dart';


class ListQuestProvider extends ChangeNotifier {

  static int index = 0;
  List<Quest> _listaVuota = [];
  List<Quest> get currentQuest => _listaVuota;

  void addQuest(Quest newQuest) {
    _listaVuota.add(newQuest);
    notifyListeners();
  }

  void removeQuest(int index){
    _listaVuota.removeAt(index);
    notifyListeners();
  }

  int getLenght(){
    return _listaVuota.length;
  }

  void initLista(String titolo, String desc){
    Quest nuova = new Quest(titolo: titolo, descrizione: desc, esperienza: 1, difficolta: 1, ricompensa: 1, id: index);
    _listaVuota.add(nuova);
    ++index;
    notifyListeners();

  }
}

