import 'package:get/get.dart';
import 'package:ministerhub/app/data/repositories/designation_repository.dart';
import 'package:ministerhub/app/data/repositories/user_repository.dart';

import '../controllers/users_controller.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersController>(() => UsersController());
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.create<DesignationRepository>(() => DesignationRepository());
  }
}
