import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_planner/providers/ListQuestProvider.dart';
import '../widgets/CardQuest2.dart';

class QuestScreen extends StatelessWidget {
  const QuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
          padding: const EdgeInsets.all(8),
          children: [
            for(int i = 0; i< context.watch<ListQuestProvider>().getLenght(); i++)
              CardQuest2(quest: context.watch<ListQuestProvider>().currentQuest[i]),
          ],
        );
  }
}
