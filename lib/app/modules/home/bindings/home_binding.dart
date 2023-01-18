import 'package:get/get.dart';
import 'package:ministerhub/app/data/repositories/user_repository.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<UserRepository>(() => UserRepository());
  }
}
