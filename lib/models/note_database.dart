import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quest_planner/models/note.dart';

class NoteDatabase extends ChangeNotifier {
  //INITIALIZe DATABASE
  static late Isar isar;
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }
  //list of notes
  final List<Note> currentNotes = [];

  //create a note and save
  Future<void> addNote(String textFromUser) async{
    final newNote = Note()..text = textFromUser;

    //save to db
    await isar.writeTxn(() => isar.notes.put(newNote));
  }

  //R E A D - notes from db
  Future<void> fetchNotes() async{
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  //U P D A T E - a note in db
  Future<void> updateNote(int id, String newText) async{
    final existingNote = await isar.notes.get(id);
    if( existingNote != null){
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  //DELETE - a note from the db
  Future<void> deleteNote(int id) async{
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }

}