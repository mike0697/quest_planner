import 'package:flutter/material.dart';
import 'package:quest_planner/widgets/SelectColor.dart';

import '../providers/addEditQuestProvider.dart';
import '../providers/quest_database.dart';
import 'package:provider/provider.dart';
class addQuest extends StatefulWidget {
  const addQuest({super.key});

  @override
  State<addQuest> createState() => _addQuestState();
}

class _addQuestState extends State<addQuest> {

  TextEditingController controllerTitolo = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  double _currentValueSlider = 1.0;
  String _valoreSelezionato= "Inbox";

  @override
  void initState() {
    Provider.of<AddEditQuestProvider>(context, listen: false).setColor(Colors.indigo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crea nuova quest'),
      content:
      SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
                alignment: Alignment.topLeft,
                child: Text('Titolo: ')),
            TextField(
              controller: controllerTitolo,
              decoration: const InputDecoration(hintText: "Titolo"),),

            //descrizione
            const Align(
                alignment: Alignment.topLeft,
                child: Text('Descrizione: ')),
            TextField(
              controller: controllerDesc,
              decoration: const InputDecoration(hintText: "Descrizione"),),
            //punti
            const Align(
                alignment: Alignment.topLeft,
                child: Text('Riconpensa: ')),
            Slider(
              value: _currentValueSlider,
              onChanged: (double value) {setState(() {_currentValueSlider = value; } ); },
              min: 0,
              max: 100,
              divisions: 100,
              label: _currentValueSlider.round().toString(),
            ),
            //seleziona importanza
            Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.center,
                child: DropdownButton<String>(
                  value: _valoreSelezionato,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _valoreSelezionato = newValue!;
                    });
                  },
                  items: <String>['Inbox', 'Secondario', 'Prioritario', 'Urgente']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 25),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const Text('Seleziona colore: ', style: TextStyle(fontSize: 18),),
                )
            ),
            SelectColor(),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Annulla'),
          onPressed: () {
            Navigator.of(context).pop();},
        ),
        TextButton(
          child: const Text('Invia'),
          onPressed: () {
            context.read<QuestDatabase>().addNote(
                titolo: controllerTitolo.text, desc: controllerDesc.text,
                punti: _currentValueSlider.toInt(),
                color: "",
                colorq: (Provider.of<AddEditQuestProvider>(context, listen: false).myString),
                importanza: _valoreSelezionato);
            Navigator.of(context).pop();},
        )
      ],
    );
  }
}
