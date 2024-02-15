import 'package:flutter/material.dart';
import 'package:quest_planner/widgets/ListQuest/widget/CardQuest.dart';

import '../../providers/quest_database.dart';
import 'package:provider/provider.dart';
import '../../models/quest.dart';

class ListQuest extends StatefulWidget {
  const ListQuest({super.key, required this.priority});
  final String priority;

  @override
  State<ListQuest> createState() => _ListQuestState();
}

class _ListQuestState extends State<ListQuest> {
  //read notes
  void readNote() {
    context.read<QuestDatabase>().fetchNotes();
  }
  @override
  void initState(){
    super.initState();
    readNote();
  }
    @override
    Widget build(BuildContext context) {
      final noteDatabase = context.watch<QuestDatabase>();
      List<Quest> currentNotes = noteDatabase.currentNotes;
      return ListView(
        padding: const EdgeInsets.only(bottom: 56.0),
        children: [
          for(int i = 0; i< context.watch<QuestDatabase>().currentNotes.length; i++)
            CardQuest(quest: currentNotes[i])
        ],
      );
    }
  }
