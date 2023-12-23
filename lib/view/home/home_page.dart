import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_fine_machine_test/Model/todo_model.dart';
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
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.blackColor,
                            ),
                            const Text('Categories', style: AppTextStyle.textStyle3),
                            IconButton(
                              onPressed: () {
                                logOut(authController).then((value) {
                                  if (value == '') Get.to(const Login());
                                });
                              },
                              icon: const Icon(Icons.logout),
                            )
                          ],
                        ),
                        sizedBoxh30,
                        Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              leading: Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amber,
                                  image: DecorationImage(image: AssetImage('Asset/tamim.jpeg'), fit: BoxFit.cover),
                                ),
                              ),
                              title: const Text('"The memories is a shield and life helper."'),
                              subtitle: const Text('Tamim Al-Barghouti'),
                            ),
                          ),
                        ),
                        sizedBoxh30,
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('todo-categories').snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<TodoCategory> category = snapshot.data!.docs.map((item) => TodoCategory.fromJosn(item.data() as Map<String, dynamic>)).toList();

                              return GridView.builder(
                                itemCount: category.length + 1,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(10.0),
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  mainAxisExtent: 150,
                                ),
                                itemBuilder: (context, index) {
                                  bool isAddButton = false;

                                  TodoCategory todoCategory = TodoCategory(title: '', emoji: '');

                                  if (index == 0) {
                                    isAddButton = true;
                                  } else {
                                    isAddButton = false;
                                    todoCategory = category[index - 1];
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
                                                  Utils.dialogPopUpCategory(context: context, controller: titleController);
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
                                                  Get.to(AllTask(todoCategory: todoCategory));
                                                },
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(todoCategory.emoji, style: const TextStyle(fontSize: 25)),
                                                    sizedBoxh10,
                                                    Text(todoCategory.title, style: AppTextStyle.textStyle1),
                                                    sizedBoxh10,
                                                    const Text(
                                                      '0 Tasks',
                                                      style: AppTextStyle.textStyle1,
                                                    ),
                                                    const Row(
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
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.blackColor,
                                ),
                              );
                            }
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
