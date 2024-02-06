import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../QuestProvider.dart';
import '../StringProvider.dart';
import '../widgets/CardQuest.dart';

class QuestScreen extends StatelessWidget {
  const QuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> lista = [1,2,3,4,5,6,7,8,9,10];
    QuestProvider questProvider = Provider.of<QuestProvider>(context, listen: false);
    Quest nuovaQuest = Quest(
      titolo: 'Nuova Quest',
      descrizione: 'Descrizione della Nuova Quest',
      esperienza: 75.0,
      difficolta: 4.0,
      ricompensa: 120,
      id: 2,
    );
    questProvider.setQuest(nuovaQuest);

    return  ListView(
      padding: EdgeInsets.all(8),
      children: [
        for(var i in lista)
            CardQuest(),
      ],
    );
  }
}
