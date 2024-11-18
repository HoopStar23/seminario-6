import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          PurpleBox(),
          SafeArea(),
          this.child,
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.05),
          borderRadius: BorderRadius.circular(100)),
    );
  }
}

class SafeArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 50),
      child: Icon(Icons.person_pin, color: Colors.white, size: 100),
    );
  }
}

class PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned(top: 90, left: 30, child: _Bubble()),
          Positioned(top: -40, right: -30, child: _Bubble()),
          Positioned(bottom: -50, right: -10, child: _Bubble()),
          Positioned(bottom: 120, right: 20, child: _Bubble()),
          Positioned(bottom: -50, left: -20, child: _Bubble())
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() {
    return BoxDecoration(
        gradient: LinearGradient(colors: [
      Color.fromRGBO(63, 63, 156, 1.0),
      Color.fromRGBO(90, 70, 178, 1.0)
    ]));
  }
}
