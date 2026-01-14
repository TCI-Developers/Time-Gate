import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        baseUrl: 'https://0ffacd6ade7f.ngrok-free.app/api',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      ),
    );

  _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          final status = error.response?.statusCode;
          if (status == 401) {
            final ctx = navigatorKey.currentContext;
            
            if (ctx != null) {
              // No limpiamos aquí, dejamos que el logout lo haga todo
              await showDialog(
                context: ctx,
                barrierDismissible: false,
                builder: (_) => AlertDialog(
                  title: const Text('Sesión caducada'),
                  content: const Text('Tu sesión ha expirado. Inicia sesión nuevamente.'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        Navigator.of(ctx).pop();
                        
                        // IMPORTANTE: Pasamos el 'ctx' para que limpie los providers
                        await ctx.read<AuthProvider>().logout(ctx); 
                      },
                      child: const Text('Aceptar'),
                    ),
                  ],
                ),
              );
            } else {
              // Si no hay contexto, lanzamos el logout sin contexto
              // Pero necesitamos la instancia real. Si no la hay, no podemos hacer mucho más que navegar.
              // navigatorKey.currentState?.pushNamedAndRemoveUntil('login', (route) => false);
            }
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

