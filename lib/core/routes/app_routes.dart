import 'package:flutter/material.dart';
import 'package:medico/features/auth/register/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/login/presentation/screens/login_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';


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
      case signUp:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );


      default:
        return MaterialPageRoute(
          builder: (_) =>  SplashScreen(),
        );
    }
  }
}