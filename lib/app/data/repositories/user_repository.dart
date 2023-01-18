import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:ministerhub/app/data/models/user.dart';
import 'package:ministerhub/app/data/services/auth_service.dart';
import 'package:ministerhub/app/data/utils/keys.dart';
import 'package:resourcer/data/abstracts/repository.dart';

class UserRepository extends Repository<User> {
  UserRepository() : super(path: "/auth");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  Future<void> login(String username, String password) async {
    Response response = await post(
      "secure/signin",
      {"username": username, "password": password},
    );
    var data = response.body[dataKey];
    var user = data[userKey];
    var branch = user[employeeKey][branchKey];
    var token = data[tokenKey];

    await Get.find<AuthService>().saveToken(token);
    await Get.find<AuthService>().saveData(userKey, user);
    await Get.find<AuthService>().saveData(branchKey, branch);
  }

  Future<void> updatePassword(String password, String newPassword) async {
    Response response = await put(
      "/password",
      jsonEncode({"password": password, "newPassword": newPassword}),
    );
    var data = response.body[dataKey];
    var user = data[userKey];
    var token = data[tokenKey];
    await Get.find<AuthService>().saveToken(token);
    await Get.find<AuthService>().saveData(userKey, user);
  }

  @override
  User get empty => User();
}
