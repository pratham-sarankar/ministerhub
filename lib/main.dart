import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerhub/app/data/repositories/user_repository.dart';
import 'package:ministerhub/app/data/services/auth_service.dart';
import 'package:ministerhub/app/data/services/file_service.dart';
import 'package:ministerhub/app/data/services/toast_service.dart';
import 'package:ministerhub/app/data/utils/themes.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  Get.lazyPut<UserRepository>(() => UserRepository());

  await Get.putAsync(() => ToastService().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => FileService().init());

  await Get.find<AuthService>().reloadUser();
  doWhenWindowReady(() {
    const initialSize = Size(600, 450);
    appWindow.maximize();
    appWindow.minSize = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
  runApp(
    DevicePreview(
      enabled: false,
      tools: DevicePreview.defaultTools,
      builder: (context) {
        return GetMaterialApp(
          title: "Minister Hub",
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          defaultTransition: Transition.noTransition,
        );
      },
    ),
  );
}
