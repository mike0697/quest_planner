import 'package:flutter/material.dart';

class CardQuest extends StatelessWidget {
  const CardQuest ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( width: double.infinity,
        child:
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titolo
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Quest welcome 1',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),

              // Descrizione
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'La tua descrizione qui...',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),

              // Spazio tra la descrizione e i bottoni
              SizedBox(height: 16.0),

              // Bottoni
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Logica del primo pulsante
                    },
                    child: Text('Edit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Logica del secondo pulsante
                    },
                    child: Text('Esegui'),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
            ],
          ),
        )
    );
  }
}