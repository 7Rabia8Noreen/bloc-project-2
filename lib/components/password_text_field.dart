
import 'package:bloc_project_2/strings.dart' show enterYourPasswordHere;
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordTextField({super.key , required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: passwordController,
     
      obscureText: true,
      decoration:const InputDecoration(
        hintText: enterYourPasswordHere
      ),
    );
  }
}