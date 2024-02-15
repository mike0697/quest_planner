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

  final List<Quest> questUrgenti = [];
  final List<Quest> questPrioritarie = [];
  final List<Quest> questSecondarie = [];
  final List<Quest> questInbox = [];
  final List<Quest> questEseguite = [];

  //create a note and save
  Future<void> addNote({required String titolo, required String desc, required int punti, required String color,
    required String importanza, }) async{
    final newNote = Quest();
    newNote.titolo = titolo;
    newNote.descrizione = desc;
    newNote.ricompensa = punti;
    newNote.email = Auth().getCurrentUserEmail()!;
    newNote.color = color;
    newNote.importanza = importanza;

    //save to db
    await isar.writeTxn(() => isar.quests.put(newNote));
    fetchNotes();
    fetchUrgenti();
    fetchPrioritario();
    fetchSecondario();
    fetchInbox();
  }

  //R E A D - notes from db
  Future<void> fetchNotes() async{
    List<Quest> fetchedNotes = await isar.quests.where()
    .emailEqualTo(Auth().getCurrentUserEmail()!)
        .findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    ordinaLista(currentNotes);
    notifyListeners();
  }
  //fetch only importanza
  Future<void> fetchUrgenti() async{
    List<Quest> fetchedNotes = await isar.quests.where()
    .emailEqualTo(Auth().getCurrentUserEmail()!)
    .filter()
    .importanzaEqualTo('Urgente')
        .findAll();
    questUrgenti.clear();
    questUrgenti.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> fetchPrioritario() async{
    List<Quest> fetchedNotes = await isar.quests.where()
        .emailEqualTo(Auth().getCurrentUserEmail()!)
        .filter()
        .importanzaEqualTo('Prioritario')
        .findAll();
    questPrioritarie.clear();
    questPrioritarie.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> fetchSecondario() async{
    List<Quest> fetchedNotes = await isar.quests.where()
        .emailEqualTo(Auth().getCurrentUserEmail()!)
        .filter()
        .importanzaEqualTo('Secondario')
        .findAll();
    questSecondarie.clear();
    questSecondarie.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> fetchInbox() async{
    List<Quest> fetchedNotes = await isar.quests.where()
        .emailEqualTo(Auth().getCurrentUserEmail()!)
        .filter()
        .importanzaEqualTo('Inbox')
        .findAll();
    questInbox.clear();
    questInbox.addAll(fetchedNotes);
    notifyListeners();
  }

  void ordinaLista(List<Quest> lista) {
    final ordineImportanza = ['Urgente', 'Prioritario', 'Secondario', 'Inbox'];

    lista.sort((a, b) {
      int confrontoImportanza = ordineImportanza.indexOf(a.importanza).compareTo(ordineImportanza.indexOf(b.importanza));
      if (confrontoImportanza != 0) {
        return confrontoImportanza;
      } else {
        return a.id.compareTo(b.id);
      }
    });
  }

  //U P D A T E - a note in db
  Future<void> updateNote(int id, String newText, String desc, int p, {required String importanza, required String color}) async{
    final existingNote = await isar.quests.get(id);
    if( existingNote != null){
      existingNote.titolo = newText;
      existingNote.descrizione = desc;
      existingNote.ricompensa = p;
      existingNote.importanza = importanza;
      existingNote.color = color;
      await isar.writeTxn(() => isar.quests.put(existingNote));
      await fetchNotes();
      await fetchUrgenti();
      await fetchPrioritario();
      await fetchSecondario();
      await fetchInbox();
    }
  }

  //DELETE - a note from the db
  Future<void> deleteNote(int id) async{
    await isar.writeTxn(() => isar.quests.delete(id));
    await fetchNotes();
    await fetchUrgenti();
    await fetchPrioritario();
    await fetchSecondario();
    await fetchInbox();
  }

}