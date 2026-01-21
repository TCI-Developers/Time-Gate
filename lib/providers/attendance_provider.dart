import 'package:flutter/material.dart';
import 'package:time_gate/core/models/attendance_entry.dart';
import 'package:time_gate/core/models/attendance_stats.model.dart';
import 'package:time_gate/core/services/attendance.service.dart';


class AttendanceProvider with ChangeNotifier {
  final AttendanceService _service = AttendanceService();

  bool isLoading = false;
  String? errorMessage;
  String? successMessage;

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
      print(result);    
    } catch (e) {
      errorMessage = e is Exception 
      ? e.toString().replaceAll('Exception: ', '') 
      : 'Ocurrió un error inesperado';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> sendVacationRequest({
      required DateTime startDate, 
      required DateTime endDate
    }) async {
      try {
        isLoading = true;
        errorMessage = null;
        successMessage = null;
        notifyListeners();

        final response = await _service.requestVacation(
          start: "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
          end: "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        );

        if (response['status'] == 'error') {
          errorMessage = response['message'];
          return false;
        }
        successMessage = response['message'];
        return true;
      } catch (e) {
        errorMessage = e is Exception 
          ? e.toString().replaceAll('Exception: ', '') 
          : 'Error al conectar con el servidor';
        return false;
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }

    Future<bool> sendPermitRequest({
    required DateTime date,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
      notifyListeners();

      final String formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      final String formattedTime = "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";

      final response = await _service.requestPermit(
        date: formattedDate,
        time: formattedTime,
      );

      if (response['status'] == 'error') {
        errorMessage = response['message'];
        return false;
      }

      successMessage = response['message'];
      return true;
    } catch (e) {
      errorMessage = e is Exception 
        ? e.toString().replaceAll('Exception: ', '') 
        : 'Error al conectar con el servidor';
      return false;
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