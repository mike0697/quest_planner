import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';

class UserDatabase extends ChangeNotifier {
  //INITIALIZE DATABASE
  static late Isar isar;
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [UserSchema],
      directory: dir.path,
    );
  }
  //list of users
  final List<User> currentUsers = [];

  //create a user and save
  Future<void> addUser({required String nome, required int livello, required int punti}) async{
    final newUser = User();
    newUser.nome = nome;
    newUser.livello = livello;
    newUser.punti = punti;

    //save to db
    await isar.writeTxn(() => isar.users.put(newUser));
  }

  //R E A D - users from db
  Future<void> fetchUsers() async{
    List<User> fetchedNotes = await isar.users.where().findAll();
    currentUsers.clear();
    currentUsers.addAll(fetchedNotes);
    notifyListeners();
  }

  //U P D A T E - a note in db
  Future<void> updateUser(int id, int newLivello, int newPunti) async{
    final existingUser = await isar.users.get(id);
    if( existingUser != null){
      existingUser.livello = newLivello;
      existingUser.punti = newPunti;
      await isar.writeTxn(() => isar.users.put(existingUser));
      await fetchUsers();
    }
  }

  //DELETE - a note from the db
  Future<void> deleteUser(int id) async{
    await isar.writeTxn(() => isar.users.delete(id));
    await fetchUsers();
  }


}