import 'package:flutter/material.dart';
import 'package:time_gate/core/models/attendance_entry.dart';
import 'package:time_gate/core/models/attendance_stats.model.dart';
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
      final result = await _service.getAttendanceReport(
        type: type, 
        month: month, 
        year: year
      );

      stats = result.stats;
      entries = result.data;      
      print(entries);
    } catch (e) {
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