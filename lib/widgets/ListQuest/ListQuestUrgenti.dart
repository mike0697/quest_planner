import 'package:flutter/material.dart';
import 'package:quest_planner/widgets/ListQuest/widget/CardQuest.dart';
import '../../providers/quest_database.dart';
import 'package:provider/provider.dart';
import '../../models/quest.dart';

class ListQuestUrgent extends StatefulWidget {
  const ListQuestUrgent({super.key, required this.priority});
  final String priority;

  @override
  State<ListQuestUrgent> createState() => _ListQuestState();
}

class _ListQuestState extends State<ListQuestUrgent> {
  //read notes
  void readNote() {
    context.read<QuestDatabase>().fetchUrgenti();
  }
  @override
  void initState(){
    super.initState();
    readNote();
  }
    @override
    Widget build(BuildContext context) {
      final noteDatabase = context.watch<QuestDatabase>();
      List<Quest> currentNotes = noteDatabase.questUrgenti;
      return ListView(
        padding: const EdgeInsets.only(bottom: 56.0),
        children: [
          for(int i = 0; i< context.watch<QuestDatabase>().questUrgenti.length; i++)
            CardQuest(quest: currentNotes[i])
        ],
      );
    }
  }
