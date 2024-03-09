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
  final List<Quest> currentQuests = [];
  final List<Quest> urgentQuests = [];
  final List<Quest> priorityQuests = [];
  final List<Quest> sideQuests = [];
  final List<Quest> questInbox = [];
  final List<Quest> questsCompleted = [];

  //create a quest and save
  Future<void> addQuest({required String title, required String description, required int points, required String color,
    required String importance, required int countExecutions, required bool infinity }) async{
    final newNote = Quest();
    newNote.title = title;
    newNote.description = description;
    newNote.points = points;
    newNote.email = Auth().getCurrentUserEmail()!;
    newNote.color = color;
    newNote.importance = importance;
    newNote.countExecutions = countExecutions;
    newNote.infinity = infinity;

    //save to db
    await isar.writeTxn(() => isar.quests.put(newNote));
    fetchQuests();
    fetchUrgenti();
    fetchPrioritario();
    fetchSecondario();
    fetchInbox();
  }

  //R E A D - quests from db
  Future<void> fetchQuests() async{
    List<Quest> fetchedNotes = await isar.quests.where()
    .emailEqualTo(Auth().getCurrentUserEmail()!)
        .findAll();
    currentQuests.clear();
    currentQuests.addAll(fetchedNotes);
    sortList(currentQuests);
    notifyListeners();
  }
  //fetch only
  Future<void> fetchUrgenti() async{
    List<Quest> fetchedNotes = await isar.quests.where()
    .emailEqualTo(Auth().getCurrentUserEmail()!)
    .filter()
    .importanceEqualTo('Urgente')
        .findAll();
    urgentQuests.clear();
    urgentQuests.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> fetchPrioritario() async{
    List<Quest> fetchedNotes = await isar.quests.where()
        .emailEqualTo(Auth().getCurrentUserEmail()!)
        .filter()
        .importanceEqualTo('Prioritario')
        .findAll();
    priorityQuests.clear();
    priorityQuests.addAll(fetchedNotes);
    notifyListeners();
  }

  Future<void> fetchSecondario() async{
    List<Quest> fetchedNotes = await isar.quests.where()
        .emailEqualTo(Auth().getCurrentUserEmail()!)
        .filter()
        .importanceEqualTo('Secondario')
        .findAll();
    sideQuests.clear();
    sideQuests.addAll(fetchedNotes);
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

  void sortList(List<Quest> listQ) {
    final orderImportance = ['Urgente', 'Prioritario', 'Secondario', 'Inbox'];

    listQ.sort((a, b) {
      int comparisonImportance = orderImportance.indexOf(a.importance).compareTo(orderImportance.indexOf(b.importance));
      if (comparisonImportance != 0) {
        return comparisonImportance;
      } else {
        return a.id.compareTo(b.id);
      }
    });
  }

  //U P D A T E - a note in db
  Future<void> updateQuest({required int id, required String title, required String description,
    required int point, required String importance,
    required bool infinity,
    required int countExecutions,
    String color = "",
  }) async{
    final existingQuest = await isar.quests.get(id);
    if(existingQuest != null){
      existingQuest.title = title;
      existingQuest.description = description;
      existingQuest.points = point;
      existingQuest.importance = importance;
      existingQuest.color = color;
      existingQuest.countExecutions = countExecutions;
      existingQuest.infinity = infinity;

      await isar.writeTxn(() => isar.quests.put(existingQuest));
      await fetchQuests();
      await fetchUrgenti();
      await fetchPrioritario();
      await fetchSecondario();
      await fetchInbox();
    }
  }

  //DELETE - a note from the db
  Future<void> deleteNote(int id) async{
    await isar.writeTxn(() => isar.quests.delete(id));
    await fetchQuests();
    await fetchUrgenti();
    await fetchPrioritario();
    await fetchSecondario();
    await fetchInbox();
  }

}