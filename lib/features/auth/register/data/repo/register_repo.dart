import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medico/core/networking/api_constants.dart';
import 'package:medico/core/networking/api_error_handler.dart';
import 'package:medico/core/networking/api_result.dart';
import '../models/rejester_request_model.dart';

class RegisterRepo {
  final Dio _dio;

  RegisterRepo(this._dio);

  Future<ApiResult<dynamic>> register(
    RegisterRequestModel registerModel,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: registerModel.toJson(),
      );

      final token = response.data['access_token'];

      await saveToken(token);

      return Success(response.data);
    } on DioException catch (e) {
      return Error(ApiErrorHandler.handle(e).message);
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
  }
}
