import 'package:flutter/material.dart';
import 'package:time_gate/utils/clear_all_providers.dart';
import 'package:time_gate/utils/navigation_service.dart';
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
    print(token);
    if (token == null) return false;
    
    _authService.apiClient.setToken(token!);
    
    try {
      final isValid = await _authService.checkSession().timeout(const Duration(seconds: 8));
      if (!isValid) {
        await logout();
        return false;
      }
    } catch (_) {
      await logout(); // Si hay timeout, mejor desloguear por seguridad
      return false;
    }

    notifyListeners();
    return true;
  }


  Future<void> logout([BuildContext? context]) async {
      
    token = null;       
    errorMessage = null;   
    isLoading = false; 

    await TokenStorage.deleteToken();
    _authService.apiClient.clearToken();
    
    if (context != null && context.mounted) {
      clearAllProviders(context); 
    }  
    
    notifyListeners();

    navigatorKey.currentState?.pushNamedAndRemoveUntil('login', (route) => false);
  }
}
