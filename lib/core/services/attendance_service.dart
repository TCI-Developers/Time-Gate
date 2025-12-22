import 'package:dio/dio.dart';
import 'package:time_gate/core/models/attendance_day.model.dart';
import 'package:time_gate/core/models/attendance_user.model.dart';
import 'package:time_gate/core/network/api_client.dart';

class AttendanceService {
  final ApiClient apiClient = ApiClient();

  Future<({
    AttendanceUser user,
    List<AttendanceDay> days,
  })> getAttendance() async {
    try {
      final response = await apiClient.get('/weekly-summary');

      if (response.data['status'] != 'ok') {
        throw Exception('Respuesta inválida');
      }

      final AttendanceUser user =
          AttendanceUser.fromJson(response.data['user']);

      final List<AttendanceDay> days =
          (response.data['data'] as List)
              .map((e) => AttendanceDay.fromJson(e))
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
}
