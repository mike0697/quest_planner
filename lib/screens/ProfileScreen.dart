import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_planner/providers/UserProvider.dart';
import 'package:quest_planner/widgets/app_large_text.dart';
import '../Auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            //backgroundColor: Colors.indigoAccent[100],
            expandedHeight: 140,
            floating: true,
            pinned: false,
            stretch: false,
            centerTitle: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              expandedTitleScale: 1.5,
              titlePadding: EdgeInsets.only(bottom: 30, left: 20),
              title: Text("Quest Planner", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
            ),
          ),
          buildImages(context),

  ],),);

  }
  Widget buildImages(BuildContext context) => SliverToBoxAdapter(
    child: Column(
      children: [
        Padding(
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
                Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ElevatedButton(onPressed: ()=> signOut() , child: const Text('LogOut'))),
              ],
            ),
          ),
        ),

      ],
    ),
  );
}
