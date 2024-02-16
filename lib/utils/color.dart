import 'package:flutter/material.dart';

class AppColor{
  static const Color guidePrimary = Colors.indigo;
  static const Color c2 = Colors.blue;
  static const Color c3 = Colors.lightBlueAccent;
  static const Color c4 = Colors.purple;

  static void convertColor(){
    // Convertire un oggetto Color in una stringa
    String colorAsString = c2.value.toRadixString(16);

    print('Colore come stringa: #$colorAsString');

    // Convertire una stringa in un oggetto Color
    String colorString = 'ff0000'; // Ad esempio, rosso
    Color newColor = Color(int.parse(colorString, radix: 16));

    print('Nuovo colore da stringa: $newColor');
  }

}