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
            MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child:
                        Text('Crear una nueva cuenta', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () => Navigator.pushReplacementNamed(context, RegisterScreen.routeName)
                  )
          ],
        ),
      )),
    );
  }
}
