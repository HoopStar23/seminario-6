import 'package:flutter/material.dart';
import 'package:seminario_6/models/product.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  bool isValidForm() {
    print(product.name);
    print(product.price);
    print(product.available);
    print(product.date);
    return formkey.currentState?.validate() ?? false;
  }

  updateAvailability(bool value) {
    product.available = value;
    notifyListeners();
  }
}
