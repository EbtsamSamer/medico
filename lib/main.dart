import 'package:flutter/material.dart';

import 'core/di/service_locator.dart';
import 'core/routes/app_routes.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupGetIt();
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
