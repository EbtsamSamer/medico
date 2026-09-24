import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medico/core/networking/dio_factory.dart';
import '../../features/auth/register/data/repo/register_repo.dart';
import '../../features/auth/register/presentation/cubit/register_cubit.dart';
import '../routes/utils/token_storage.dart';


GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final prefs = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage(getIt()));

  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(getIt(),getIt()),
  );
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
}
