import 'package:emarket_delivery_boy/helper/map_helper.dart';
import 'package:emarket_delivery_boy/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:emarket_delivery_boy/features/order/domain/models/order_model.dart';
import 'package:emarket_delivery_boy/localization/language_constrants.dart';
import 'package:emarket_delivery_boy/commons/providers/localization_provider.dart';
import 'package:emarket_delivery_boy/commons/providers/location_provider.dart';
import 'package:emarket_delivery_boy/utill/dimensions.dart';
import 'package:emarket_delivery_boy/utill/images.dart';
import 'package:emarket_delivery_boy/commons/widgets/custom_button_widget.dart';
import 'package:emarket_delivery_boy/features/order/screens/order_details_screen.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel? orderModel;
  final int index;
  const OrderWidget({Key? key, this.orderModel, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLtr = Provider.of<LocalizationProvider>(context).isLtr;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Theme.of(context).shadowColor.withOpacity(.5), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))],
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          ),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Text(
                  getTranslated('order_id', context)!,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                ),

                Text(
                  ' # ${orderModel!.id.toString()}',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ]),
            ]),
            const SizedBox(height: 25),

            Row(children: [
              Image.asset(Images.location, color: Theme.of(context).textTheme.bodyLarge!.color, width: 15, height: 20),
              const SizedBox(width: 10),

              Expanded(child: Text(
                orderModel!.deliveryAddress != null ? orderModel!.deliveryAddress!.address! : 'Address not found',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
              )),
            ]),
            const SizedBox(height: 25),

            Row(children: [
              Expanded(child: CustomButtonWidget(
                btnTxt: getTranslated('view_details', context),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderModelItem: orderModel)));
                },
                isShowBorder: true,
              )),
              const SizedBox(width: 20),

              Consumer<LocationProvider>(builder: (context, locationProvider, child){
                return Expanded(child: CustomButtonWidget(
                    btnTxt: getTranslated('direction', context),
                    onTap: () {
                      MapHelper.openMap(
                          double.parse(orderModel!.deliveryAddress!.latitude!),
                          double.parse(orderModel!.deliveryAddress!.longitude!),
                          locationProvider.currentLocation.latitude,
                          locationProvider.currentLocation.longitude);
                    }));
              }),
            ]),
          ]),
        ),

        Positioned.fill(
          child: Align(
            alignment: isLtr ?  Alignment.topRight : Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:  BorderRadius.only(
                  topRight: isLtr ? const Radius.circular(Dimensions.paddingSizeSmall) : Radius.zero,
                  bottomLeft: isLtr ? const Radius.circular(Dimensions.paddingSizeSmall) : Radius.zero,
                  bottomRight: isLtr ? Radius.zero : const Radius.circular(Dimensions.paddingSizeSmall),
                  topLeft: isLtr ? Radius.zero : const Radius.circular(Dimensions.paddingSizeSmall),
                ),
              ),
              child: Text(
                getTranslated('${orderModel!.orderStatus}', context)!,
                style: rubikRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}


