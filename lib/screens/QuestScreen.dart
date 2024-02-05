import 'package:flutter/material.dart';

import '../widgets/CardQuest.dart';

class QuestScreen extends StatelessWidget {
  const QuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(padding: EdgeInsets.all(20),
          child: Column(children: [
            CardQuest()
          ]
            ,)
      ),
    );
  }
}
