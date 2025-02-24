import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:prod/models/login/user_model.dart';
import 'package:prod/utils/api_end_points.dart';
import 'package:prod/views/widgets/snackbar.dart';

class LoginService {
  static Future<UserModel?> getUsersList(
    context,
  ) async {
    final dio = Dio();
    UserModel? userModel;
    try {
      Response response = await dio
          .get(
            '${ApiEndPoints.kBaseUrl}${ApiEndPoints.kAuth}',
            options: Options(headers: {
              'Content-Type': 'application/json',
            }),
          )
          .timeout(
            const Duration(seconds: 30),
          );
      print('api response : ${response.data.toString()}');
      if (response.statusCode == 200) {
        print('status code 200 triggered');
        final dynamic data = response.data;

        userModel = UserModel.fromJson(data);

        return userModel;
      }
    } on SocketException {
      showSnackBar(context, 'No Internet');
      print('No Internet');
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => const ErrorScreen()));
    } on TimeoutException {
      showSnackBar(context, 'Connection Timeout, Refresh the page');
      print('Connection Timeout, Refresh the page');
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => const ErrorScreen()));
    } catch (e) {
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => const ErrorScreen()));
      // showSnackBar(context, 'Some Error Occured');

      print('Some Exception Occured In Api : ${e}');
    }
    return userModel;
  }
}
