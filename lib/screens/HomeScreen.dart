import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_planner/providers/quest_database.dart';

import '../providers/addEditQuestProvider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen ({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _titoloController = TextEditingController();
  final TextEditingController _descrizioneController = TextEditingController();

  Map data ={
    "titolo": "",
    "descrizione": "",
    "color": ""
  };

  double _currentValueSlider = 1.0;
  String _valoreSelezionato ="Inbox";

  List<String> priority =['Urgente', 'Prioritario', 'Secondario','Inbox'];
  Color b = Colors.deepPurpleAccent;
  Color sec = Colors.white;



  @override
  Widget build(BuildContext context) {
    return Container();
  }
}