

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quest_planner/Auth.dart';

class Cloud{
  final FirebaseFirestore db  = FirebaseFirestore.instance;

  void getStarted_addData() async {
    // [START get_started_add_data_1]
    // Create a new user with a first and last name
    final user = <String, dynamic>{
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

    // Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
    // [END get_started_add_data_1]
  }

  //registra un nuovo utente
  Future<void> registerUser(String email) async {
      // [START get_started_add_data_1]
      // Create a new user with a first and last name
      final user = <String, dynamic>{
        "email": email,
        "livello": 1,
        "punti": 1,
      };

      // Add a new document with a generated ID
      db.collection("users").add(user).then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${email}'));
      // [END get_started_add_data_1]
      }

  //ottine il punteggio
  Future<int> getUserPoint() async {
    var punti = 0; // Valore di default

    try {
      var snapshot = await db.collection("users").get();
      for (var doc in snapshot.docs) {
        String email = doc.data()['email'];
        if (email == Auth().getCurrentUserEmail()) {
          punti = doc.data()['punti'];
          break; // Esci dal ciclo se hai trovato l'utente
        }
      }
    } catch (e) {
      print("Errore durante il recupero dei dati da Firebase: $e");
    }

    return punti;
  }

  //ottine il livello
  Future<int> getUserLevel() async {
    var livello = 0; // Valore di default

    try {
      var snapshot = await db.collection("users").get();
      for (var doc in snapshot.docs) {
        String email = doc.data()['email'];
        if (email == Auth().getCurrentUserEmail()) {
          livello = doc.data()['livello'];
          break; // Esci dal ciclo se hai trovato l'utente
        }
      }
    } catch (e) {
      print("Errore durante il recupero dei dati da Firebase: $e");
    }

    return livello;
  }
}