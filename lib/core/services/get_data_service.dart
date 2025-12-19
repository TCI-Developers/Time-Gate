import 'package:dio/dio.dart';
import 'package:time_gate/core/models/user.model.dart';
import 'package:time_gate/core/network/api_client.dart';

class DataService {
  final ApiClient apiClient = ApiClient();

  Future<UserProfile> getUserProfile() async {
    try {
      final response = await apiClient.get('/get-user');

      if (response.data['status'] != true) {
        throw Exception('Sesión inválida');
      }

      return UserProfile.fromJson(response.data['profile']);
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Error de conexión';
      throw Exception(msg);
    }
  }
}
