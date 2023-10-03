
import 'package:bloc_project_2/strings.dart' show enterYourEmailHere;
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController emailController;
  const EmailTextField({super.key , required this.emailController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration:const InputDecoration(
        hintText: enterYourEmailHere
      ),
    );
  }
}