import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico/features/auth/register/presentation/screens/register_screen.dart';
import '../../features/appoinments/presentation/cubit/apppointment_cubit.dart';
import '../../features/auth/login/data/repo/login_repo.dart';
import '../../features/auth/login/presentation/cubit/login_cubit.dart';
import '../../features/favourites/presentation/cubit/favourite_cubit.dart';
import '../../features/main_screen_for_nav.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/login/presentation/screens/login_screen.dart';
import '../di/service_locator.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => LoginCubit(getIt<LoginRepo>()),
            child: LoginScreen(),
          ),
        );

      case signUp:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => FavoriteCubit(getIt()),
              ),
              BlocProvider(
                create: (_) => AppointmentCubit(getIt()),
              ),
              BlocProvider(
                create: (_) => ProfileCubit(getIt(),getIt()),
              ),
            ],
            child: MainScreen(),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
