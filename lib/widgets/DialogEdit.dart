import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/quest.dart';
import '../providers/addEditQuestProvider.dart';
import '../providers/quest_database.dart';
import 'SelectColor.dart';

class MyWidget extends StatefulWidget {
  final Quest quest;

  // Costruttore con parametro
  MyWidget({required this.quest});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}


class _MyWidgetState extends State<MyWidget> {
  TextEditingController controllerTitolo = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  double _currentValueSlider = 1.0;
  String _valoreSelezionato= "";
  @override
  void initState() {
    super.initState();
    _valoreSelezionato = widget.quest.importance;
    if(widget.quest.importance == null || widget.quest.importance.isEmpty) {
      _valoreSelezionato = 'Inbox';
    }
    Provider.of<AddEditQuestProvider>(context, listen: false).setColor(Color(int.parse(widget.quest.color, radix: 16)));
    controllerTitolo = TextEditingController(text: widget.quest.title);
    controllerDesc = TextEditingController(text: widget.quest.description);
    _currentValueSlider = widget.quest.points.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    // Usa widget.parametro all'interno del widget State
    return AlertDialog(
      title: const Text('Modifica quest'),
      content:
      SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text('Titolo: ${widget.quest.title}')),
            TextField(
              controller: controllerTitolo,
              decoration: const InputDecoration(hintText: "Titolo"),),
        
            //descrizione
            Align(
                alignment: Alignment.topLeft,
                child: Text('Descrizione: ${widget.quest.description}')),
            TextField(
              controller: controllerDesc,
              decoration: const InputDecoration(hintText: "Descrizione"),),
            //punti
            Align(
                alignment: Alignment.topLeft,
                child: Text('Riconpensa: ${widget.quest.points}')),
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
              padding: const EdgeInsets.all(10),
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
            SelectColor(quest: widget.quest),
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
            updateNote(widget.quest, controllerTitolo.text, controllerDesc.text, _currentValueSlider.toInt());
            Navigator.of(context).pop();},
        )
      ],
    );
  }

  void updateNote(Quest quest, String title, String description, int point){
    context.read<QuestDatabase>().updateNote(id: quest.id, title: title, description: description,
        point: point,importance: _valoreSelezionato,
        color: (Provider.of<AddEditQuestProvider>(context, listen: false).myColor));
  }
}