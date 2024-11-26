import 'dart:io';

import 'package:flutter/material.dart';
import 'package:seminario_6/providers/product_form_provider.dart';
import 'package:seminario_6/widgets/getImage.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 40),
      child: Container(
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45)),
                child: getImage(url)
          ),
        ),
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 5))
            ]),
      ),
    );
  }
}
