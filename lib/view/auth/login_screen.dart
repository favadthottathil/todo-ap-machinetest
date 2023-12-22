import 'package:d_fine_machine_test/components/textfield.dart';
import 'package:d_fine_machine_test/controller/auth_controller/auth_controller.dart';
import 'package:d_fine_machine_test/res/Colors/color.dart';
import 'package:d_fine_machine_test/res/Sizedbox/sizedboxes.dart';
import 'package:d_fine_machine_test/res/Assets/assets.dart';
import 'package:d_fine_machine_test/res/style/buttonstyle.dart';
import 'package:d_fine_machine_test/res/style/textstyle.dart';
import 'package:d_fine_machine_test/utils/utils.dart';
import 'package:d_fine_machine_test/view/auth/forgetpassword.dart';
import 'package:d_fine_machine_test/view/auth/sign_up_screen.dart';
import 'package:d_fine_machine_test/view/home/home_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  AuthController authController = Get.put(AuthController());

  void signIn(AuthController authController, String email, String pass) async {
    final msg = await authController.signIn(email, pass);

    // authController.setLoading = true;

    if (msg == '') {
      authController.setLoading = false;
      return;
    }

    Utils.snackBar('Login Failed', msg);
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(email)) {
      return 'Enter a valid Email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => StreamBuilder<User?>(
          stream: authController.stream().value,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return  HomePage();
            }

            return Scaffold(
              backgroundColor: AppColors.whiteColor,
              body: Center(
                child: SizedBox(
                  height: Get.height * 0.6,
                  width: Get.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: Get.height * 0.1,
                          width: Get.width * 0.6,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ImageAssets.mimoIcon),
                            ),
                          ),
                        ),
                      ),
                      sizedBoxh30,
                      CustomTextField(
                        hint: 'Email',
                        controller: emailController,
                        validator: validateEmail,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      sizedBoxh30,
                      CustomTextField(
                        hint: 'Password',
                        controller: passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (pass) => pass != null && pass.length < 6 ? 'Enter min 6 Characters' : null,
                      ),
                      sizedBoxh10,
                      InkWell(
                        onTap: () => Get.to(ForgetPassword()),
                        child: const Text(
                          'Forget Password?',
                          style: AppTextStyle.textStyle1,
                        ),
                      ),
                      sizedBoxh30,
                      ElevatedButton(
                        onPressed: () {
                          // set Loading True
                          // authController.setLoading = true;

                          signIn(authController, emailController.text.trim(), passwordController.text.trim());
                        },
                        style: AppButtonStyle.buttonStyle1,
                        child: Obx(
                          () => authController.isLoading
                              ? const Center(child: CircularProgressIndicator(color: AppColors.whiteColor, strokeWidth: 2))
                              : const Text(
                                  'CONTINUE',
                                  style: AppTextStyle.textStyle1,
                                ),
                        ),
                      ),
                      sizedBoxh30,
                      Center(
                        child: InkWell(
                          onTap: () => Get.to(SignUpScreen()),
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "Don't have an account?",
                                  style: AppTextStyle.textStyle2,
                                ),
                                TextSpan(
                                  text: ' Register',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
