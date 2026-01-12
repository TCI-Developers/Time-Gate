import 'package:flutter/material.dart';
import 'package:time_gate/core/models/attendance_entry.dart';
import 'package:time_gate/core/models/attendance_status.model.dart';
import 'package:time_gate/core/services/attendance.service.dart';


class AttendanceProvider with ChangeNotifier {
  final AttendanceService _service = AttendanceService();

  bool isLoading = false;
  String? errorMessage;

  AttendanceStats? stats;
  List<AttendanceEntry> entries = [];

  Future<void> loadAttendance(
    {
      required String type,
      int? month,
      int? year
    }
    ) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      
      print('mero pues mero');
      final result = await _service.getAttendanceReport(
        type: type, 
        month: month, 
        year: year
      );

      print('meroooooooooooo $result');
      stats = result.stats;
      entries = result.data;
      
      // print(entries);
    } catch (e,stacktrace) {
      print('ERROR EN PROVIDER: $e');
      print('STACKTRACE: $stacktrace'); // Esto te dirá la línea exacta del fallo
      errorMessage = e is Exception 
      ? e.toString().replaceAll('Exception: ', '') 
      : 'Ocurrió un error inesperado';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    stats = null;
    entries.clear();
    errorMessage = null;
    notifyListeners();
  }
}