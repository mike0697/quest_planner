import 'package:flutter/material.dart';
import 'package:quest_planner/widgets/ListQuest/widget/CardQuest.dart';
import '../../providers/quest_database.dart';
import 'package:provider/provider.dart';
import '../../models/quest.dart';

class ListQuestSecondary extends StatefulWidget {
  const ListQuestSecondary({super.key});

  @override
  State<ListQuestSecondary> createState() => _ListQuestState();
}

class _ListQuestState extends State<ListQuestSecondary> {
  //read notes
  void readNote() {
    context.read<QuestDatabase>().fetchSecondario();
  }
  @override
  void initState(){
    super.initState();
    readNote();
  }
    @override
    Widget build(BuildContext context) {
      final noteDatabase = context.watch<QuestDatabase>();
      List<Quest> currentNotes = noteDatabase.sideQuests;
      return ListView(
        padding: const EdgeInsets.only(bottom: 56.0),
        children: [
          for(int i = 0; i< context.watch<QuestDatabase>().sideQuests.length; i++)
            CardQuest(quest: currentNotes[i])
        ],
      );
    }
  }
