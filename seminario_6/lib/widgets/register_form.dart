import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_6/providers/register_form_provider.dart';
import 'package:seminario_6/screens/home_screen.dart';
import 'package:seminario_6/ui/input_decorations.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);

    return Container(
      child: Form(
          key: registerForm.formKey,
          child: Column(
            children: [
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
                keyboardType: TextInputType.name,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'johndoe',
                    labelText: 'Username',
                    prefixIcon: Icons.supervised_user_circle),
                onChanged: (value) => registerForm.username = value,
              ),
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
                onChanged: (value) => registerForm.email = value,
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
                onChanged: (value) => registerForm.password = value,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo no puede estar vacio';
                  } else if (value.length < 9) {
                    return 'Debe introducir un numero de telefono valido';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autocorrect: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '123456789',
                    labelText: 'Telefono',
                    prefixIcon: Icons.phone),
                onChanged: (value) => registerForm.telefono = value,
              ),
              DropdownButtonFormField(
                value: null, // Valor inicial
                decoration: InputDecorations.authInputDecoration(
                  hintText: '',
                  labelText: 'Sexo',
                  prefixIcon: Icons.verified_user_sharp,
                ),
                items: [
                  DropdownMenuItem(
                    value: 'Macho',
                    child: Text('Macho'),
                  ),
                  DropdownMenuItem(
                    value: 'Hembra',
                    child: Text('Hembra'),
                  ),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Por favor selecciona un sexo';
                  }
                  return null;
                },
                onChanged: (value) => registerForm.sexo = value!,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo no puede estar vacio';
                  }
                  // Expresión regular para validar DD-MM-YYYY o DD/MM/YYYY
                  String pattern =
                      r'^([0-2][0-9]|3[0-1])[-\/](0[1-9]|1[0-2])[-\/]\d{4}$';
                  RegExp regExp = RegExp(pattern);

                  if (!regExp.hasMatch(value)) {
                    return 'Introduce una fecha válida (DD-MM-YYYY o DD/MM/YYYY)';
                  }

                  // Validar que la fecha sea lógica (ejemplo: no futura)
                  try {
                    final dateParts = value.split(RegExp(r'[-\/]'));
                    final day = int.parse(dateParts[0]);
                    final month = int.parse(dateParts[1]);
                    final year = int.parse(dateParts[2]);

                    final parsedDate = DateTime(year, month, day);
                    final today = DateTime.now();

                    if (parsedDate.isAfter(today)) {
                      return 'La fecha no puede ser en el futuro';
                    }
                  } catch (_) {
                    return 'Introduce una fecha válida';
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autocorrect: false,
                keyboardType: TextInputType.datetime,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '',
                    labelText: 'Fecha nacimiento',
                    prefixIcon: Icons.cake),
                onChanged: (value) => registerForm.fechaNac = value,
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
                    child: Text(registerForm.isLoading ? 'Espere' : 'Registrar',
                        style: TextStyle(color: Colors.white)),
                  ),
                  onPressed: registerForm.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();

                          if (!registerForm.isValidForm()) return;

                          registerForm.isLoading = true;

                          await Future.delayed(Duration(seconds: 2));

                          registerForm.isLoading = false;

                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName);
                        })
            ],
          )),
    );
  }
}
