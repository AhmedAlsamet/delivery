import 'package:emarket_delivery_boy/features/language/domain/models/language_model.dart';
import 'package:emarket_delivery_boy/features/language/providers/language_provider.dart';
import 'package:emarket_delivery_boy/utill/dimensions.dart';
import 'package:emarket_delivery_boy/utill/images.dart';
import 'package:emarket_delivery_boy/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageItemWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final int index;
  const LanguageItemWidget({Key? key, required this.languageModel, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, languageProvider, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          onTap: () => languageProvider.changeSelectIndex(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              border: languageProvider.selectIndex == index ? Border.all(color: Theme.of(context).primaryColor.withOpacity(0.15), width: 1) : null,
              color: languageProvider.selectIndex == index ? Theme.of(context).primaryColor.withOpacity(0.1) : null,

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(languageModel.imageUrl!, width: 34, height: 34),
                    ),
                    const SizedBox(width: 30),

                    Text(
                      languageModel.languageName!,
                      style: rubikMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                  ],
                ),

                languageProvider.selectIndex == index ? Image.asset(
                  Images.done,
                  width: 17,
                  height: 17,
                  color: Theme.of(context).primaryColor,
                ) : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      );
    });
  }
}
