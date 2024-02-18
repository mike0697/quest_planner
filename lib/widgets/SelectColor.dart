import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:provider/provider.dart';

import '../models/quest.dart';
import '../providers/addEditQuestProvider.dart';

class SelectColor extends StatefulWidget {
  const SelectColor({super.key, required this.quest});

  final Quest? quest;

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
    screenPickerColor = Colors.indigo;  // Material blue.
    dialogPickerColor = Colors.red;   // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
    //If the quest exists, initialize it with its color
    if(widget.quest != null){
      screenPickerColor = Color(int.parse(widget.quest!.color, radix: 16));
    }
  }

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ColorPicker(
            enableShadesSelection: false,
            // Use the screenPickerColor as start color.
            color: screenPickerColor,
            // Update the screenPickerColor using the callback.
            onColorChanged: (Color color)  {Provider.of<AddEditQuestProvider>(context, listen: false).setColor(color);
                  setState(() => screenPickerColor = color);
                },
            width: 22,
            height: 22,
            spacing: 28,
            columnSpacing: 8,
            borderRadius: 22,
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.accent: false,
              ColorPickerType.primary: true,
              ColorPickerType.bw: false,
              ColorPickerType.both: false,
              ColorPickerType.wheel: false,
            },
            subheading: Text('Select color shade',style: Theme.of(context).textTheme.titleSmall,),
          ),
        ),
    );
  }
}
