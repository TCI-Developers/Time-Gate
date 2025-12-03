import 'package:dio/dio.dart';
import '../network/api_client.dart';

class AuthService {
  final ApiClient apiClient = ApiClient(baseUrl: 'http://localhost:3000');

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await apiClient.post('/auth/login', {
        "email": email,
        "password": password,
      });

      return response.data;
    } on DioException catch (e) {
      final msg = e.response?.data["message"] ?? "Error de conexión";
      throw Exception(msg);
    }
  }
}
