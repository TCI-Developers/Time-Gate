import 'package:dio/dio.dart';
import '../network/api_client.dart';

class AuthService {
  final ApiClient apiClient = ApiClient(baseUrl: 'https://70e740374300.ngrok-free.app/api/');

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await apiClient.post('tenant-login', {
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
