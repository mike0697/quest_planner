import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quest_planner/Auth.dart';
import 'package:quest_planner/models/quest.dart';

class QuestDatabase extends ChangeNotifier {
  //INITIALIZE DATABASE
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
  Future<void> addNote({required String title, required String description, required int points, required String color,
    required String importance }) async{
    final newNote = Quest();
    newNote.title = title;
    newNote.description = description;
    newNote.points = points;
    newNote.email = Auth().getCurrentUserEmail()!;
    newNote.color = color;
    newNote.importance = importance;

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
    sortList(currentNotes);
    notifyListeners();
  }
  //fetch only importanza
  Future<void> fetchUrgenti() async{
    List<Quest> fetchedNotes = await isar.quests.where()
    .emailEqualTo(Auth().getCurrentUserEmail()!)
    .filter()
    .importanceEqualTo('Urgente')
        .findAll();
    questUrgenti.clear();
    questUrgenti.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> fetchPrioritario() async{
    List<Quest> fetchedNotes = await isar.quests.where()
        .emailEqualTo(Auth().getCurrentUserEmail()!)
        .filter()
        .importanceEqualTo('Prioritario')
        .findAll();
    questPrioritarie.clear();
    questPrioritarie.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> fetchSecondario() async{
    List<Quest> fetchedNotes = await isar.quests.where()
        .emailEqualTo(Auth().getCurrentUserEmail()!)
        .filter()
        .importanceEqualTo('Secondario')
        .findAll();
    questSecondarie.clear();
    questSecondarie.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> fetchInbox() async{
    List<Quest> fetchedNotes = await isar.quests.where()
        .emailEqualTo(Auth().getCurrentUserEmail()!)
        .filter()
        .importanceEqualTo('Inbox')
        .findAll();
    questInbox.clear();
    questInbox.addAll(fetchedNotes);
    notifyListeners();
  }

  void sortList(List<Quest> lista) {
    final orderImportance = ['Urgente', 'Prioritario', 'Secondario', 'Inbox'];

    lista.sort((a, b) {
      int comparisonImportance = orderImportance.indexOf(a.importance).compareTo(orderImportance.indexOf(b.importance));
      if (comparisonImportance != 0) {
        return comparisonImportance;
      } else {
        return a.id.compareTo(b.id);
      }
    });
  }

  //U P D A T E - a note in db
  Future<void> updateNote({required int id, required String title, required String description, required int point, required String importance,
    String color = "",
  }) async{
    final existingNote = await isar.quests.get(id);
    if(existingNote != null){
      existingNote.title = title;
      existingNote.description = description;
      existingNote.points = point;
      existingNote.importance = importance;
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