import 'package:flutter/material.dart';

import '../../providers/quest_database.dart';
import 'package:provider/provider.dart';
import 'package:quest_planner/widgets/DialogEdit.dart';
import '../../models/quest.dart';
import '../../providers/UserProvider.dart';

class ListQuestUrgenti extends StatefulWidget {
  const ListQuestUrgenti({super.key, required this.priority});
  final String priority;

  @override
  State<ListQuestUrgenti> createState() => _ListQuestState();
}

class _ListQuestState extends State<ListQuestUrgenti> {
  //read notes
  void readNote() {
    context.read<QuestDatabase>().fetchUrgenti();
  }
  //delete a note
  void deleteNote(int id){
    context.read<QuestDatabase>().deleteNote(id);
  }

  //esegui note
  void eseguiNote(Quest note)
  {
    context.read<UserProvider>().addPunti(note.ricompensa);
    deleteNote(note.id);
  }
  void _showDialogDelete(BuildContext context, Quest quest) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Conferma'),
            content: Text('Eliminare la quest: ${quest.titolo} ?'),
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

  void _showDialogEdit(BuildContext context, Quest quest) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyWidget(quest: quest);
      },
    );
  }
  @override
  void initState(){
    super.initState();
    readNote();
  }
  Color getCardColor(String scolor) {
    switch (scolor) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'dpurple':
        return Colors.deepPurpleAccent;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'white':
        return Colors.white;
      case 'pink':
        return Colors.pink;
      default:
        return Colors.deepPurple;
    }
  }
    @override
    Widget build(BuildContext context) {
      final noteDatabase = context.watch<QuestDatabase>();
      List<Quest> currentNotes = noteDatabase.questUrgenti;
      return ListView(
        padding: const EdgeInsets.only(bottom: 56.0),
        children: [
          for(int i = 0; i< context.watch<QuestDatabase>().questUrgenti.length; i++)
            Card(
              surfaceTintColor: getCardColor(currentNotes[i].color),
              child: Column(
                children:[ ListTile(
                  title: Text(currentNotes[i].titolo),
                  subtitle: Text(currentNotes[i].descrizione),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //editButton
                      IconButton(onPressed: () => _showDialogEdit(context,currentNotes[i]), icon: const Icon(Icons.edit)),
                      //delete button
                      IconButton(onPressed: () => _showDialogDelete(context,currentNotes[i]), icon: const Icon(Icons.clear)),
                      //esegui
                      IconButton(onPressed: () => eseguiNote(currentNotes[i]), icon: const Icon(Icons.check)),
                    ],
                  ),
                ),

                  Container(
                      padding: const EdgeInsets.only(left: 16),
                      alignment: Alignment.topLeft,
                      child: Text(currentNotes[i].importanza)),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              ),
            )
        ],
      );
    }
  }
