import 'package:flutter/material.dart';
import 'package:time_gate/core/models/user.model.dart';
import 'package:time_gate/core/services/get_data_service.dart';

class ProfileProvider with ChangeNotifier {
  final DataService _dataService = DataService();

  bool isLoading = false;
  String? errorMessage;
  UserProfile? profile;

  Future<void> loadProfile({bool forceRefresh = false}) async {
    
    if (profile != null && !forceRefresh) {
      return;
    }

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      profile = await _dataService.getUserProfile();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Limpia el perfil (útil para logout)
  void clear() {
    profile = null;
    errorMessage = null;
    isLoading = false;
    notifyListeners();
  }
}
