import 'package:dio/dio.dart';

import '../../../../../core/networking/api_constants.dart';
import '../../../../../core/networking/api_error_handler.dart';
import '../../../../../core/networking/api_result.dart';
import '../../../../../core/routes/utils/token_storage.dart';
import '../models/login_request_model.dart';

class LoginRepo {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  LoginRepo(
      this._dio,
      this._tokenStorage,
      );

  Future<ApiResult<String>> login(
      LoginRequestModel request,
      ) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: request.toJson(),
      );

      final accessToken = response.data['access_token'];

      await _tokenStorage.saveToken(accessToken);

      return Success(accessToken);
    } on DioException catch (e) {
      return Error(
        ApiErrorHandler.handle(e).message,
      );
    }
  }
}