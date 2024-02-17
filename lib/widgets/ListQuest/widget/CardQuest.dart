import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/quest.dart';
import '../../../providers/UserProvider.dart';
import '../../../providers/quest_database.dart';
import '../../DialogEdit.dart';

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

  void _showDialogEdit(BuildContext context, Quest quest) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyWidget(quest: quest);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Color(int.parse(widget.quest.qcolor, radix: 16)),
      //surfaceTintColor: getCardColor(widget.quest.color),
      child: Column(
        children: [ ListTile(
          title: Text(widget.quest.titolo),
          subtitle: Text(widget.quest.descrizione),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //editButton
              IconButton(
                  onPressed: () => _showDialogEdit(context, widget.quest),
                  icon: const Icon(Icons.edit)),
              //delete button
              IconButton(
                  onPressed: () => _showDialogDelete(context, widget.quest),
                  icon: const Icon(Icons.clear)),
              //esegui
              IconButton(onPressed: () => eseguiNote(widget.quest),
                  icon: const Icon(Icons.check)),
            ],
          ),
        ),

          Container(
              padding: const EdgeInsets.only(left: 16),
              alignment: Alignment.topLeft,
              child: Text(widget.quest.importanza)),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
        ],
      ),
    );
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

  //esegui note
  void eseguiNote(Quest note) {
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
}
