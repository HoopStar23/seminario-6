import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_6/providers/login_form_provider.dart';
import 'package:seminario_6/screens/home_screen.dart';
import 'package:seminario_6/ui/input_decorations.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
          key: loginForm.formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Introduce un email valido';
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'john.doe@gmail.com',
                    labelText: 'Email',
                    prefixIcon: Icons.alternate_email_sharp),
                onChanged: (value) => loginForm.email = value,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo no puede estar vacio';
                  } else if (value.length < 6) {
                    return 'Debe tener al menos 6 caracteres';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autocorrect: false,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock),
                onChanged: (value) => loginForm.password = value,
              ),
              SizedBox(height: 30),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child:
                        Text(loginForm.isLoading ? 'Espere' : 'Acceder', style: TextStyle(color: Colors.white)),
                  ),
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();

                          if (!loginForm.isValidForm()) return;

                          loginForm.isLoading = true;

                          await Future.delayed(Duration(seconds: 2));

                          loginForm.isLoading = false;

                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName);
                        })
            ],
          )),
    );
  }
}
