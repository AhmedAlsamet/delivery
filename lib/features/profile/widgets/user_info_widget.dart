import 'package:emarket_delivery_boy/utill/dimensions.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final String? text;
  const UserInfoWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        color: Theme.of(context).canvasColor,
        border: Border.all(color: const Color(0xFFDCDCDC)),
      ),
      child: Text(
        text ?? '',
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
