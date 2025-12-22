import 'package:flutter/material.dart';
import 'package:time_gate/core/models/attendance_day.model.dart';
import 'package:time_gate/core/models/attendance_user.model.dart';
import 'package:time_gate/core/services/attendance_service.dart';

class AttendanceProvider with ChangeNotifier {
  final AttendanceService _service = AttendanceService();

  bool isLoading = false;
  String? errorMessage;

  AttendanceUser? user;
  List<AttendanceDay> days = [];

  /// 🔄 SIEMPRE vuelve a pedir la info
  Future<void> loadAttendance() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final result = await _service.getAttendance();

      user = result.user;
      days = result.days;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Limpieza (logout)
  void clear() {
    user = null;
    days.clear();
    errorMessage = null;
    notifyListeners();
  }
}

