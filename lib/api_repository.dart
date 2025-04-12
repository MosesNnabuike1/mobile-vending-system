import 'package:mobile_vending_app/api_services.dart'; // Import the ApiProvider class

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider(); // Use centralized ApiProvider

  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phone,
    required String username,
  }) async {
    return _apiProvider.post('/auth/register', {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'phone': phone,
      'username': username,
    });
  }

  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String token,
  }) async {
    return _apiProvider.post('/auth/email/verification', {
      'email': email,
      'token': token,
    });
  }

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    return _apiProvider.post('/auth/login', {
      'email': email,
      'password': password,
    });
  }
}
