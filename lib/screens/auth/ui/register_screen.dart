import 'package:carwash/widget/forms/regester_form.dart';
import 'package:carwash/widget/logo_image.dart';
import 'package:flutter/material.dart';
class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
          child: ListView(
            children: [
              Logo(),
              RegisterForm()
            ],
          ),
        ),
      ),
    );
  }
}
