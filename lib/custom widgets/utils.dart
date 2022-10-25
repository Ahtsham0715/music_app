import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future filepicker({required filetype, allowedextensions}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: filetype,
    allowedExtensions: allowedextensions,
  );
  if (result != null) {
    return result.files.single;
  } else {
    return '';
  }
}

void styledsnackbar({required txt, icon = Icons.wifi_sharp}) {
  Get.rawSnackbar(
    margin: const EdgeInsets.all(15.0),
    maxWidth: Get.width * 0.3,
    messageText: Text(
      txt,
      style: const TextStyle(
          color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w400),
    ),
    isDismissible: false,
    backgroundColor: Colors.teal.shade200,
    borderRadius: 30.0,
    //  borderWidth: 15.0,
    icon: Icon(
      icon,
      color: Colors.black,
      size: 25.0,
    ),
    duration: const Duration(seconds: 3),
  );
}
