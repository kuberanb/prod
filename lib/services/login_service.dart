import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:prod/utils/api_end_points.dart';
import '../models/login_model.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<LoginResponse> login(
    // LoginModel loginModel
    String username,
    String password,
  ) async {
    //  log("login queryparameters : ${loginModel.toJson().toString()}");

    const url = '${ApiEndPoints.kBaseUrl}${ApiEndPoints.login}';
    log("url : $url");
    log("username :$username");
    log("password :$password");
    log("username length : ${username.length}");
    log("password : ${password.length}");

    try {
      final response = await _dio.post(
        url,
        data: {
          "username": username.trim(),

          //    'emilys',
          "password": password.trim(),
          //    'emilyspass',
        },

        //  loginModel.toJson().toString(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      log("login response : $response");

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        final errorData = response.data;
        return LoginResponse.withError(errorData['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      log("exception : $e");
      return LoginResponse.withError(
        e.response?.data?['message'] ?? 'An error occurred: ${e.message}',
      );
    } catch (e) {
      return LoginResponse.withError('An unexpected error occurred: $e');
    }
  }
}
