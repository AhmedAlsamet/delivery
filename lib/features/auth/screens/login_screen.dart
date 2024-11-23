import 'package:emarket_delivery_boy/helper/email_checker_helper.dart';
import 'package:emarket_delivery_boy/localization/language_constrants.dart';
import 'package:emarket_delivery_boy/features/auth/providers/auth_provider.dart';
import 'package:emarket_delivery_boy/features/splash/providers/splash_provider.dart';
import 'package:emarket_delivery_boy/utill/dimensions.dart';
import 'package:emarket_delivery_boy/utill/images.dart';
import 'package:emarket_delivery_boy/utill/styles.dart';
import 'package:emarket_delivery_boy/commons/widgets/custom_button_widget.dart';
import 'package:emarket_delivery_boy/helper/custom_snackbar_helper.dart';
import 'package:emarket_delivery_boy/commons/widgets/custom_text_field_widget.dart';
import 'package:emarket_delivery_boy/commons/widgets/custom_will_pop_widget.dart';
import 'package:emarket_delivery_boy/features/auth/screens/delivery_man_registration_screen.dart';
import 'package:emarket_delivery_boy/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKeyLogin;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController!.text = Provider.of<AuthProvider>(context, listen: false).getUserEmail();
    _passwordController!.text = Provider.of<AuthProvider>(context, listen: false).getUserPassword();
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SplashProvider splashProvider = Provider.of<SplashProvider>(context, listen: false);

    return CustomWillPopWidget(child: Scaffold(body: Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => Form(
          key: _formKeyLogin,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  Images.guestLogin,
                  height: MediaQuery.of(context).size.height / 4.5,
                  fit: BoxFit.scaleDown,
                  matchTextDirection: true,
                ),
              ),
              //SizedBox(height: 20),
              Center(
                  child: Text(
                    getTranslated('login', context)!,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 24, color: Theme.of(context).hintColor),
                  )),
              const SizedBox(height: 35),
              Text(
                getTranslated('email_address', context)!,
                style: Theme.of(context).textTheme.displayMedium!,
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              CustomTextFieldWidget(
                hintText: getTranslated('demo_gmail', context),
                isShowBorder: true,
                focusNode: _emailFocus,
                nextFocus: _passwordFocus,
                controller: _emailController,
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              Text(
                getTranslated('password', context)!,
                style: Theme.of(context).textTheme.displayMedium!,
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              CustomTextFieldWidget(
                hintText: getTranslated('password_hint', context),
                isShowBorder: true,
                isPassword: true,
                isShowSuffixIcon: true,
                focusNode: _passwordFocus,
                controller: _passwordController,
                inputAction: TextInputAction.done,
              ),
              const SizedBox(height: 22),

              // for remember me section
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Consumer<AuthProvider>(
                      builder: (context, authProvider, child) => InkWell(
                        onTap: () {
                          authProvider.toggleRememberMe();
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                  color: authProvider.isActiveRememberMe ? Theme.of(context).primaryColor : Colors.white,
                                  border:
                                  Border.all(color: authProvider.isActiveRememberMe ? Colors.transparent : Theme.of(context).highlightColor),
                                  borderRadius: BorderRadius.circular(3)),
                              child: authProvider.isActiveRememberMe
                                  ? const Icon(Icons.done, color: Colors.white, size: 17)
                                  : const SizedBox.shrink(),
                            ),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                            Text(
                              getTranslated('remember_me', context)!,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontSize: Dimensions.fontSizeExtraSmall),
                            )
                          ],
                        ),
                      )),
                ],
              ),

              const SizedBox(height: 22),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  authProvider.loginErrorMessage!.isNotEmpty
                      ? const CircleAvatar(backgroundColor: Colors.red, radius: 5)
                      : const SizedBox.shrink(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      authProvider.loginErrorMessage ?? "",
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),

              CustomButtonWidget(
                isLoading: authProvider.isLoading,
                btnTxt: getTranslated('login', context),
                onTap: () async {

                  String email = _emailController!.text.trim();
                  String password = _passwordController!.text.trim();
                  if (email.isEmpty) {
                    showCustomSnackBar(getTranslated('enter_email_address', context)!);
                  }else if (EmailCheckerHelper.isNotValid(email)) {
                    showCustomSnackBar(getTranslated('enter_valid_email', context)!);
                  }else if (password.isEmpty) {
                    showCustomSnackBar(getTranslated('enter_password', context)!);
                  }else if (password.length < 8) {
                    showCustomSnackBar(getTranslated('password_should_be', context)!);
                  }else {
                    authProvider.login(emailAddress: email, password: password).then((status) async {
                      if (status.isSuccess) {
                        if (authProvider.isActiveRememberMe) {
                          authProvider.saveUserNumberAndPassword(email, password);
                        } else {
                          authProvider.clearUserEmailAndPassword();
                        }
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const DashboardScreen()));
                      }
                    });
                  }
                },
              ),

              const SizedBox(height: 10),

              splashProvider.configModel!.toggleDmRegistration! ? TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(1, 40),
                ),
                onPressed: () async => await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DeliveryManRegistrationScreen()),
                ),
                child: RichText(text: TextSpan(children: [
                  TextSpan(text: '${getTranslated('join_as_a', context)} ', style: rubikRegular.copyWith(color: Theme.of(context).disabledColor)),
                  TextSpan(text:getTranslated('delivery_man', context), style: rubikMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color)),
                ])),
              ) : const SizedBox(),
            ],
          ),
        ),
      ),
    )));

  }
}
