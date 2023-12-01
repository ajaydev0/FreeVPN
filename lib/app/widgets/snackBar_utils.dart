// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackMessage({
  required String title,
  required String message,
  Color? tcolor,
  required int seconds,
}) {
  // final istheme = Get.put(MainAppController());
  Get.snackbar(title, message,
      duration: Duration(seconds: seconds),
      // colorText: istheme.theme.value ? Kcolor.black : Kcolor.white,
      colorText: Colors.white);
}
