// import 'package:flutter/material.dart';
// import '../models/login_model.dart';
// import '../services/login_service.dart';

// class LoginViewModel extends ChangeNotifier {
//   final LoginService _loginService = LoginService();
//   bool _isLoading = false;
//   String? _error;

//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<bool> login(String username, String password) async {
//     _isLoading = true;
//     _error = null;
//     notifyListeners();

//     final response = await _loginService.login(
//       LoginModel(username: username, password: password),
//     );

//     _isLoading = false;
//     if (!response.success) {
//       _error = response.error;
//     }
//     notifyListeners();
//     return response.success;
//   }
// }
