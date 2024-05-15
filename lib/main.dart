import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_user/feature/userlist/controller/user_controller.dart';
import 'package:random_user/feature/userlist/presentation/user_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserListScreen(),
    );
  }
}
