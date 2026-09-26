import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medico/core/networking/dio_factory.dart';
import '../../features/appoinments/data/repo/appointment_repo.dart';
import '../../features/appoinments/presentation/cubit/apppointment_cubit.dart';
import '../../features/auth/login/data/repo/login_repo.dart';
import '../../features/auth/register/data/repo/register_repo.dart';
import '../../features/auth/register/presentation/cubit/register_cubit.dart';
import '../../features/favourites/data/repo/favourite_repo.dart';
import '../../features/profile/data/repo/profile_repo.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../routes/utils/token_storage.dart';

GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final prefs = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage(getIt()));

  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(getIt(), getIt()),
  );
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt(), getIt()));
  getIt.registerLazySingleton<FavoriteRepo>(() => FavoriteRepo(getIt()));
  getIt.registerLazySingleton<AppointmentRepo>(() => AppointmentRepo(getIt()));
  getIt.registerFactory<AppointmentCubit>(() => AppointmentCubit(getIt()));
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt(), getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt(), getIt()));
}
