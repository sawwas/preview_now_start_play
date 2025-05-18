import 'package:preview_play/src/features/presentation/getX/auth_controller.dart';

import '../../../../../constants/common_libs.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/auth_input_field.dart';
import '../../../../../widgets/login_prompt.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthController authController = Get.put(AuthController());

  RegisterPage({super.key});

  void _onRegister() {
    authController.register(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (authController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (authController.isAuthenticated.value) {
            ToastV2.show(authController.message.value);
            Future.delayed(Duration(milliseconds: 100), () {
              Get.toNamed(ScreenPaths.login);
            });
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthInputField(
                  hint: str.userName,
                  icon: Icons.person,
                  controller: _usernameController,
                ),
                SizedBox(height: 20),
                AuthInputField(
                  hint: str.email,
                  icon: Icons.email,
                  controller: _emailController,
                ),
                SizedBox(height: 20),
                AuthInputField(
                  hint: str.password,
                  icon: Icons.lock,
                  controller: _passwordController,
                  isPassword: true,
                ),
                SizedBox(height: 20),
                AuthButton(text: str.register, onPressed: _onRegister),

                SizedBox(height: 20),
                LoginPrompt(
                  title: str.alreadyHaveAnAccount,
                  subtitle: str.clickHereToLogin,
                  onTap: () {
                    Get.offAndToNamed(ScreenPaths.login);
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
