import 'package:preview_play/src/features/data/models/user_model.dart';

import '../../domain/repositories/auth_repository.dart';
import '../api/auth_api.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  AuthRepositoryImpl({required this.authApi});

  @override
  Future<UserModel?> login(String email, String password) async {
    return await authApi.login(email: email, password: password);
  }

  @override
  Future<UserModel?> register(
    String username,
    String email,
    String password,
  ) async {
    return await authApi.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
