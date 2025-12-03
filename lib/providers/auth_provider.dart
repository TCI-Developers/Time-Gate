import 'package:flutter/material.dart';
import '../core/services/auth_service.dart';
import '../core/storage/token_storage.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? token;
  String? errorMessage;

  Future<bool> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      final data = await _authService.login(email, password);

      if (!data.containsKey("token")) {
        throw Exception("Token no encontrado");
      }

      token = data["token"];

      // Guardar token
      await TokenStorage.saveToken(token!);

      // Set en ApiClient para futuras peticiones
      _authService.apiClient.setToken(token!);

      errorMessage = null;
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> loadSession() async {
    token = await TokenStorage.getToken();

    if (token != null) {
      _authService.apiClient.setToken(token!);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    token = null;
    await TokenStorage.deleteToken();
    notifyListeners();
  }
}
