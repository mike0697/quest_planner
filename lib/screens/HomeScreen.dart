import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_planner/providers/quest_database.dart';

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




  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Crea una quest', style: TextStyle(fontSize: 22),),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'inserisci un titolo';
                      }
                      return null;
                    },
                    onSaved: (value){
                      data['titolo']= value;
                    },
                    controller: _titoloController,
                    decoration: const InputDecoration(
                        label: Text('Titolo')),
                  ),
                  TextFormField(
                    validator: (value){
                      return null;
                    },
                    onSaved: (value){
                      data['descrizione']= value;
                    },
                    controller: _descrizioneController,
                    decoration: const InputDecoration(
                        label: Text('Descrizione')),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 25),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: const Text('Riconpensa', style: TextStyle(fontSize: 18),),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Slider(value: _currentValueSlider,
                      onChanged: (double value) {setState(() {
                        _currentValueSlider = value;  });
                      },
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _currentValueSlider.round().toString(),
                    ),
                  ),
              
                  Padding(padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text('Seleziona colore: ', style: TextStyle(fontSize: 18),),
                      )
                  ),
              
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: (){data['color'] = 'white';}, icon: Icon(Icons.brightness_1_outlined, color: Colors.black,)),
                        IconButton(onPressed: (){data['color'] = 'blue';}, icon: Icon(Icons.brightness_1, color: Colors.blue,)),
                        IconButton(onPressed: (){data['color'] = 'green';}, icon: Icon(Icons.brightness_1, color: Colors.green,)),
                        IconButton(onPressed: (){data['color'] = 'red';}, icon: Icon(Icons.brightness_1, color: Colors.red,)),
                        IconButton(onPressed: (){data['color'] = 'dpurple';}, icon: Icon(Icons.brightness_1, color: Colors.deepPurple,)),
                      ],
                    ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){data['color'] = 'pink';}, icon: Icon(Icons.brightness_1, color: Colors.pink,)),
                      IconButton(onPressed: (){data['color'] = 'yellow';}, icon: Icon(Icons.brightness_1, color: Colors.yellow,)),
                      IconButton(onPressed: (){data['color'] = 'orange';}, icon: Icon(Icons.brightness_1, color: Colors.orange,)),
                    ],
                  ),
              
              
              
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: TextButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()){
                            _formkey.currentState!.save();
                            String titolo = data["titolo"];
                            String desc = data["descrizione"];
                            String color = data["color"];
                            //crea una nota
                            context.read<QuestDatabase>().addNote(titolo: titolo, desc: desc, punti: _currentValueSlider.toInt() , color: color);
                            // Pulisci i controller e resetta il form
                            _titoloController.clear();
                            _descrizioneController.clear();
                            _formkey.currentState!.reset();
                            }
                          },
                        child: const Text('Salva', style: TextStyle(fontSize: 22)),
                    ),
                  ),
              
              
                ],
              ),
            ),
          ),
        );
  }
}