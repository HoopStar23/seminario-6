import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_6/providers/login_form_provider.dart';
import 'package:seminario_6/screens/register_screen.dart';
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
              child: ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: Column(
                    children: [
                      Text('Login',
                          style: Theme.of(context).textTheme.headlineMedium),
                      LoginForm(),
                    ],
                  )),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(
                  context, RegisterScreen.routeName),
              style: TextButton.styleFrom(
                backgroundColor: Colors.indigo.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
              ),
              child: const Text(
                'Crear una nueva cuenta',
                style: TextStyle(
                    fontSize: 18, color: Colors.black87),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
