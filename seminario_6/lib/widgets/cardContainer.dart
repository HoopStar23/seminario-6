import 'package:flutter/material.dart';

class Cardcontainer extends StatelessWidget {
  final Widget child;

  const Cardcontainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: createCardShape(),
        child: this.child,
      ));
  }

  BoxDecoration createCardShape() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))
        ]);
  }
}
