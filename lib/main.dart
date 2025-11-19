import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF5F1ED),
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.brown[900]),
      ),
      home: const SplashScreen(),
    );
  }
}
