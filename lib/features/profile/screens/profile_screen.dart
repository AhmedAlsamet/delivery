import 'package:emarket_delivery_boy/features/profile/widgets/user_info_widget.dart';
import 'package:emarket_delivery_boy/localization/language_constrants.dart';
import 'package:emarket_delivery_boy/features/auth/providers/auth_provider.dart';
import 'package:emarket_delivery_boy/features/profile/providers/profile_provider.dart';
import 'package:emarket_delivery_boy/features/splash/providers/splash_provider.dart';
import 'package:emarket_delivery_boy/utill/dimensions.dart';
import 'package:emarket_delivery_boy/utill/styles.dart';
import 'package:emarket_delivery_boy/commons/widgets/custom_image_widget.dart';
import 'package:emarket_delivery_boy/features/profile/widgets/theme_status_widget.dart';
import 'package:emarket_delivery_boy/features/html/screens/html_viewer_screen.dart';
import 'package:emarket_delivery_boy/features/profile/widgets/acount_delete_dialog_widget.dart';
import 'package:emarket_delivery_boy/features/profile/widgets/profile_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/sign_out_confirmation_dialog_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
        body: Consumer<ProfileProvider>(builder: (context, profileProvider, child) =>
        profileProvider.userInfoModel == null ? const Center(child: CircularProgressIndicator()) :
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  color: Theme.of(context).primaryColor,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        getTranslated('my_profile', context)!,
                        style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.white),
                      ),
                      const SizedBox(height: 30),

                      Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: CustomImageWidget(
                              image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.deliveryManImageUrl}/${profileProvider.userInfoModel!.image}',
                              height: 80, width: 80,
                              )),
                      ),
                      const SizedBox(height: 20),

                      Text(
                        profileProvider.userInfoModel!.fName != null
                            ? '${profileProvider.userInfoModel!.fName ?? ''} ${profileProvider.userInfoModel!.lName ?? ''}'
                            : "",
                        style: rubikRegular.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                Container(
                  color: Theme.of(context).canvasColor,
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated('theme_style', context)!,
                            style: rubikRegular.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                            ),
                          ),
                          const ThemeStatusWidget()
                        ],
                      ),
                      const SizedBox(height: 20),

                      UserInfoWidget(text: profileProvider.userInfoModel!.fName),
                      const SizedBox(height: 15),

                      UserInfoWidget(text: profileProvider.userInfoModel!.lName),
                      const SizedBox(height: 15),

                      UserInfoWidget(text: profileProvider.userInfoModel!.phone),
                      const SizedBox(height: 20),

                      ProfileButtonWidget(icon: Icons.privacy_tip, title: getTranslated('privacy_policy', context), onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HtmlViewerScreen(isPrivacyPolicy: true)));
                      }),
                      const SizedBox(height: 10),

                      ProfileButtonWidget(icon: Icons.list, title: getTranslated('terms_and_condition', context), onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HtmlViewerScreen(isPrivacyPolicy: false)));
                      }),
                      const SizedBox(height: 10),

                      ProfileButtonWidget(icon: Icons.delete, title: getTranslated('delete_account', context), onTap: () {
                        showDialog(context: context, builder: (context)=> AccountDeleteDialogWidget(
                          icon: Icons.question_mark_sharp,
                          title: getTranslated('are_you_sure_to_delete_account', context),
                          description: getTranslated('it_will_remove_your_all_information', context),
                          onTapFalseText:getTranslated('no', context),
                          onTapTrueText: getTranslated('yes', context),
                          isFailed: true,
                          onTapFalse: () => Navigator.of(context).pop(),
                          onTapTrue: () async => await authProvider.deleteUser(),
                        ));

                      }),




                      ProfileButtonWidget(icon: Icons.logout, title: getTranslated('logout', context), onTap: () {
                        showDialog(context: context, barrierDismissible: false, builder: (context) => const SignOutConfirmationDialogWidget());
                      }),


                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}


