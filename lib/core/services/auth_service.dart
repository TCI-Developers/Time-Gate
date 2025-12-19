import 'package:dio/dio.dart';
import '../network/api_client.dart';

class AuthService {
  // final ApiClient apiClient = ApiClient(baseUrl: 'https://38c3d72d2c20.ngrok-free.app/api');
  final ApiClient apiClient = ApiClient();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await apiClient.post('/tenant-login', {
        "email": email,
        "password": password,
      });

      return response.data;
    } on DioException catch (e) {
      final msg = e.response?.data["message"] ?? "Error de conexión";
      throw Exception(msg);
    }
  }

  Future<bool> checkSession() async{
    try {
      final response = await apiClient.get('/auth-token');
      if(response.data['message']=="ok")return true;
      return false;
      
    } on DioException catch (e) {
      final msg = e.response?.data["message"] ?? "Error de conexión";
      throw Exception(msg);
    }
  }
}
