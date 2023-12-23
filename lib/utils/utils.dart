import 'package:d_fine_machine_test/Model/todo_model.dart';
import 'package:d_fine_machine_test/controller/Todo_Controller/todo_controller.dart';
import 'package:d_fine_machine_test/res/Colors/color.dart';
import 'package:d_fine_machine_test/res/Sizedbox/sizedboxes.dart';
import 'package:d_fine_machine_test/res/style/textstyle.dart';
import 'package:d_fine_machine_test/service/firebase_service.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
    );
  }

  static Future<int> pickData({required BuildContext context}) async {
    DateTime? pickdate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    return pickdate!.millisecondsSinceEpoch;
  }

  static dialogPopUpTodo({required BuildContext context, required TodoCategory todoCategory}) {
    final todoController = Get.put(TodoController());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          // scrollable: true,
          contentPadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Allow the dialog to wrap it's content
              children: [
                TextFormField(
                  controller: todoController.todoTextController.value,
                  style: AppTextStyle.textStyle6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // Allows the textfield to expand verically

                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type Your Task.....',
                    hintStyle: AppTextStyle.textStyle4,
                  ),
                ),
                sizedBoxh10,
                TextButton(
                    onPressed: () {
                      pickData(context: context).then((value) {
                        todoController.setTodoTimeStamp = value;
                      });
                    },
                    child: const Text('Pick a Date')),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Todo todo = Todo(title: todoController.todoTextController.value.text.trim(), isCompleted: false, timestamp: todoController.todoTimeStamp.value);

                          FirebaseServices().addTodo(uid: todoCategory.uid!, todo: todo).then((_) {
                            Utils.snackBar('New Todo Added', 'Todo Added to Your List');
                            Navigator.pop(context);
                          });
                        },
                        child: const Text('ok')),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static dialogPopUpCategory({required BuildContext context, required TextEditingController controller}) {
    final todoController = Get.put(TodoController());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          scrollable: true,
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: Get.height * 0.5,
                        child: EmojiPicker(
                          onEmojiSelected: (category, emoji) {
                            todoController.setNewEmoji = emoji.emoji;
                            Get.back();
                          },
                          onBackspacePressed: () {},
                          config: const Config(
                            columns: 7,
                            verticalSpacing: 0,
                            horizontalSpacing: 0,
                            initCategory: Category.SMILEYS,
                            bgColor: AppColors.whiteColor,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Obx(
                  () => Text(
                    todoController.emoji.value,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              TextFormField(
                controller: controller,
                style: AppTextStyle.textStyle6,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: AppTextStyle.textStyle4,
                ),
              ),
              Row(
                children: [
                  const Text(
                    '0 Task',
                    style: AppTextStyle.textStyle5,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.back();

                      TodoCategory todoCategory = TodoCategory(
                        title: controller.text.trim(),
                        emoji: todoController.emoji.value,
                      );

                      FirebaseServices()
                          .addCategory(
                        todoCategory,
                      )
                          .then((_) {
                        todoController.setNewEmoji = '📝';

                        Utils.snackBar('Category Added', 'Category Added successfully');
                      });
                    },
                    child: const Text('ok'),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
