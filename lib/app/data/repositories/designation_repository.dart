import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:ministerhub/app/data/models/designation.dart';
import 'package:resourcer/resourcer.dart';

import '../services/auth_service.dart';

class DesignationRepository extends Repository<Designation> {
  DesignationRepository() : super(path: "/designation");

  @override
  Future<Request> authenticator(Request request) async {
    return Get.find<AuthService>().authenticator(request);
  }

  @override
  Designation get empty => Designation();
}
