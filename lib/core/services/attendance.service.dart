import 'package:dio/dio.dart';
import 'package:time_gate/core/models/attendance_entry.dart';
import 'package:time_gate/core/models/attendance_status.model.dart';
import 'package:time_gate/core/network/api_client.dart';

class AttendanceService {
  final ApiClient apiClient = ApiClient();

  Future<({
    AttendanceStats stats,
    List<AttendanceEntry> data,
  })> getAttendanceReport({
    required String type,
    int? month,  // Añadimos mes opcional
    int? year,   // Añadimos año opcional
  }) async {
    try {
      // Enviamos el type y las fechas en el body
      final response = await apiClient.post('/monthly-summary', {
        'type': type,
        'month': month,
        'year': year,
      });
      print("✅ RESPUESTA API RECIBIDA: ${response.data}");
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
}