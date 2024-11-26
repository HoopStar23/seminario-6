import 'package:flutter/material.dart';
import 'package:seminario_6/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = 'product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(children: [
            ProductImage(),
            Positioned(
                top: 60,
                left: 20,
                child: IconButton(
                    onPressed: Navigator.of(context).pop,
                    icon: Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Colors.white,
                    ))),
            Positioned(
                top: 60,
                right: 20,
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    ))),
          ]),
          _productForm(),
        ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.save_outlined),
        ));
  }
}

class _productForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: double.infinity,
          decoration: _decoration(),
          child: Form(
              child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                  decoration:
                      authInputDecoration('Nombre del producto', 'Producto')),
              SizedBox(height: 30),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: authInputDecoration('150€', 'Precio')),
              SizedBox(height: 30),
              SwitchListTile.adaptive(
                  value: true,
                  title: Text('Disponible'),
                  activeColor: Colors.indigo,
                  onChanged: (value) {})
            ],
          )),
        ));
  }

  BoxDecoration _decoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);

  authInputDecoration(String hintText, String labelText) {
    return InputDecoration(hintText: hintText, labelText: labelText);
  }
}
