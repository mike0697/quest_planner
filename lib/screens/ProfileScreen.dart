import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_planner/providers/UserProvider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen ({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Center(
        child: Column(
          children: [
            const Text('Schermata Profilo',  style: TextStyle(fontSize: 22)),
            Text('Livello: ${context.watch<UserProvider>().livello}',  style: const TextStyle(fontSize: 22)),
            Text('Punti: ${context.watch<UserProvider>().punti}',  style: const TextStyle(fontSize: 22)),
            Padding(
              padding: const EdgeInsets.only(top: 25),
                child: ElevatedButton(onPressed: ()=> context.read<UserProvider>().resetPuntiLivello() , child: const Text('Reset'))),
          ],
        ),
      ),
    );
  }
}