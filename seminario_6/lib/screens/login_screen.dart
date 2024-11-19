import 'package:flutter/material.dart';
import 'package:seminario_6/providers/login_form_provider.dart';
import 'package:seminario_6/widgets/auth_background.dart';
import 'package:seminario_6/widgets/cardContainer.dart';
import 'package:seminario_6/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';

  @override
  Widget build(BuildContext context) {
    //final loginForm = Provider.of<LoginFormProvider>(context);
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 250),
            Cardcontainer(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text('Login',
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: 30),
                  LoginForm(),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text('Crear una nueva cuenta', style: TextStyle(fontWeight: FontWeight.bold),)
          ],
        ),
      )),
    );
  }
}
