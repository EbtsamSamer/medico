import 'package:flutter/material.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/login/presentation/screens/login_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) =>  SplashScreen(),
        );

      case onboarding:
        return MaterialPageRoute(
          builder: (_) =>  OnboardingScreen(),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );


      default:
        return MaterialPageRoute(
          builder: (_) =>  SplashScreen(),
        );
    }
  }
}