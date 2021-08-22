import 'package:flutter/material.dart';
import 'package:surplus/screens/product_list.dart';
import 'package:surplus/screens/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surplus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: SignInScreen(),
      routes: {
        '/productlist': (context) => ProductList(),
        // '/productdesc': (cobtext) => ProductDesc(),
        '/signIn': (context) => SignInScreen(),
      },
    );
  }
}