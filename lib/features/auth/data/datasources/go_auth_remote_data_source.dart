import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class GoAuthRemoteDataSource implements AuthRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  GoAuthRemoteDataSource(
      {required this.dio, this.baseUrl = AppConstants.apiBaseUrl});

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
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('error')) {
        final errorMessage = data['error'];
        // Optional: Map backend English errors to Vietnamese here if desired
        if (errorMessage == 'invalid credentials') {
          throw ServerException('Thông tin đăng nhập không chính xác');
        }
        throw ServerException(errorMessage);
      }

      if (e.response?.statusCode == 401) {
        throw ServerException('Thông tin đăng nhập không chính xác');
      } else if (e.response?.statusCode == 400) {
        throw ServerException('Dữ liệu không hợp lệ');
      }
      throw ServerException(e.message ?? 'Lỗi kết nối máy chủ');
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
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('error')) {
        throw ServerException(data['error']);
      }
      throw ServerException(e.message ?? 'Unknown error');
    }
  }
}
