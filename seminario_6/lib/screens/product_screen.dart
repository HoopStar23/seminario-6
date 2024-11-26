import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  final ProductService productService;

  const _ProductScreenBody({super.key, required this.productService});

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
                          await productService.uploadImage();
                      if (imageUrl != null)
                        productForm.product.picture = imageUrl;
                      print(imageUrl);
                      await _processImage(productService);
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
                          await productService.uploadImage();
                      if (imageUrl != null)
                        productForm.product.picture = imageUrl;
                      print(imageUrl);
                      await _lookImage(productService);
                    },
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 40,
                      color: Colors.white,
                    ))),
          ]),
          _productForm(productFormProvider: productForm),
        ])),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (productForm.isValidForm()) return;

            await productService.saveOrCreateProduct(productForm.product);
          },
          child: productService.isSaving
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

class _productForm extends StatefulWidget {
  final ProductFormProvider productFormProvider;

  const _productForm({super.key, required this.productFormProvider});

  @override
  State<_productForm> createState() => _productFormState();
}

class _productFormState extends State<_productForm> {
  DateTime? _selectedDate;
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

  final TextEditingController _dateController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _dateController.text = widget.productFormProvider.product.date!;
    if (_dateController.text.isNotEmpty) {
      try {
        _selectedDate = dateFormatter.parse(_dateController.text);
      } catch (e) {
        print("Formato de fecha no válido: ${_dateController.text}");
        _selectedDate = null;
      }
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

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
                      initialValue: widget.productFormProvider.product.name,
                      onChanged: (value) =>
                          widget.productFormProvider.product.name = value,
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
                      initialValue:
                          '${widget.productFormProvider.product.price}',
                      onChanged: (value) {
                        if (double.tryParse(value) == null) {
                          widget.productFormProvider.product.price = 0;
                        } else {
                          widget.productFormProvider.product.price =
                              double.parse(value);
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: authInputDecoration('150€', 'Precio')),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    validator: (value) {
                      if (_dateController.text == '') {
                        return "Introduce una fecha de registro";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    keyboardType: TextInputType.datetime,
                    decoration: authInputDecoration('', "Seleccione una fecha"),
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: 30),
                  SwitchListTile.adaptive(
                      value: widget.productFormProvider.product.available,
                      title: Text('Disponible'),
                      activeColor: Colors.indigo,
                      onChanged: (value) {
                        widget.productFormProvider.updateAvailability(value);
                      })
                ],
              )),
        ));
  }

    Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Actualiza el controlador con la fecha formateada
        _dateController.text = "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
        widget.productFormProvider.product.date = _dateController.text;
      });
    }
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
