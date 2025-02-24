class LoginModel {
  final String username;
  final String password;
  final int expiresInMins;

  LoginModel({
    required this.username,
    required this.password,
    this.expiresInMins = 30, // Default to 30 minutes
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'expiresInMins': expiresInMins,
    };
  }
}

class LoginResponse {
  final Map<String, dynamic>? data;
  final String? error;
  final bool success;

  LoginResponse({
    this.data,
    this.error,
    required this.success,
  });

  factory LoginResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return LoginResponse(
      data: json,
      success: true,
      error: null,
    );
  }

  factory LoginResponse.withError(String error) {
    return LoginResponse(
      data: null,
      success: false,
      error: error,
    );
  }
}
