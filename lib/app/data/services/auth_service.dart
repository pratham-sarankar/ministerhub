import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ministerhub/app/data/models/user.dart';
import 'package:ministerhub/app/data/repositories/user_repository.dart';
import 'package:ministerhub/app/data/utils/keys.dart';
import 'package:ministerhub/app/data/widgets/global_widgets/sidebar.dart';
import 'package:ministerhub/app/routes/app_pages.dart';
import 'package:resourcer/widgets/plus_widgets/plus_navigation_rail.dart';

class AuthService extends GetxService {
  late final GetStorage _box;

  Future<AuthService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  Future<void> saveData(String key, Map<String, dynamic> data) async {
    return await _box.write(key, data);
  }

  Future<void> reloadUser() async {
    if (isLoggedIn) {
      var user = await Get.find<UserRepository>().fetchOne(currentUser.id!);
      await saveData(userKey, user.toMap());
    }
  }

  Map<String, dynamic>? readData(String key) {
    return _box.read(key);
  }

  bool get isLoggedIn => _box.read(tokenKey) != null;

  Future<void> saveToken(String token) async {
    return await _box.write(tokenKey, token);
  }

  Future<void> logout() async {
    await _box.erase();
    return;
  }

  String? readToken() {
    return _box.read<String?>(tokenKey);
  }

  Request authenticator(Request request) {
    String? token = readToken();
    if (token != null) {
      request.headers['Authorization'] = "Bearer $token";
    }
    return request;
  }

  User get currentUser {
    var data = readData(userKey);
    return User().fromMap(data!);
  }

  List<SideBarGroup> getSideBarGroups() {
    return [
      SideBarGroup(
        title: "ANALYTICS",
        sideBarDestinations: [
          SideBarDestination(
            title: "Dashboard",
            icon: IconlyLight.home,
            boldIcon: IconlyBold.home,
            path: Routes.HOME,
          ),
          // if (canView("Branches"))
          //   SideBarDestination(
          //     title: "Branches",
          //     icon: IconlyLight.chart,
          //     boldIcon: IconlyBold.chart,
          //     path: Routes.BRANCHES,
          //   ),
          // if (canView("Payments"))
          //   SideBarDestination(
          //     title: "Payments",
          //     icon: IconlyLight.calendar,
          //     boldIcon: IconlyBold.calendar,
          //     path: Routes.PAYMENT,
          //   ),
        ],
      ),
      SideBarGroup(
        title: "MAIN MENU",
        sideBarDestinations: [
          // if (canView("Employees"))
          //   SideBarDestination(
          //     title: "Employees",
          //     icon: IconlyLight.user2,
          //     boldIcon: IconlyBold.user2,
          //     path: Routes.EMPLOYEES,
          //   ),
          // if (canView("Customers"))
          //   SideBarDestination(
          //     title: "Customers",
          //     icon: IconlyLight.user3,
          //     boldIcon: IconlyBold.user3,
          //     path: Routes.CUSTOMERS,
          //   ),
          // if (canView("Classes"))
          //   SideBarDestination(
          //     title: "Classes",
          //     icon: IconlyLight.calendar,
          //     boldIcon: IconlyBold.calendar,
          //     path: Routes.CLASS,
          //   ),
          // if (canView("Courses"))
          //   SideBarDestination(
          //     title: "Courses",
          //     icon: IconlyLight.document,
          //     boldIcon: IconlyBold.document,
          //     path: Routes.COURSES,
          //   ),
        ],
      ),
      SideBarGroup(
        title: "OTHERS",
        sideBarDestinations: [
          SideBarDestination(
            title: "Settings",
            icon: IconlyLight.setting,
            boldIcon: IconlyBold.setting,
            path: Routes.SETTINGS,
          ),
        ],
      ),
    ];
  }

  List<PlusNavigationRailItem> getSettingsTabs() {
    return [
      PlusNavigationRailItem(
        label: 'My Profile',
        path: Routes.PROFILE,
      ),
      // if (canView("Users"))
      //   PlusNavigationRailItem(
      //     label: 'Users',
      //     path: Routes.USERS,
      //   ),
      // if (canView("Permission Groups"))
      //   PlusNavigationRailItem(
      //     label: 'Permission Groups',
      //     path: Routes.PERMISSION_GROUPS,
      //   ),
      // if (canView("Designations"))
      //   PlusNavigationRailItem(
      //     label: 'Designations',
      //     path: Routes.DESIGNATIONS,
      //   ),
    ];
  }
}
