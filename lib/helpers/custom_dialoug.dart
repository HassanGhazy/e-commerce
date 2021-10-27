import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shop/helpers/app_router.dart';

class CustomDialoug {
  CustomDialoug._();
  static CustomDialoug customDialoug = CustomDialoug._();
  AwesomeDialog showCustomDialoug(String message, DialogType dialogType,
      [Function? function]) {
    return AwesomeDialog(
      context: AppRouter.route.navKey.currentContext!,
      body: Text(message),
      animType: AnimType.SCALE,
      dialogType: dialogType,
      btnOkOnPress: () {
        if (function != null) {
          function();
        }
      },
    )..show();
  }
}
