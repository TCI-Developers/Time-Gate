import 'package:flutter/material.dart';
import 'package:time_gate/core/models/attendance_day.model.dart';
import 'package:time_gate/core/models/attendance_user.model.dart';
import 'package:time_gate/core/services/attendance_service.dart';
// import 'package:time_gate/core/storage/token_storage.dart';
import 'package:time_gate/utils/get_location.dart';

class AttendanceProvider with ChangeNotifier {
  final AttendanceService _service = AttendanceService();

  bool isLoading = false;
  String? errorMessage;
  String? successMessage;
  final LocationService _locationService = LocationService();

  AttendanceUser? user;
  List<AttendanceDay> days = [];

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

  Future<bool> checkIn() async {
  try {
    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    final location = await _locationService.getLocation();
    final response = await _service.checkIn(location: location!);

    if(response['status'] == 'error'){
        errorMessage = response['message'];
        return false;
      }

    successMessage = response['message'];
    await loadAttendance();

    return true;
  } catch (e) {
    errorMessage = e is Exception
        ? e.toString().replaceAll('Exception: ', '')
        : 'Ocurrió un error inesperado';
    return false;
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

  Future<bool> checkOut() async {
    try {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
      notifyListeners();

      final location = await _locationService.getLocation();
      final response = await _service.checkOut(location: location!);

      if(response['status'] == 'error'){
        errorMessage = response['message'];
        return false;
      }

      successMessage = response['message'];

      await loadAttendance();
      return true;
    } catch (e) {
      errorMessage = e is Exception
        ? e.toString().replaceAll('Exception: ', '')
        : 'Ocurrió un error inesperado';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> pause({required String activity}) async {
    try {
      // isLoading = true;
      errorMessage = null;
      successMessage = null;
      notifyListeners();

      // final location = await _locationService.getLocation();
      final response = await _service.pause(activity:activity);

      if(response['status'] == 'error'){
        errorMessage = response['message'];
        return false;
      }
      successMessage = response['message'];
      return true;
    } catch (e) {
      errorMessage = e is Exception
        ? e.toString().replaceAll('Exception:', '')
        : 'Ocurrió un error inesperado';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> restart() async {
    try {
      isLoading = true;
      errorMessage = null;
      successMessage = null;
      notifyListeners();

      // final location = await _locationService.getLocation();
      final response = await _service.restart();

      if(response['status'] == 'error'){
        errorMessage = response['message'];
        return false;
      }

      successMessage = response['message'];
      await loadAttendance();
      return true;
    } catch (e) {
      errorMessage = e is Exception
        ? e.toString().replaceAll('Exception: ', '')
        : 'Ocurrió un error inesperado';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    user = null;
    days.clear();
    errorMessage = null;
    notifyListeners();
  }
}

