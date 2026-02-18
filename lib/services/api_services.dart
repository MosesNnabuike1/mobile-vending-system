import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiProvider {
  static const String baseUrl =
      'https://bigice.portiola.com/api/v1'; // Base URL for the API

  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
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
