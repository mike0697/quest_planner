import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/addEditQuestProvider.dart';
import '../providers/quest_database.dart';
import '../widgets/SelectColor.dart';


class AddQuestPage extends StatefulWidget {
  const AddQuestPage({super.key});

  @override
  State<AddQuestPage> createState() => _AddQuestPageState();
}

class _AddQuestPageState extends State<AddQuestPage> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();
  TextEditingController controllerCount = TextEditingController();
  double _currentValueSlider = 1.0;
  String _selectedImportance= "Inbox";
  int countExecutions = 0;
  bool? _isInfinite = false;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, ()
    {
      Provider.of<AddEditQuestProvider>(context, listen: false).setColor(
          Colors.indigo);
    });

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
                  child: const Text('Crea nuova quest', style: TextStyle(color: Colors.black, fontSize: 32),)),
              const Padding(padding: EdgeInsets.only(bottom: 30)),
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Titolo: ',style: TextStyle(color: Colors.black, fontSize: 18),)),
              TextField(
                controller: controllerTitle,
                decoration: const InputDecoration(hintText: "Titolo"),),
          
              //description
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text('Descrizione: ',style: TextStyle(color: Colors.black, fontSize: 18),)),
              TextField(
                controller: controllerDesc,
                decoration: const InputDecoration(hintText: "Descrizione"),),
              //count
              Visibility(
                visible: _isVisible,
                child: Column(children: [
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text('Numero ripetizioni: ',style: TextStyle(color: Colors.black, fontSize: 18),)),
                  TextField(
                    controller: controllerCount,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "1"),),
                ],),),
              //points
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
              //select importance
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.center,
                  child: DropdownButton<String>(
                    value: _selectedImportance,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    underline: Container(
                      height: 2,
                      color: Colors.indigo,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedImportance = newValue!;
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
              const SelectColor(quest: null),

              CheckboxListTile(
                title: const Text("Quest infinita?",style: TextStyle(color: Colors.black, fontSize: 18),),
                value: _isInfinite, onChanged: (bool? newValue)=>{
                setState(() {
                  _isInfinite = newValue;
                },)
              },
                activeColor: Colors.white,
                checkColor: Colors.indigo,
              ),

          
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
                        context.read<QuestDatabase>().addQuest(
                            title: controllerTitle.text, description: controllerDesc.text,
                            points: _currentValueSlider.toInt(),
                            color: (Provider.of<AddEditQuestProvider>(context, listen: false).myColor),
                            importance: _selectedImportance,
                            countExecutions: countExecutions,
                            infinity: false,
                        );
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
}
