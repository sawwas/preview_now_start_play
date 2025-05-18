import 'package:preview_play/src/features/presentation/getX/auth_controller.dart';

import '../../../../../constants/common_libs.dart';
import '../../../../../widgets/auth_button.dart';
import '../../../../../widgets/auth_input_field.dart';
import '../../../../../widgets/login_prompt.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController(
    text: "san2@gmail.com",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "qazzaq123",
  );

  final AuthController authController = Get.find<AuthController>();

  void _onLogin() {
    authController.login(_emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Obx(() {
          if (authController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (authController.isAuthenticated.value) {
            Future.delayed(Duration(milliseconds: 100), () {
              Get.offAllNamed(ScreenPaths.conversationPage);
            });
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                AuthButton(text: str.login, onPressed: _onLogin),
                SizedBox(height: 20),
                LoginPrompt(
                  title: str.dont_have_an_account,
                  subtitle: str.click_here_to_register,
                  onTap: () {
                    Get.offAndToNamed(ScreenPaths.registerPage);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Tapped(
                      onTap: () {
                        Get.toNamed(ScreenPaths.snappyTestPage);
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Text('SnappyTest', style: sty.text.t5Regular),
                      ),
                    ),
                    Tapped(
                      onTap: () {
                        Get.toNamed(ScreenPaths.webSocketTestPage);
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Text('WSTest', style: sty.text.t5Regular),
                      ),
                    ),
                    Tapped(
                      onTap: () {
                        Get.toNamed(ScreenPaths.pigeonsTestPage);
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Text('PigeonsTest', style: sty.text.t5Regular),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
