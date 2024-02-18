import 'package:flutter/material.dart';
import 'package:quest_planner/widgets/ListQuest/widget/CardQuest.dart';
import '../../providers/quest_database.dart';
import 'package:provider/provider.dart';
import '../../models/quest.dart';

class ListQuestPriority extends StatefulWidget {
  const ListQuestPriority({super.key});

  @override
  State<ListQuestPriority> createState() => _ListQuestState();
}

class _ListQuestState extends State<ListQuestPriority> {
  //read notes
  void readNote() {
    context.read<QuestDatabase>().fetchPrioritario();
  }
  @override
  void initState(){
    super.initState();
    readNote();
  }
    @override
    Widget build(BuildContext context) {
      final noteDatabase = context.watch<QuestDatabase>();
      List<Quest> currentNotes = noteDatabase.priorityQuests;
      return ListView(
        padding: const EdgeInsets.only(bottom: 56.0),
        children: [
          for(int i = 0; i< context.watch<QuestDatabase>().priorityQuests.length; i++)
            CardQuest(quest: currentNotes[i])
        ],
      );
    }
  }
