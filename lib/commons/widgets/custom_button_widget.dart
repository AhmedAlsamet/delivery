import 'package:emarket_delivery_boy/localization/language_constrants.dart';
import 'package:emarket_delivery_boy/utill/dimensions.dart';
import 'package:emarket_delivery_boy/utill/styles.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final Function? onTap;
  final String? btnTxt;
  final bool isShowBorder;
  final bool isLoading;

  const CustomButtonWidget({Key? key, this.onTap, required this.btnTxt, this.isShowBorder = false, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: !isShowBorder ? Colors.grey.withOpacity(0.2) : Colors.transparent, spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isShowBorder ? Theme.of(context).hintColor.withOpacity(0.5) : Colors.transparent),
        color: !isShowBorder ? Theme.of(context).primaryColor : Colors.transparent,
      ),
      child: isLoading ? Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 15, width: 15,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2,
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),

        Text(getTranslated('loading', context)!, style: rubikBold.copyWith(color: Colors.white)),

      ])) : TextButton(
        onPressed: onTap as void Function()?,
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
        child: Text(btnTxt ?? "", style: Theme.of(context).textTheme.displaySmall!.copyWith(
          color: !isShowBorder ?  Colors.white : Theme.of(context).textTheme.bodyLarge!.color,
          fontSize: Dimensions.fontSizeLarge,
        )),
      ),
    );
  }
}
