import 'package:d_fine_machine_test/res/Sizedbox/sizedboxes.dart';
import 'package:d_fine_machine_test/res/style/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
    );
  }

  static dialogPopUp({required BuildContext context, required TextEditingController controller}) {
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
              sizedBoxh30,
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
              const Text(
                '0 Task',
                style: AppTextStyle.textStyle5,
              )
            ],
          ),
        );
      },
    );
  }
}
