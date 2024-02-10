import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/quest.dart';
import '../providers/quest_database.dart';

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
  @override
  Widget build(BuildContext context) {


    // Usa widget.parametro all'interno del widget State
    return AlertDialog(
      title: Text('Modifica quest'),
      content:
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text('Titolo: ${widget.quest.titolo}')),
          TextField(
            controller: controllerTitolo,
            decoration: InputDecoration(hintText: "Titolo"),),

          //descrizione
          Align(
              alignment: Alignment.topLeft,
              child: Text('Descrizione: ${widget.quest.descrizione}')),
          TextField(
            controller: controllerDesc,
            decoration: InputDecoration(hintText: "Descrizione"),),
          //punti
          Align(
              alignment: Alignment.topLeft,
              child: Text('Riconpensa: ${widget.quest.ricompensa}')),
          Slider(
            value: _currentValueSlider,
            onChanged: (double value) {setState(() {_currentValueSlider = value; } ); },
            min: 0,
            max: 100,
            divisions: 100,
            label: _currentValueSlider.round().toString(),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Annulla'),
          onPressed: () {
            Navigator.of(context).pop();},
        ),
        TextButton(
          child: Text('Invia'),
          onPressed: () {
            updateNote(widget.quest, controllerTitolo.text, controllerDesc.text, _currentValueSlider.toInt());
            print(controllerTitolo.text);
            Navigator.of(context).pop();},
        )
      ],
    );
  }

  void updateNote(Quest note, String ntitolo, String desc, int p){
    context.read<QuestDatabase>().updateNote(note.id, ntitolo, desc, p);
  }
}