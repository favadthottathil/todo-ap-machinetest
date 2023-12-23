import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  var isEmojiVisible = false.obs;

  var emoji = '📝'.obs;

  var todoTimeStamp = DateTime.now().millisecondsSinceEpoch.obs;

  final todoTextController = TextEditingController().obs;

  set setTodoTimeStamp(int value) {
    todoTimeStamp.value = value;
  }

  set setNewEmoji(String value) {
    emoji.value = value;
  }
}
