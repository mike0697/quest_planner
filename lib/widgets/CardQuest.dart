import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_planner/QuestProvider.dart';


class CardQuest extends StatelessWidget {
  const CardQuest ({super.key});


  @override
  Widget build(BuildContext context) {
    // Accesso alla stringa
    return Consumer<QuestProvider>(
      builder: (BuildContext context, QuestProvider value, Widget? child) {
        return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8),
            child:
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titolo
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(value.currentQuest.titolo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),

                  // Descrizione
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      value.currentQuest.descrizione,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),

                  // Spazio tra la descrizione e i bottoni
                  const SizedBox(height: 16.0),

                  // Bottoni
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Logica del primo pulsante
                        },
                        child: const Text('Edit'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Logica del secondo pulsante
                        },
                        child: const Text('Esegui'),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                ],
              ),
            )
        );
      },

    );
  }
}