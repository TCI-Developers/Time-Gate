import 'package:dio/dio.dart';
import 'package:time_gate/core/models/attendance_entry.dart';
import 'package:time_gate/core/models/attendance_stats.model.dart';
import 'package:time_gate/core/network/api_client.dart';

class AttendanceService {
  final ApiClient apiClient = ApiClient();

  Future<({
    AttendanceStats stats,
    List<AttendanceEntry> data,
  })> getAttendanceReport({
    required String type,
    int? month, 
    int? year,   
  }) async {
    try {
      final response = await apiClient.post('/monthly-summary', {
        'type': type,
        'month': month,
        'year': year,
      });

      if (response.data['status'] != 'ok') {
        throw Exception('Error al obtener los datos de asistencia');
      }

      final stats = AttendanceStats.fromJson(response.data['tiempos']);
      
      final List<AttendanceEntry> data = (response.data['data'] as List)
          .map((e) => AttendanceEntry.fromJson(e))
          .toList();


      return (
        stats: stats,
        data: data,
      );
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Error de conexión con el servidor';
      throw Exception(msg);
    }
  }

  Future<Map<String, dynamic>> requestVacation({
    required String start,
    required String end,
  }) async {
    try {
    
      final response = await apiClient.post('/request-vacation', {
        'inicio': start,
        'fin': end,
      });

      return response.data;
      
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Error al procesar la solicitud';
      throw Exception(msg);
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}