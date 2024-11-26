import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seminario_6/providers/product_form_provider.dart';
import 'package:seminario_6/service/product_service.dart';
import 'package:seminario_6/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = 'product';

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProductFormProvider(productService.selectedProduct),
        child: _ProductScreenBody(productService: productService));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key, required this.productService,
  });

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(children: [
            ProductImage(url: productForm.product.picture),
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
          _productForm(productFormProvider: productForm),
        ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            if(productForm.isValidForm())return;

            await productService.saveOrCreateProduct(productForm.product);},
          child: Icon(Icons.save_outlined),
        ));
  }
}

class _productForm extends StatelessWidget {
  final ProductFormProvider productFormProvider;

  const _productForm({super.key, required this.productFormProvider});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: double.infinity,
          decoration: _decoration(),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                  initialValue: productFormProvider.product.name,
                  onChanged: (value) =>
                      productFormProvider.product.name = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligatorio';
                  },
                  decoration:
                      authInputDecoration('Nombre del producto', 'Producto')),
              SizedBox(height: 30),
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')) ],
                  initialValue: '${productFormProvider.product.price}',
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      productFormProvider.product.price = 0;
                    } else {
                      productFormProvider.product.price =
                          double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: authInputDecoration('150€', 'Precio')),
              SizedBox(height: 30),
              SwitchListTile.adaptive(
                  value: productFormProvider.product.available,
                  title: Text('Disponible'),
                  activeColor: Colors.indigo,
                  onChanged: (value) {
                    productFormProvider.updateAvailability(value);
                  })
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
