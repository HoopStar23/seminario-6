import 'package:flutter/material.dart';


class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool isValidForm(){
    print('$email - $password');
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}