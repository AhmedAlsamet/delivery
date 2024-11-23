import 'package:flutter/material.dart';
import 'package:emarket_delivery_boy/localization/language_constrants.dart';
import 'package:emarket_delivery_boy/utill/dimensions.dart';
import 'package:emarket_delivery_boy/utill/images.dart';
import 'package:emarket_delivery_boy/commons/widgets/custom_button_widget.dart';
import 'package:emarket_delivery_boy/features/dashboard/screens/dashboard_screen.dart';

class OrderCompleteScreen extends StatelessWidget {
  final String? orderID;

  const OrderCompleteScreen({Key? key, this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Images.doneWithFullBackground,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 20),
              Text(
                getTranslated('order_successfully_delivered', context)!,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getTranslated('order_id', context)!,
                    style: Theme.of(context).textTheme.displayMedium!,
                  ),
                  Text(
                    ' #$orderID',
                    style: Theme.of(context).textTheme.displaySmall!,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomButtonWidget(
                btnTxt: getTranslated('back_home', context),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DashboardScreen()), (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
