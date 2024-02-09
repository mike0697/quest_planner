import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_planner/models/note_database.dart';
import 'package:quest_planner/providers/ListQuestProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen ({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  String titolo = "";
  String descrizione = "";


  void createNote(){
      context.read<NoteDatabase>().addNote(titolo);
  }



  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Text('Crea una quest', style: TextStyle(fontSize: 22),),
              TextField(
                onChanged: (value){
                  titolo = value;
                },
                decoration: const InputDecoration(label: Text('Titolo')),
              ),
              TextField(
                onChanged: (value){
                  descrizione = value;
                },
                decoration: const InputDecoration(label: Text('Descrizione')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextButton(
                onPressed: () {
                  context.read<ListQuestProvider>().addQuest(titolo,descrizione);
                  print( '$titolo , $descrizione');
                },
                  child: const Text('Salva', style: TextStyle(fontSize: 22,),)),
              ),
              ElevatedButton(onPressed: createNote, child: Text('Create Note isar')),
            ],
          ),
        ),);



  }
}