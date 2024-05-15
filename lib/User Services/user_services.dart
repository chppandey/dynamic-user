import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:random_user/feature/userlist/model/user_list_model.dart';

class UserServices {
  final Dio dio = Dio();
  Future<UserdataModel> getUserServices() async {
    Response response;
    try {
      dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      response = await dio.get(
        "https://randomuser.me/api",
      );
      log("sta--. ${response.data}");
      if (response.statusCode == 200) {
        return UserdataModel.fromJson(response.data);
      } else {
        throw Exception("Faild to load data");
      }
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.unknown) {
          throw Exception("No Internet connection or network error");
        } else if (e.type == DioExceptionType.badResponse) {
          throw Exception("Faild to load data");
        }
      }
      throw Exception("Faild to make api the request : $e");
    }
  }
}
