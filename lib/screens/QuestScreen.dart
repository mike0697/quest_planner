import 'package:flutter/material.dart';

import '../widgets/CardQuest.dart';

class QuestScreen extends StatelessWidget {
  const QuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> lista = [1,2,3,4,5,6,7,8,9,10];
    return  ListView(
      padding: EdgeInsets.all(8),
      children: [
        for(var i in lista)
            CardQuest(),
      ],
    );
  }
}
