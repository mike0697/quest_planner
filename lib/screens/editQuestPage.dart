import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/quest.dart';
import '../providers/addEditQuestProvider.dart';
import '../providers/quest_database.dart';
import '../widgets/SelectColor.dart';


class EditQuestPage extends StatefulWidget {
  final Quest quest;

  const EditQuestPage({Key? key, required this.quest}) : super(key: key);

  @override
  State<EditQuestPage> createState() => _AddQuestPageState();
}

class _AddQuestPageState extends State<EditQuestPage> {
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
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //ElevatedButton(onPressed: (){Navigator.pop(context);}, child: const Icon(Icons.back_hand)),
              //title
              Container(
                  alignment: Alignment.topLeft,
                  child: const Text('Modifica quest', style: TextStyle(color: Colors.black, fontSize: 32),)),
              const Padding(padding: EdgeInsets.only(bottom: 30)),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Titolo: ',style: TextStyle(color: Colors.black, fontSize: 18),)),
              TextField(
                controller: controllerTitolo,
                decoration: const InputDecoration(hintText: "Titolo"),),

              //descrizione
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Descrizione: ',style: TextStyle(color: Colors.black, fontSize: 18),)),
              TextField(
                controller: controllerDesc,
                decoration: const InputDecoration(hintText: "Descrizione"),),
              //punti
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Riconpensa: ',style: TextStyle(color: Colors.black, fontSize: 18),)),

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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextButton(
                      child: const Text('Annulla', style: TextStyle(fontSize: 18),),
                      onPressed: () {
                        Navigator.of(context).pop();},
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextButton(
                      child: const Text('Invia', style: TextStyle(fontSize: 18),),
                      onPressed: () {
                        updateQuest(widget.quest, controllerTitolo.text, controllerDesc.text, _currentValueSlider.toInt());
                        Navigator.of(context).pop();},
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 140)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void updateQuest(Quest quest, String title, String description, int point){
    context.read<QuestDatabase>().updateQuest(id: quest.id, title: title, description: description,
        point: point,importance: _valoreSelezionato,
        color: (Provider.of<AddEditQuestProvider>(context, listen: false).myColor));
  }
}