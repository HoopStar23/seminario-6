import 'dart:io';

import 'package:flutter/material.dart';

Widget getImage(String? picture) {
  if (picture == null) {
    return const Image(
        image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
  }
  if (picture.startsWith('http')) {
    return FadeInImage(
      placeholder: const AssetImage('assets/jar-loading.gif'),
      image: NetworkImage(picture),
      fit: BoxFit.cover,
    );
  }
  print("Imagen");
  return Image.file(File(picture), fit: BoxFit.cover);
}
