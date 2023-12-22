import 'package:d_fine_machine_test/res/Colors/color.dart';
import 'package:d_fine_machine_test/res/style/textstyle.dart';
import 'package:flutter/material.dart';

class AllTask extends StatefulWidget {
  const AllTask({super.key});

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.blackColor,
        child: const Icon(Icons.add, color: AppColors.whiteColor),
      ),
    );
  }
}