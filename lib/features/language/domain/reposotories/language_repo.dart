import 'package:flutter/material.dart';
import 'package:emarket_delivery_boy/features/language/domain/models/language_model.dart';
import 'package:emarket_delivery_boy/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}
