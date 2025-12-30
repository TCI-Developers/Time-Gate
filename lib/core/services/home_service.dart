import 'package:dio/dio.dart';
import 'package:time_gate/core/models/home_day.model.dart';
import 'package:time_gate/core/models/home_user.model.dart';
import 'package:time_gate/core/network/api_client.dart';

class HomeService {
  final ApiClient apiClient = ApiClient();

  Future<({
    HomeUser user,
    List<HomeDay> days,
  })> getHome() async {
    try {
      final response = await apiClient.get('/weekly-summary');

      if (response.data['status'] != 'ok') {
        throw Exception('Respuesta inválida');
      }

      final HomeUser user =
          HomeUser.fromJson(response.data['user']);

      final List<HomeDay> days =
          (response.data['data'] as List)
              .map((e) => HomeDay.fromJson(e))
              .toList();

      return (
        user: user,
        days: days,
      );
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Error de conexión';
      throw Exception(msg);
    }
  }

  Future<Map<String,dynamic>> checkIn({required String location}) async {
    final response = await apiClient.post('/checks', 
      {
        'data': {
          'check_in': true,
          'location': location,
        }
      }
    );

    return response.data;
  }



  Future<Map<String,dynamic>> checkOut({required String location}) async {
    final response = await apiClient.post('/checks', 
        {
          'data': {
            'check_out': true,
            'location': location,
          }
        }
    );

    return response.data;
  }

  Future<Map<String, dynamic>> pause({required String activity}) async {
    final response = await apiClient.post('/checks', 
        {
          'data': {
            'pause': true,
            'activity': activity,
          }
        }
    );

    return response.data;
  }

  Future<Map<String, dynamic>> restart() async {
    final response = await apiClient.post('/checks', 
        {
          'data': {
            'restart': true,
            'activity': "",
          }
        }
    );
   
    return response.data;
  }

}
