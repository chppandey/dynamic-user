import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_user/feature/userlist/controller/user_controller.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userController.getRandomUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("user list"),
        actions: [
          IconButton(
              onPressed: () async {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  userController.getRandomUser();
                });
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Obx(() => userController.isLoading.value
          ? const Center(child: CircularProgressIndicator.adaptive())
          : ListView.builder(
              itemCount: userController.parsedData.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                    "Name : ${userController.parsedData[index]['first']} ${userController.parsedData[index]['last']}"),
                subtitle:
                    Text("Age : ${userController.parsedData[index]['age']}"),
              ),
            )),
    );
  }
}
