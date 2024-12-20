import 'package:flutter/material.dart';


class InputDecorations {
    static InputDecoration authInputDecoration({
        required String hintText,
        required String labelText,
        required IconData? prefixIcon,
    }){
        return InputDecoration(
            hintText: hintText,
            labelText: labelText,
            prefixIcon: prefixIcon != null 
            ? Icon(prefixIcon, color: Colors.deepPurple,)
            : null,
        );
    }
}