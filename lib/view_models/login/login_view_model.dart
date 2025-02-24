import 'package:flutter/material.dart';
import '../../models/login_model.dart';
import '../../services/login/login_service.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginService _loginService = LoginService();
  final formKey1 = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'emilys');
  final passwordController = TextEditingController(text: 'emilyspass');

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<LoginResponse> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _loginService.login(
          emailController.text.trim().toLowerCase(),
          passwordController.text.trim().toLowerCase()
          // LoginModel(
          //   username: emailController.text.trim(),
          //   password: passwordController.text.trim(),
          // ),
          );

      _isLoading = false;
      notifyListeners();
      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return LoginResponse.withError('An unexpected error occurred');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
