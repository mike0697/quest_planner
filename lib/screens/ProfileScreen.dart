import 'package:flutter/material.dart';
import 'package:quest_planner/Cloud.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Center(
        child: Column(
          children: [
            Text('Schermata Profilo',  style: TextStyle(fontSize: 22)),
            ElevatedButton(onPressed: (){
              Cloud().getUserPoint();
            }, child: Text('prova firebase', style: TextStyle(fontSize: 22),)),


          ],
        ),
      ),
    );
  }
}