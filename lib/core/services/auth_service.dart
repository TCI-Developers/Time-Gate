import 'package:dio/dio.dart';
import '../network/api_client.dart';

class AuthService {
  
  final ApiClient apiClient = ApiClient();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await apiClient.post('/tenant-login', {
        "email": email,
        "password": password,
      });
      if (response.data is! Map) {
      throw Exception("La respuesta del servidor no es un objeto válido");
    }

    
    return Map<String, dynamic>.from(response.data);

    } on DioException catch (e) {

      if (e.response != null && e.response!.data != null) {
        final data = e.response!.data;

        if (data is Map && data.containsKey("message")) {
          throw Exception(data["message"]);
        } 

        if (data is String) {
          throw Exception(data);
        }
      }
        throw Exception("Error de conexión o credenciales inválidas");
      }
  }

  // Future<bool> checkSession() async{
  //   try {
  //     final response = await apiClient.get('/auth-token');
  //     if(response.data['message']=="ok")return true;
  //     return false;
      
  //   } on DioException catch (e) {
  //     final msg = e.response?.data["message"] ?? "Error de conexión";
  //     throw Exception(msg);
  //   }
  // }

  Future<bool> checkSession() async {
    try {
      // Agregamos las opciones con el extra 'silent'
      final response = await apiClient.get(
        '/auth-token',
        options: Options(extra: {'silent': true}),
      );

      // Tu lógica original de retorno
      if (response.data['message'] == "ok") return true;
      return false;
        
    } on DioException catch (e) {
      // Si es un 401 y fue silencioso, simplemente retornamos false sin lanzar excepción
      if (e.response?.statusCode == 401) {
        return false;
      }
      
      // Para otros errores de conexión o servidor, mantenemos tus mensajes
      final msg = e.response?.data["message"] ?? "Error de conexión";
      throw Exception(msg);
    }
  }
}
