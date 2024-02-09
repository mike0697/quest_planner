import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../models/note_database.dart';
import '../providers/UserProvider.dart';

class QuestScreen extends StatefulWidget {
  const QuestScreen({super.key});

  @override
  State<QuestScreen> createState() => _QuestScreenState();
}

class _QuestScreenState extends State<QuestScreen> {
  //read notes
  void readNote() {
    context.read<NoteDatabase>().fetchNotes();
  }
  //update a note
  void updateNote(Note note){
    note.titolo = 'text';
    //show dialog
    context.read<NoteDatabase>().updateNote(note.id, note.titolo);
    //todo aggiungere dialog box
  }
  //delete a note
  void deleteNote(int id){
    context.read<NoteDatabase>().deleteNote(id);
  }

  //esegui note
  void eseguiNote(Note note)
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
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;
      return ListView(
        children: [
          for(int i = 0; i< context.watch<NoteDatabase>().currentNotes.length; i++)
            ListTile(
              title: Text(currentNotes[i].titolo),
              subtitle: Text(currentNotes[i].descrizione),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //editButton
                  IconButton(onPressed: () => updateNote(currentNotes[i]), icon: const Icon(Icons.edit)),
                  //delete button
                  IconButton(onPressed: () => deleteNote(currentNotes[i].id), icon: const Icon(Icons.delete)),
                  //esegui
                  IconButton(onPressed: () => eseguiNote(currentNotes[i]), icon: const Icon(Icons.play_arrow)),
                ],
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

