import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ministerhub/app/data/repositories/user_repository.dart';
import 'package:ministerhub/app/data/services/auth_service.dart';
import 'package:ministerhub/app/data/widgets/global_widgets/erp_settings_scaffold.dart';
import 'package:ministerhub/app/routes/app_pages.dart';
import 'package:resourcer/resourcer.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetResponsiveView<UsersController> {
  UsersView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpSettingsScaffold(
      screen: screen,
      path: Routes.USERS,
      body: ResourceListView(
        repository: Get.find<UserRepository>(),
        title: "Users",
        description: "Add, edit, delete and update users of your company.",
        tileBuilder: (controller, data) {
          return Container(
            width: Get.width,
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80"),
                    ),
                    color: Colors.green.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 18),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name ?? "",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    // Text(
                    //   "subtitle",
                    //   style: GoogleFonts.poppins(
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w400,
                    //     color: Colors.grey.shade700,
                    //   ),
                    // ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      controller.updateTile(data);
                    },
                    child: Icon(Icons.edit, color: Colors.green.shade700),
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: GestureDetector(
                      onTap: () {
                        controller.destroyTile(data);
                      },
                      child: Icon(Icons.delete, color: Colors.red.shade700),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
