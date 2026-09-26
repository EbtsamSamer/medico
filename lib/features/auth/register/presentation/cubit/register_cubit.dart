import 'package:bloc/bloc.dart';
import 'package:medico/core/networking/api_result.dart';
import 'package:medico/features/profile/data/models/profile_model.dart';
import 'package:medico/features/profile/data/repo/profile_repo.dart';

import '../../data/models/rejester_request_model.dart';
import '../../data/repo/register_repo.dart';
import 'register_state.dart';
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;
  final ProfileRepo _profileRepo;

  RegisterCubit(
      this._registerRepo,
      this._profileRepo,
      ) : super(const RegisterState(status: Status.initial));

  Future<void> register(
      RegisterRequestModel registerModel,
      String phone,
      ) async {
    emit(state.copyWith(status: Status.loading));

    final response = await _registerRepo.register(registerModel);

    switch (response) {
      case Success<dynamic>(data: final data):
        final profile = ProfileModel(
          name: registerModel.name,
          username: registerModel.username,
          email: registerModel.email,
          phone: phone,
        );

        await _profileRepo.saveProfile(profile);

        emit(
          state.copyWith(
            status: Status.success,
            message: data.toString(),
          ),
        );

      case Error<dynamic>(error: final error):
        emit(
          state.copyWith(
            status: Status.error,
            message: error.toString(),
          ),
        );
    }
  }
}