import 'package:flutter/material.dart';
import 'package:ministerhub/app/data/widgets/global_widgets/erp_settings_scaffold.dart';
import 'package:ministerhub/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetResponsiveView<SettingsController> {
  SettingsView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpSettingsScaffold(
      path: Routes.SETTINGS,
      screen: screen,
      body: Container(),
    );
  }
}
