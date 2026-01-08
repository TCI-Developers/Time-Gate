import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:time_gate/providers/auth_provider.dart';
import 'package:time_gate/utils/navigation_service.dart';
typedef VoidCallback = void Function();

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() => _instance;

  late final Dio _dio;



  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://026fdf4a8453.ngrok-free.app/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) async {
        final status = error.response?.statusCode;
        
        if (status == 401 || status == 302) {
          // 1. Mostrar modal
        showDialog(
          context: navigatorKey.currentContext!,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text('Sesión caducada'),
            content: const Text('Tu sesión ha expirado. Inicia sesión nuevamente.'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(navigatorKey.currentContext!).pop(); // cerrar modal

                  // 2. Llamar logout (él ya navega solo)
                  final auth = AuthProvider();
                  await auth.logout();
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
          

          return; 
        }
        return handler.next(error);
      },
    ),
  );


    
  }

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    return await _dio.get(endpoint, queryParameters: queryParams);
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    return await _dio.post(endpoint, data: data);
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    return await _dio.put(endpoint, data: data);
  }

  Future<Response> delete(String endpoint) async {
    return await _dio.delete(endpoint);
  }
}

