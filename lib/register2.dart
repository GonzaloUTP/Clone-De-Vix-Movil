import 'package:clondevix/loginandregister.dart';
import 'package:flutter/material.dart';
class Register2 extends StatefulWidget {
  const Register2({super.key});

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
});
}
  @override
  Widget build(BuildContext context) {
   if (showLoginPage) {
      return LoginScreen();
    } else {
      return RegisterScreen();
}
}
  }

