import 'package:bloc/bloc.dart';

import '../../../../../core/networking/api_result.dart';
import '../../data/models/login_request_model.dart';
import '../../data/repo/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(LoginInitial());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(LoginLoading());

    final result = await _loginRepo.login(
      LoginRequestModel(
        username: username,
        password: password,
      ),
    );

    switch (result) {
      case Success<String>():
        emit(LoginSuccess(result.data));

      case Error<String>():
        emit(LoginError(result.error));
    }
  }
}