import 'package:flutter/material.dart';
import 'package:medico/features/splash/presentation/screens/splash_screen.dart';

void main() {
  runApp(Medico());
}

class Medico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
    );
  }
}
