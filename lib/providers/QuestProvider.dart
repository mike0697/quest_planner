import 'package:flutter/material.dart';

import '../models/Quest.dart';


class QuestProvider extends ChangeNotifier {

  Quest _quest = new Quest(titolo: 'a', descrizione: 'descrizione',
      esperienza: 1, difficolta: 1, ricompensa: 1, id: 1);

  Quest get currentQuest => _quest;

  void setQuest(Quest newQuest) {
    _quest = newQuest;
    notifyListeners();
  }
}

