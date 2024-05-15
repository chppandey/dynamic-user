import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/state_manager.dart';
import 'package:random_user/User%20Services/user_services.dart';
import 'package:random_user/core/utils/local_db.dart';
import 'package:random_user/feature/userlist/model/insert_model.dart';
import 'package:random_user/feature/userlist/model/user_list_model.dart';

class UserController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<InserModel> insertModel = <InserModel>[].obs;
  DatabaseHelper databaseHelper = DatabaseHelper();
  RxList<Map<String, dynamic>> parsedData = <Map<String, dynamic>>[].obs;

  final UserServices userServices = UserServices();
  Future<void> getRandomUser() async {
    isLoading(true);
    UserdataModel results = await userServices.getUserServices();
    if (results.results != null || results.results!.isNotEmpty) {
      log("list--> ${results.results?[0].name}");
      insertModel.clear();
      results.results?.forEach((element) {
        insertModel.add(InserModel(
            firstName: element.name?.first ?? "",
            lastName: element.name?.last,
            age: element.dob?.age));
      });
      await databaseHelper.insertIntoTable(insertModel.toJson());

      await getData("");
      log("fetch data--> ${parsedData.value}");
    }

    log("dfkajsdkfja $results");
    isLoading(false);
  }

  /// get data from local db
  /// read data from table
  Future<void> getData(String query) async {
    isLoading(true);
    parsedData.value = [];
    parsedData.value = await databaseHelper.getData(query) ?? [];
    if (kDebugMode) {
      print("lidatData--> ${parsedData.toString()}");
    }
    parsedData.refresh();
    isLoading(false);
  }
}
