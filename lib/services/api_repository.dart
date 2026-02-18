import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String baseUrl;

  ApiProvider(this.baseUrl);

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      throw Exception('Error during POST request: $e');
    }
  }
}

class ApiRepository {
  final ApiProvider _apiProvider;

  ApiRepository(String baseUrl) : _apiProvider = ApiProvider(baseUrl);

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
