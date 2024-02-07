import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quest planner'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Text('login'),
          TextField(
            controller: _email,
            decoration: const InputDecoration(label: Text('email')),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(label: Text('password')),
          ),
          ElevatedButton(onPressed: (){
            isLogin ? sigIn() : createUser();

          }, child: Text(isLogin ? 'Accedi' : 'registrati')),

          TextButton(onPressed: (){
            setState(() {
              isLogin = !isLogin;
            });
          }, child: Text(isLogin ? 'non hai un account? Registrati ' : 'Hai un account? Accedi')),
        ],
      ),
    );
  }
}
