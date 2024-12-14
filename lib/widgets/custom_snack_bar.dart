import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/theme.dart';

void showCustomSnackBar({
  required String title,
  required String message,
  bool isError = false,
}) {
  Get.closeCurrentSnackbar();
  Get.showSnackbar(
    GetSnackBar(
      title: title,
      message: message,
      icon: Icon(
        isError ? Icons.error : Icons.check_circle,
        color: AppTheme.white,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: isError ? AppTheme.textRed : AppTheme.green,
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      snackPosition: SnackPosition.BOTTOM,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInCubic,
      isDismissible: true,
      shouldIconPulse: false,
    ),
  );
}
