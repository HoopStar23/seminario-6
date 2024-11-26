import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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

class _ProductScreenBody extends StatefulWidget {
  const _ProductScreenBody({super.key, required this.productService});
  final ProductService productService;

  @override
  State<_ProductScreenBody> createState() => _ProductScreenBodyState();
}

class _ProductScreenBodyState extends State<_ProductScreenBody> {
  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(), // Fecha inicial
      firstDate: DateTime(2000), // Primera fecha permitida
      lastDate: DateTime(2100), // Última fecha permitida
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        // Actualizar el controlador con la fecha seleccionada
        dateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }

    @override
    void dispose() {
      dateController.dispose(); // Liberar recursos del controlador
      super.dispose();
    }
  }

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
                    onPressed: () async {
                      if (productForm.isValidForm()) return;
                      final String? imageUrl =
                          await widget.productService.uploadImage();
                      if (imageUrl != null)
                        productForm.product.picture = imageUrl;
                      print(imageUrl);
                      await _processImage(widget.productService);
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    ))),
            Positioned(
                top: 160,
                right: 20,
                child: IconButton(
                    onPressed: () async {
                      if (productForm.isValidForm()) return;
                      final String? imageUrl =
                          await widget.productService.uploadImage();
                      if (imageUrl != null)
                        productForm.product.picture = imageUrl;
                      print(imageUrl);
                      await _lookImage(widget.productService);
                    },
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 40,
                      color: Colors.white,
                    ))),
          ]),
          _productForm(
              productFormProvider: productForm,
              dateController: dateController,
              onDateSelect: () => _selectDate(context)),
        ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (productForm.isValidForm()) return;

            await widget.productService
                .saveOrCreateProduct(productForm.product);
          },
          child: widget.productService.isSaving
              ? const CircularProgressIndicator(color: Colors.white)
              : Icon(Icons.save_outlined),
        ));
  }
}

Future<void> _processImage(ProductService productService) async {
  final _picker = ImagePicker();
  final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);

  if (pickedFile == null) {
    print('No seleccionó nada');
  } else {
    print('Tenemos imagen ${pickedFile.path}');
    productService.updateSelectedProductImage(pickedFile.path);
    productService.uploadImage();
  }
}

Future<void> _lookImage(ProductService productService) async {
  final _picker = ImagePicker();
  final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

  if (pickedFile == null) {
    print('No seleccionó nada');
  } else {
    print('Tenemos imagen ${pickedFile.path}');
    productService.updateSelectedProductImage(pickedFile.path);
    productService.uploadImage();
  }
}

class _productForm extends StatelessWidget {
  final ProductFormProvider productFormProvider;
  final TextEditingController dateController;
  final VoidCallback onDateSelect;

  const _productForm(
      {super.key,
      required this.productFormProvider,
      required this.dateController,
      required this.onDateSelect});
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
                      decoration: authInputDecoration(
                          'Nombre del producto', 'Producto')),
                  SizedBox(height: 30),
                  TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^(\d+)?\.?\d{0,2}'))
                      ],
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
                  TextFormField(
                    onChanged: (value) {
                      productFormProvider.product.date = value;
                                        },
                    controller: dateController,
                    decoration: authInputDecoration('Fecha Registro',''),
                    onTap: onDateSelect,
                  ),
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
