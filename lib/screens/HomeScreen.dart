import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen ({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  String titolo = "";
  String descrizione = "";
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
                  print( '$titolo , $descrizione');
                },
                  child: const Text('Salva', style: TextStyle(fontSize: 22,),)),
              ),
            ],
          ),
        ),);



  }
}