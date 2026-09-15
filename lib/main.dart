import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';

void main() {
  runApp(Medico());
}

class Medico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
