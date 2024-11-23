// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:emarket_delivery_boy/localization/language_constrants.dart';
import 'package:emarket_delivery_boy/helper/custom_snackbar_helper.dart';
import 'package:flutter/material.dart';

class CustomWillPopWidget extends StatefulWidget {
  final Widget child;
  const CustomWillPopWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<CustomWillPopWidget> createState() => _CustomWillPopWidgetState();
}

class _CustomWillPopWidgetState extends State<CustomWillPopWidget> {
  bool canExit = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(Navigator.canPop(context)){
          return true;
        }else{
          if(canExit) {
            return true;
          }else {
            showCustomSnackBar(getTranslated('back_press_again_to_exit', context)!, isError: false);
            canExit = true;
            Timer(const Duration(seconds: 2), () {
              canExit = false;
            });
            return false;
          }
        }
      },
      child: widget.child,
    );
  }
}
