import 'package:emarket_delivery_boy/main.dart';
import 'package:flutter/material.dart';

void showCustomSnackBar(String message, {bool isError = true}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    content: Text(message),
    duration: const Duration(seconds: 2),
  ));
}