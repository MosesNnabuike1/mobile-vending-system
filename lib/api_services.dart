import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phone,
    required String username,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'phone': phone,
        'username': username,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw Exception('Invalid JSON response: ${response.body}');
      }
    } else {
      // Log the raw response for debugging
      print('Unexpected response: ${response.body}');
      try {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['errors'] ?? 'Unknown error occurred');
      } catch (e) {
        throw Exception('Unexpected response: ${response.body}');
      }
    }
  }
}
