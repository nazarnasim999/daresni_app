import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

final dropdownSearchDecoration = InputDecoration(
  isDense: true,
  filled: true,
  fillColor: const Color(0xffF4F4F4),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
  enabledBorder:
      OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none),
);

void showProgress() {
  Get.generalDialog(
    pageBuilder:
        (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return Container(
        color: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: AppTheme.primaryColor,
          ),
        ),
      );
    },
  );
}

void stopProgress() {
  if (Get.isDialogOpen!) {
    Get.back();
  }
}

class AppAlerts {
  static void showSnack(String message, {bool error = false}) {
    Get.snackbar(
      "",
      "",
      messageText: Text(
        message,
        style: AppTStyle.primaryStyle12.copyWith(color: Colors.white),
      ),
      margin: EdgeInsets.zero,
      backgroundColor: error ? AppTheme.primaryColor : AppTheme.secondaryColor,
      borderRadius: 0,
    );
  }
}
