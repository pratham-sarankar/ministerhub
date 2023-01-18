import 'package:ministerhub/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<UserRepository>(() => UserRepository());
  }
}
