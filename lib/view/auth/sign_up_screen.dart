import 'package:d_fine_machine_test/components/textfield.dart';
import 'package:d_fine_machine_test/controller/auth_controller/auth_controller.dart';
import 'package:d_fine_machine_test/res/Colors/color.dart';
import 'package:d_fine_machine_test/res/Sizedbox/sizedboxes.dart';
import 'package:d_fine_machine_test/res/style/buttonstyle.dart';
import 'package:d_fine_machine_test/res/style/textstyle.dart';
import 'package:d_fine_machine_test/utils/utils.dart';
import 'package:d_fine_machine_test/view/auth/login_screen.dart';
import 'package:d_fine_machine_test/view/home/home_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullNameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPassController = TextEditingController();

  final authController = Get.put(AuthController());

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    if (!EmailValidator.validate(email)) {
      return 'Enter a valid Email';
    }
    return null;
  }

  passConfirmed(TextEditingController passcontroller, TextEditingController confirmController) {
    if (passcontroller.text.trim() == confirmController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> signUp(
    AuthController authController,
    TextEditingController emailcontroller,
    TextEditingController passcontroller,
    TextEditingController confirmController,
    TextEditingController namecontroller,
  ) async {
    if (passConfirmed(passcontroller, confirmController)) {
      final msg = await authController.signUp(emailcontroller.text, passcontroller.text);

      if (msg == '') {
        authController.setLoading = false;

        return '';
      }

      Utils.snackBar('Sign Up failed', msg);

      return msg;
    } else {
      Utils.snackBar('Error', 'PassWord does not match');
      return 'PassWord does not match';
    }
  }

  @override
  void dispose() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPassController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30),
            width: Get.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text('Create an Account', style: AppTextStyle.textStyle3),
                ),
                sizedBoxh30,
                CustomTextField(
                  hint: 'Full Name',
                  controller: fullNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (pass) => pass != null && pass.length < 4 ? 'Enter min 6 Characters' : null,
                ),
                sizedBoxh30,
                CustomTextField(
                  hint: 'Email',
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: validateEmail,
                ),
                sizedBoxh30,
                CustomTextField(
                  hint: 'Password',
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (pass) => pass != null && pass.length < 6 ? 'Enter min 6 Characters' : null,
                ),
                sizedBoxh30,
                CustomTextField(
                  hint: 'Confirm Password',
                  controller: confirmPassController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (pass) => pass != null && pass.length < 6 ? 'Enter min 6 Characters' : null,
                ),
                sizedBoxh30,
                ElevatedButton(
                  onPressed: () {
                    signUp(
                      authController,
                      emailController,
                      passwordController,
                      confirmPassController,
                      fullNameController,
                    ).then((value) {
                      if (value == '') Get.to(HomePage());
                    });
                  },
                  style: AppButtonStyle.buttonStyle1,
                  child: Obx(
                    () => authController.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.whiteColor),
                          )
                        : const Text(
                            'CONTINUE',
                            style: AppTextStyle.textStyle1,
                          ),
                  ),
                ),
                sizedBoxh30,
                Center(
                  child: InkWell(
                    onTap: () => Get.to(const Login()),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account?",
                            style: AppTextStyle.textStyle2,
                          ),
                          TextSpan(
                            text: ' Login',
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
        ],
      ),
    );
  }
}
