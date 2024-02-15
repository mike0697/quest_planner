import 'package:flutter/material.dart';
import 'package:quest_planner/widgets/ListQuest/widget/CardQuest.dart';
import '../../providers/quest_database.dart';
import 'package:provider/provider.dart';
import '../../models/quest.dart';

class ListQuestInbox extends StatefulWidget {
  const ListQuestInbox({super.key});

  @override
  State<ListQuestInbox> createState() => _ListQuestState();
}

class _ListQuestState extends State<ListQuestInbox> {
  //read notes
  void readNote() {
    context.read<QuestDatabase>().fetchInbox();
  }
  @override
  void initState(){
    super.initState();
    readNote();
  }
    @override
    Widget build(BuildContext context) {
      final noteDatabase = context.watch<QuestDatabase>();
      List<Quest> currentNotes = noteDatabase.questInbox;
      return ListView(
        padding: const EdgeInsets.only(bottom: 56.0),
        children: [
          for(int i = 0; i< context.watch<QuestDatabase>().questInbox.length; i++)
            CardQuest(quest: currentNotes[i])
        ],
      );
    }
  }
