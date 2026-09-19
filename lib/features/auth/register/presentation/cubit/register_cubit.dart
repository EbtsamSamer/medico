import 'package:bloc/bloc.dart';
import 'package:medico/core/networking/api_result.dart';

import '../../data/models/rejester_request_model.dart';
import '../../data/repo/register_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;

  RegisterCubit(this._registerRepo)
    : super(const RegisterState(status: Status.initial));

  Future<void> register(RegisterRequestModel registerModel) async {
    emit(state.copyWith(status: Status.loading));

    final response = await _registerRepo.register(registerModel);

    switch (response) {
      case Success<dynamic>(data: final data):
        emit(state.copyWith(status: Status.success, message: data.toString()));

      case Error<dynamic>(error: final error):
        emit(state.copyWith(status: Status.error, message: error.toString()));
    }
  }
}
