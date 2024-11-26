import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_6/providers/product_form_provider.dart';
import 'package:seminario_6/screens/home_screen.dart';
import 'package:seminario_6/screens/login_screen.dart';
import 'package:seminario_6/screens/product_screen.dart';
import 'package:seminario_6/screens/register_screen.dart';
import 'package:seminario_6/service/product_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Productos App',
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            color: Colors.indigo,
            elevation: 0
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.indigo,
            elevation: 0
          )
        ),    
        initialRoute: HomeScreen.routeName,
        routes: {HomeScreen.routeName: (BuildContext context) => HomeScreen(),
        LoginScreen.routeName: (BuildContext context) => LoginScreen(),
        RegisterScreen.routeName: (BuildContext context) => RegisterScreen(),
        ProductScreen.routeName: (BuildContext context) => ProductScreen()},
      ),
    );
  }
}
