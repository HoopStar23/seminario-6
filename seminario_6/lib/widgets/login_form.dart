import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
                hintText: 'john.doe@gmail.com',
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.alternate_email_sharp,
                    color: Colors.deepPurple)),
          )
        ],
      )),
    );
  }
}
