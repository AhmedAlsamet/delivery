import 'package:emarket_delivery_boy/commons/providers/localization_provider.dart';
import 'package:emarket_delivery_boy/commons/widgets/custom_button_widget.dart';
import 'package:emarket_delivery_boy/commons/widgets/custom_will_pop_widget.dart';
import 'package:emarket_delivery_boy/features/auth/screens/login_screen.dart';
import 'package:emarket_delivery_boy/features/language/providers/language_provider.dart';
import 'package:emarket_delivery_boy/features/language/widgets/language_item_widget.dart';
import 'package:emarket_delivery_boy/features/language/widgets/search_widget.dart';
import 'package:emarket_delivery_boy/helper/custom_snackbar_helper.dart';
import 'package:emarket_delivery_boy/localization/language_constrants.dart';
import 'package:emarket_delivery_boy/utill/app_constants.dart';
import 'package:emarket_delivery_boy/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseLanguageScreen extends StatelessWidget {
  final bool fromHomeScreen;

  const ChooseLanguageScreen({Key? key, this.fromHomeScreen = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageProvider>(context, listen: false).initializeAllLanguages(context);

    return CustomWillPopWidget(child: Scaffold(body: SafeArea(
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall),
                child: Text(
                  getTranslated('choose_the_language', context)!,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 22),
                ),
              ),
              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall),
                child: SearchWidget(),
              ),
              const SizedBox(height: 20),

              Expanded(child: ListView.builder(
                itemCount: languageProvider.languages.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => LanguageItemWidget(
                  languageModel: languageProvider.languages[index],
                  index: index,
                ),
              )),

              Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.paddingSizeLarge,
                  right: Dimensions.paddingSizeLarge,
                  bottom: Dimensions.paddingSizeLarge,
                ),
                child: CustomButtonWidget(
                  btnTxt: getTranslated('save', context),
                  onTap: () {
                    if(languageProvider.languages.isNotEmpty && languageProvider.selectIndex != -1) {
                      Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
                        AppConstants.languages[languageProvider.selectIndex!].languageCode!,
                        AppConstants.languages[languageProvider.selectIndex!].countryCode,
                      ));
                      if (fromHomeScreen) {
                        Navigator.pop(context);
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
                      }
                    }else {
                      showCustomSnackBar(getTranslated('select_a_language', context)!);
                    }
                  },
                ),
              ),
            ],
          );
        }
      ),
    )));
  }


}

