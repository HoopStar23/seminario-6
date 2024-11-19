import 'package:flutter/material.dart';
import 'package:seminario_6/ui/input_decorations.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          child: Column(
        children: [
          TextFormField(
            validator: (value){
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'; 
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
                prefixIcon: Icons.alternate_email_sharp)
            ),
            TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El campo no puede estar vacio';
              }else if(value.length < 6){
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
                prefixIcon: Icons.lock)
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
                child: Text('Acceder',
                style: TextStyle(color: Colors.white)),
              ),
              onPressed: (){})
        ],
      )),
    );
  }
}
