import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:medico/core/networking/dio_factory.dart';
import '../../features/auth/register/data/repo/register_repo.dart';
import '../../features/auth/register/presentation/cubit/register_cubit.dart';

GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  getIt.registerLazySingleton<RegisterRepo>(() => RegisterRepo(getIt()));

  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
}
