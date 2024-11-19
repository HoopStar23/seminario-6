import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_6/providers/register_form_provider.dart';
import 'package:seminario_6/widgets/auth_background.dart';
import 'package:seminario_6/widgets/cardContainer.dart';
import 'package:seminario_6/widgets/login_form.dart';
import 'package:seminario_6/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
                child: Column(children: [
      SizedBox(height: 250),
      Cardcontainer(
        child: ChangeNotifierProvider(
            create: (_) => RegisterFormProvider(),
            child: Column(
              children: [
                Text('Registrar',
                    style: Theme.of(context).textTheme.headlineMedium),
                RegisterForm(),
              ],
            )),
      )
    ]))));
  }
}
