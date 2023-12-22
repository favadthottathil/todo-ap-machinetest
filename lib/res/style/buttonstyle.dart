import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppButtonStyle {
  static final buttonStyle1 = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue[900],
    fixedSize: Size(Get.width, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );
}
