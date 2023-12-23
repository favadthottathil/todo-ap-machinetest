import 'package:d_fine_machine_test/components/textfield.dart';
import 'package:d_fine_machine_test/controller/auth_controller/auth_controller.dart';
import 'package:d_fine_machine_test/res/Colors/color.dart';
import 'package:d_fine_machine_test/res/Sizedbox/sizedboxes.dart';
import 'package:d_fine_machine_test/res/style/buttonstyle.dart';
import 'package:d_fine_machine_test/res/style/textstyle.dart';
import 'package:d_fine_machine_test/utils/utils.dart';
import 'package:d_fine_machine_test/view/auth/login_screen.dart';
import 'package:d_fine_machine_test/view/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();

  final authController = Get.put(AuthController());

  Future<String> forgetPassword(AuthController authController, String email) async {
    final msg = await authController.resetPassword(email);
    // authController.setLoading = true;

    if (msg == '') {
      authController.setLoading = false;
      Utils.snackBar('Email Send', 'Email send successfully');
      return msg;
    }

    Utils.snackBar('PassWord ResetFailed', msg);

    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text('Forget Password', style: AppTextStyle.textStyle3),
                ),
                sizedBoxh30,
                CustomTextField(hint: 'Email', controller: emailController),
                sizedBoxh30,
                const SizedBox(
                    child: Text(
                  'Enter the email address you used to create your account and we will email you a link to reset your password.',
                  style: AppTextStyle.textStyle1,
                  textAlign: TextAlign.center,
                )),
                sizedBoxh30,
                ElevatedButton(
                  onPressed: () {
                    forgetPassword(authController, emailController.text.trim()).then((value) {
                      if (value == '') {
                        Get.to(Login());
                      }
                    });
                  },
                  style: AppButtonStyle.buttonStyle1,
                  child: const Text(
                    'CONTINUE',
                    style: AppTextStyle.textStyle1,
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
                            text: "Don't have an account Register?",
                            style: AppTextStyle.textStyle2,
                          ),
                          TextSpan(
                            text: 'Sign Up',
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
          ],
        ),
      ),
    );
  }
}
