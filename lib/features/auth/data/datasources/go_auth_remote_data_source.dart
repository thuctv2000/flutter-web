import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class GoAuthRemoteDataSource implements AuthRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  GoAuthRemoteDataSource(
      {required this.dio, this.baseUrl = 'http://localhost:8081'});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '$baseUrl/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Response format: { "token": "...", "user": { "id": "...", "email": "..." } }
        final userJson = response.data['user'];
        return UserModel.fromJson(userJson);
      } else {
        throw ServerException('Login failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Unknown error');
    }
  }

  @override
  Future<void> logout() async {
    // For JWT stateless auth, logout is usually client-side (clearing token).
    // But if backend has a blacklist, we'd call it here.
    // For now, no-op or assume handled by client clearing storage.
    return;
  }

  @override
  Future<UserModel> register(String email, String password) async {
    try {
      final response = await dio.post(
        '$baseUrl/register',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        // Register returns the created user object directly (based on my Go handler)
        // Check AuthHandler.Register: json.NewEncoder(w).Encode(user) -> { "id":..., "email":... }
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException('Registration failed: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Unknown error');
    }
  }
}
