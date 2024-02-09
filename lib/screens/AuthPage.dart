import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quest_planner/Cloud.dart';

import '../Auth.dart';
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLogin = true;

  Future<void> sigIn() async{
    try{
      await Auth().signInWithEmailAndPassword(email: _email.text, psw: _password.text);
    }on FirebaseAuthException catch (error){
      print(error.toString());
    }
  }
  Future<void> createUser() async{
    try{
      await Auth().createUserWithEmailAndPassword(email: _email.text, password: _password.text);
    }on FirebaseAuthException catch (error){
      print(error.toString());
    }
  }

  Future<void> createUserCloud() async{
    try{
      await Cloud().registerUser(_email.text);
    }on FirebaseException catch (error){
      print(error.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quest planner'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Text(isLogin ? 'Login' : 'Registrati'),
            TextField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: const InputDecoration(label: Text('email')),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(label: Text('password')),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ElevatedButton(onPressed: (){
                if(isLogin){
                  sigIn();
                }else{
                  createUser();
                  createUserCloud();
                }
              }, child: Text(isLogin ? 'Accedi' : 'registrati')),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: TextButton(onPressed: (){
                setState(() {
                  isLogin = !isLogin;
                });
              }, child: Text(isLogin ? 'non hai un account? Registrati ' : 'Hai un account? Accedi')),
            ),
          ],
        ),
      ),
    );
  }
}
