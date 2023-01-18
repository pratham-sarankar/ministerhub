import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:ministerhub/app/data/utils/keys.dart';
import 'package:resourcer/data/data.dart';

class FileProvider extends GetConnect {
  Future<String> uploadFile(Uint8List data) async {
    Response response = await post(
      "$host/file",
      FormData(
        {
          'file': MultipartFile(
            data,
            filename: DateTime.now().toIso8601String(),
          ),
        },
      ),
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiException(
        status: response.statusCode ?? HttpStatus.internalServerError,
        message: response.body[messageKey],
      );
    }
    return response.body[dataKey];
  }
}
