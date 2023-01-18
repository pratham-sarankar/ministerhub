import 'package:flutter/cupertino.dart';
import 'package:ministerhub/app/data/services/auth_service.dart';
import 'package:ministerhub/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    return authService.isLoggedIn
        ? null
        : const RouteSettings(name: Routes.LOGIN);
  }
}
