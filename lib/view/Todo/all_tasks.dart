// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_fine_machine_test/Model/todo_model.dart';
import 'package:d_fine_machine_test/res/Colors/color.dart';
import 'package:d_fine_machine_test/res/Sizedbox/sizedboxes.dart';
import 'package:d_fine_machine_test/res/style/textstyle.dart';
import 'package:d_fine_machine_test/service/firebase_service.dart';
import 'package:d_fine_machine_test/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class AllTask extends StatefulWidget {
  const AllTask({super.key, required this.todoCategory});

  final TodoCategory todoCategory;

  @override
  State<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends State<AllTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sport', style: AppTextStyle.textStyle3),
        centerTitle: true,
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseServices().getTodoList(
              todoCategory: widget.todoCategory,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Todo> todoList = snapshot.data!.docs.map((item) => Todo.fromJson(item.data() as Map<String, dynamic>)).toList();

                // Sort data As time created
                todoList.sort(
                  (a, b) {
                    DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
                    DateTime dateA = DateTime.fromMillisecondsSinceEpoch(a.timestamp);
                    DateTime dateB = DateTime.fromMillisecondsSinceEpoch(b.timestamp);

                    DateTime dateOnlyA = DateTime(dateA.year, dateA.month, dateA.day);
                    DateTime dateOnlyB = DateTime(dateB.year, dateB.month, dateB.day);

                    Duration diffA = dateOnlyA.difference(today);
                    Duration diffB = dateOnlyB.difference(today);

                    return diffA.compareTo(diffB);
                  },
                );

                // Now, create a new map to group todos by date
                Map<String, List<Todo>> todosByDate = {};

                for (Todo todo in todoList) {
                  DateTime today = DateTime.now();
                  DateTime tomorrow = today.add(const Duration(days: 1));

                  String formatedDate = '';

                  // Convert milliseconds since epoch to DateTime
                  DateTime todoDate = DateTime.fromMillisecondsSinceEpoch(todo.timestamp);

                  if (todoDate.year == today.year && todoDate.month == today.month && todoDate.day == today.day) {
                    formatedDate = 'Today';
                  } else if (todoDate.year == tomorrow.year && todoDate.month == tomorrow.month && todoDate.day == tomorrow.day) {
                    formatedDate = 'Tomorrow';
                  } else {
                    formatedDate = DateFormat('E, MMM d, y').format(todoDate);
                  }

                  if (!todosByDate.containsKey(formatedDate)) {
                    todosByDate[formatedDate] = [];
                  }
                  todosByDate[formatedDate]!.add(todo);
                }

                // Delete the data before the current date

                todosByDate.removeWhere((dateKey, todosForDate) {
                  if (dateKey == 'Today' || dateKey == 'Tomorrow') {
                    return false; // Keep 'Today' and 'Tomorrow' entries
                  } else {
                    DateTime parsedDate = DateFormat('E, MMM d, y').parse(dateKey);
                    return parsedDate.isBefore(DateTime.now()); // Remove entries with dates before today
                  }
                });

                return Column(
                    children: todosByDate.entries
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(e.key, style: AppTextStyle.textStyle7),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: e.value.length,
                                  itemBuilder: (context, index) {
                                    Todo todo = e.value[index];

                                    return ListTile(
                                      leading: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: RoundCheckBox(
                                          onTap: (selected) {
                                            Todo todoModel = Todo(title: todo.title, isCompleted: selected!, timestamp: todo.timestamp, uid: todo.uid);

                                            FirebaseServices().updateTodo(todo: todoModel, uid: widget.todoCategory.uid!);
                                          },
                                          uncheckedColor: AppColors.whiteColor,
                                          isChecked: todo.isCompleted,
                                          uncheckedWidget: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          animationDuration: const Duration(
                                            milliseconds: 50,
                                          ),
                                        ),
                                      ),
                                      title: Text(todo.title, style: AppTextStyle.textStyle8),
                                    );
                                  },
                                ),
                                sizedBoxh10,
                                sizedBoxh10,
                              ],
                            ),
                          ),
                        )
                        .toList());
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.dialogPopUpTodo(
            context: context,
            todoCategory: widget.todoCategory,
          );
        },
        backgroundColor: AppColors.blackColor,
        child: const Icon(Icons.add, color: AppColors.whiteColor),
      ),
    );
  }
}
