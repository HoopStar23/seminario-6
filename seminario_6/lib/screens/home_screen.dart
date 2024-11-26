import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_6/screens/screens.dart';
import 'package:seminario_6/service/product_service.dart';
import 'package:seminario_6/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);


    if (productService.isLoading) return LoadingScreen();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: productService.products.length,
            itemBuilder: (context, index) {
              return Productcard(product: productService.products[index]);
            }),
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
    );
  }
}
