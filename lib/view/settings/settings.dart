import 'package:d_fine_machine_test/res/style/textstyle.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: AppTextStyle.textStyle1),
      ),
      body: Column(
        children: [

          ListTile(

            leading: CircleAvatar(radius: 40),

            title: Text('Malak Idrissi',style: AppTextStyle.textStyle3),

            subtitle: Text('Rabat,'),

          )



        ],
      ),
    );
  }
}
