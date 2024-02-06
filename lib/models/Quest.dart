import 'package:flutter/material.dart';
class Quest {
  String titolo;
  String descrizione;
  double esperienza;
  double difficolta;
  int ricompensa;
  int id;

  Quest({
    required this.titolo,
    required this.descrizione,
    required this.esperienza,
    required this.difficolta,
    required this.ricompensa,
    required this.id,
  });
}