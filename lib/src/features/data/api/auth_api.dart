import '../models/user_model.dart';
import 'app_api.dart';

class AuthApi {
  AuthApi();

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    final response = await AppApi().post(
      'auth/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response['user']);
  }

  Future<UserModel?> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await AppApi().post(
      'auth/register',
      data: {'username': username, 'email': email, 'password': password},
    );
    return UserModel.fromJson(response['user']);
  }
}
