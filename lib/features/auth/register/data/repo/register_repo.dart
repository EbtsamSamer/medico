import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medico/core/networking/api_constants.dart';
import 'package:medico/core/networking/api_error_handler.dart';
import 'package:medico/core/networking/api_result.dart';
import '../../../../../core/routes/utils/token_storage.dart';
import '../models/rejester_request_model.dart';

class RegisterRepo {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  RegisterRepo(this._dio, this._tokenStorage);

  Future<ApiResult<dynamic>> register(
    RegisterRequestModel registerModel,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: registerModel.toJson(),
      );

      await _tokenStorage.saveToken(response.data['access_token']);

      return Success(response.data);
    } on DioException catch (e) {
      return Error(ApiErrorHandler.handle(e).message);
    }
  }
}
