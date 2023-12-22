import 'package:d_fine_machine_test/controller/auth_controller/auth_controller.dart';
import 'package:d_fine_machine_test/res/Colors/color.dart';
import 'package:d_fine_machine_test/res/Sizedbox/sizedboxes.dart';
import 'package:d_fine_machine_test/res/style/textstyle.dart';
import 'package:d_fine_machine_test/utils/utils.dart';
import 'package:d_fine_machine_test/view/Todo/all_tasks.dart';
import 'package:d_fine_machine_test/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final authController = Get.put(AuthController());

  final titleController = TextEditingController();

  Future<String> logOut(
    AuthController authController,
  ) async {
    final msg = await authController.logOut();

    if (msg == '') {
      authController.setLoading = false;

      return '';
    }

    Utils.snackBar('Sign Out failed', msg);

    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => authController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.blackColor),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CircleAvatar(radius: 20),
                            const Text('Categories', style: AppTextStyle.textStyle3),
                            IconButton(
                              onPressed: () {
                                logOut(authController).then((value) {
                                  if (value == '') Get.to(const Login());
                                });
                              },
                              icon: const Icon(Icons.search),
                            )
                          ],
                        ),
                        sizedBoxh30,
                        const Card(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 40,
                              ),
                              title: Text('"The memories is a shield and life helper."'),
                              subtitle: Text('Tamim Al-Barghouti'),
                            ),
                          ),
                        ),
                        sizedBoxh30,
                        GridView.builder(
                          itemCount: 8,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10.0),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            mainAxisExtent: 120,
                          ),
                          itemBuilder: (context, index) {
                            bool isAddButton = false;

                            if (index == 0) {
                              isAddButton = true;
                            } else {
                              isAddButton = false;
                            }

                            return Material(
                              elevation: 10,
                              shadowColor: AppColors.greyColor,
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: isAddButton
                                    ? Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: IconButton(
                                          onPressed: () {
                                            Utils.dialogPopUp(context: context, controller: titleController);
                                          },
                                          icon: const Icon(
                                            Icons.add_circle,
                                            color: AppColors.blackColor,
                                            size: 70,
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(AllTask());
                                          },
                                          child: const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Home', style: AppTextStyle.textStyle1),
                                              sizedBoxh10,
                                              Text(
                                                '10 Tasks',
                                                style: AppTextStyle.textStyle1,
                                              ),
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  Icon(Icons.more_vert, color: AppColors.greyColor)
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                        sizedBoxh10,
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
