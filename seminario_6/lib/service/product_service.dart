import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seminario_6/models/product.dart';
import 'package:http/http.dart' as http;


class ProductService extends ChangeNotifier {

  final String _baseUrl = 'flutter-varios-f5919-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Product> products = [];
  bool isLoading = false;

  ProductService(){
    this.loadProducts();
    print('Imprimiendo productos');
  }

  Future<List<Product>> loadProducts() async{
    this.isLoading= true;
    notifyListeners();

    final url = Uri.https(_baseUrl,'products.json');
    final resp = await http.get(url);

    final Map<String,dynamic> productsMap = jsonDecode(resp.body);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      print('ID: ${tempProduct.id}');
      tempProduct.id = key;
      this.products.add(tempProduct);
    });
    this.isLoading = false;
    notifyListeners();
    return this.products;
  }
}
