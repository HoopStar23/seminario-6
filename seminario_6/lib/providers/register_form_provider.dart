import 'package:flutter/material.dart';


class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String username = '';
  String email = '';
  String password = '';
  String telefono = '';
  String sexo = '';
  String fechaNac = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm(){
    print('$email - $password - $username - $telefono - $sexo - $fechaNac');
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}