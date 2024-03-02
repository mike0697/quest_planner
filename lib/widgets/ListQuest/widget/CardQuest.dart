import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_planner/screens/editQuestPage.dart';

import '../../../models/quest.dart';
import '../../../providers/UserProvider.dart';
import '../../../providers/quest_database.dart';

class CardQuest extends StatefulWidget {
  const CardQuest({super.key, required this.quest});
  final Quest quest;
  @override
  State<CardQuest> createState() => _CardQuestState();
}

class _CardQuestState extends State<CardQuest> {

  //read notes
  void readNote() {
    context.read<QuestDatabase>().fetchUrgenti();
  }

  //delete a note
  void deleteNote(int id) {
    context.read<QuestDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Color(int.parse(widget.quest.color, radix: 16)),
      //surfaceTintColor: getCardColor(widget.quest.color),
      child: Column(
        children: [ ListTile(
          title: Text(widget.quest.title),
          subtitle: Text(widget.quest.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //editButton
              IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute<void>(builder: (context) => EditQuestPage(quest: widget.quest))),
                  icon: const Icon(Icons.edit)),
              //delete button
              IconButton(
                  onPressed: () => _showDialogDelete(context, widget.quest),
                  icon: const Icon(Icons.clear)),
              //esegui
              IconButton(onPressed: () => completeQuest(widget.quest),
                  icon: const Icon(Icons.check)),
            ],
          ),
        ),

          Container(
              padding: const EdgeInsets.only(left: 16),
              alignment: Alignment.topLeft,
              child: Text(widget.quest.importance)),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
        ],
      ),
    );
  }

  //esegui note
  void completeQuest(Quest quest) {
    context.read<UserProvider>().addPunti(quest.points);
    if(quest.infinity == false) {
      deleteNote(quest.id);
    }
  }

  void _showDialogDelete(BuildContext context, Quest quest) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Conferma'),
            content: Text('Eliminare la quest: ${quest.title} ?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Annulla'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Conferma'),
                onPressed: () {
                  deleteNote(quest.id);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
