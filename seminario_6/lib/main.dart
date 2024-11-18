import 'package:flutter/material.dart';
import 'package:seminario_6/screens/home_screen.dart';
import 'package:seminario_6/screens/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
      initialRoute: LoginScreen.routeName,
      routes: {HomeScreen.routeName: (BuildContext context) => HomeScreen(),
      LoginScreen.routeName: (BuildContext context) => LoginScreen()}
    );
  }
}