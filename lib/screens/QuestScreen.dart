import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quest.dart';
import '../providers/quest_database.dart';
import '../providers/UserProvider.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});

  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  //read notes
  void readNote() {
    context.read<QuestDatabase>().fetchNotes();
  }
  //update a note
  void updateNote(Quest note){
    note.titolo = 'text';
    //show dialog
    context.read<QuestDatabase>().updateNote(note.id, note.titolo);
    //todo aggiungere dialog box
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
        children: [
          for(int i = 0; i< context.watch<QuestDatabase>().currentNotes.length; i++)
            Card(
              child: ListTile(
                title: Text(currentNotes[i].titolo),
                subtitle: Text(currentNotes[i].descrizione),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //editButton
                    IconButton(onPressed: () => updateNote(currentNotes[i]), icon: const Icon(Icons.edit)),
                    //delete button
                    IconButton(onPressed: () => deleteNote(currentNotes[i].id), icon: const Icon(Icons.clear)),
                    //esegui
                    IconButton(onPressed: () => eseguiNote(currentNotes[i]), icon: const Icon(Icons.check)),
                  ],
                ),
              ),
            )
        ],);
        }
}







      /*ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (context, index){
      final note = currentNotes[index];
      print(note.text);
      return ListTile(
        title: Text(note.text),
      );
    }),

       */

