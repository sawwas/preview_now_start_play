import 'package:preview_play/src/features/data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> login(String email, String password);

  Future<UserModel?> register(String username, String email, String password);
}
