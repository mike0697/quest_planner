import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ListQuestProvider.dart';
import 'CardQuest.dart';


class ListViewQuest extends StatelessWidget {
  const ListViewQuest({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.all(8),
    children: [
    for(int i = 0; i< context.watch<ListQuestProvider>().getLenght(); i++)
    CardQuest(quest: context.watch<ListQuestProvider>().currentListQuest[i]),
    ],);
  }
}
