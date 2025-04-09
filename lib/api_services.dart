import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  // Constructor to initialize the base URL for the API
  ApiService(this.baseUrl);

  // Method to register a new user
  Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phone,
    required String username,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register'); // API endpoint for registration

    try {
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

      // Debugging: Print response details
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          return jsonDecode(response.body); // Parse JSON response
        } catch (e) {
          throw Exception('Invalid JSON response: ${response.body}');
        }
      } else {
        try {
          final errorResponse = jsonDecode(response.body);
          print('Error Response: $errorResponse'); // Debugging: Log error response
          throw Exception(errorResponse['errors'] ?? errorResponse['message'] ?? 'Unknown error occurred');
        } catch (e) {
          throw Exception('Unexpected response: ${response.body}');
        }
      }
    } catch (e) {
      // Log network errors
      print('Network Error: $e');
      throw Exception('Failed to connect to the API. Please check your internet connection.');
    }
  }

  // Method to verify email using a token
  Future<Map<String, dynamic>> verifyEmail({required String token}) async {
    final url = Uri.parse('$baseUrl/auth/email/verification'); // API endpoint for email verification
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Specify JSON content type
        'Accept': 'application/json',
      },
      body: jsonEncode({'token': token}), // Send token in the request body
    );

    // Handle successful response
    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body); // Parse JSON response
      } catch (e) {
        throw Exception('Invalid JSON response: ${response.body}');
      }
    } else {
      // Handle errors and log the raw response for debugging
      print('Unexpected response: ${response.body}');
      try {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['errors'] ?? 'Unknown error occurred');
      } catch (e) {
        throw Exception('Unexpected response: ${response.body}');
      }
    }
  }

  // Method to log in a user
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/login'); // API endpoint for login
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json', // Specify JSON content type
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    // Handle successful response
    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body); // Parse JSON response
      } catch (e) {
        throw Exception('Invalid JSON response: ${response.body}');
      }
    } else {
      // Handle errors and log the raw response for debugging
      try {
        final errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message'] ?? 'Unknown error occurred');
      } catch (e) {
        throw Exception('Unexpected response: ${response.body}');
      }
    }
  }
}
