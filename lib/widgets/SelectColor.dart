import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class SelectColor extends StatefulWidget {
  const SelectColor({super.key});

  @override
  State<SelectColor> createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  // Color for the picker shown in Card on the screen.
  late Color screenPickerColor;
  // Color for the picker in a dialog using onChanged.
  late Color dialogPickerColor;
  // Color for picker using the color select dialog.
  late Color dialogSelectColor;

  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.blue;  // Material blue.
    dialogPickerColor = Colors.red;   // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
  }

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Card(
          elevation: 2,
          child: ColorPicker(
            enableShadesSelection: true,
            // Use the screenPickerColor as start color.
            color: screenPickerColor,
            // Update the screenPickerColor using the callback.
            onColorChanged: (Color color) =>
                setState(() => screenPickerColor = color),
            width: 44,
            height: 44,
            borderRadius: 22,
            pickersEnabled: <ColorPickerType, bool>{
              ColorPickerType.accent: true,
              ColorPickerType.primary: true,
              ColorPickerType.bw: false,
              ColorPickerType.both: false,
              ColorPickerType.wheel: true,
            },
            heading: Text(
              'Seleziona colore',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subheading: Text('Select color shade',style: Theme.of(context).textTheme.titleSmall,),
          ),
        ),
      ),
    );
  }
}
