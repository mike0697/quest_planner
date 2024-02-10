import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quest_planner/Auth.dart';
import 'package:quest_planner/models/quest.dart';

class QuestDatabase extends ChangeNotifier {
  //INITIALIZe DATABASE
  static late Isar isar;
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [QuestSchema],
      directory: dir.path,
    );
  }
  //list of notes
  final List<Quest> currentNotes = [];

  //create a note and save
  Future<void> addNote({required String titolo, required String desc, required int punti}) async{
    final newNote = Quest();
    newNote.titolo = titolo;
    newNote.descrizione = desc;
    newNote.ricompensa = punti;
    newNote.email = Auth().getCurrentUserEmail()!;

    //save to db
    await isar.writeTxn(() => isar.quests.put(newNote));
  }

  //R E A D - notes from db
  Future<void> fetchNotes() async{
    List<Quest> fetchedNotes = await isar.quests.where()
    .emailEqualTo(Auth().getCurrentUserEmail()!)
        .findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  //U P D A T E - a note in db
  Future<void> updateNote(int id, String newText) async{
    final existingNote = await isar.quests.get(id);
    if( existingNote != null){
      existingNote.titolo = newText;
      await isar.writeTxn(() => isar.quests.put(existingNote));
      await fetchNotes();
    }
  }

  //DELETE - a note from the db
  Future<void> deleteNote(int id) async{
    await isar.writeTxn(() => isar.quests.delete(id));
    await fetchNotes();
  }

}