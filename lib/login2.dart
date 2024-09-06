import 'package:clondevix/loginandregister.dart';
import 'package:clondevix/main.dart';
import 'package:clondevix/register2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login2 extends StatelessWidget {
  const Login2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage();
          }

          else {
            return LoginScreen();
          }
        },
 ),
);
  }
}