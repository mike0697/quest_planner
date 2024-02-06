import 'package:flutter/cupertino.dart';

class Quest {
  String titolo;
  String descrizione;
  double esperienza;
  double difficolta;
  int ricompensa;
  int id;

  Quest({
    required this.titolo,
    required this.descrizione,
    required this.esperienza,
    required this.difficolta,
    required this.ricompensa,
    required this.id,
  });
}

class QuestProvider extends ChangeNotifier {
  String a = 'aaa';

  Quest _quest = new Quest(titolo: 'a', descrizione: 'descrizione',
      esperienza: 1, difficolta: 1, ricompensa: 1, id: 1);

  Quest get currentQuest => _quest;

  void setQuest(Quest newQuest) {
    _quest = newQuest;
    notifyListeners();
  }
}

