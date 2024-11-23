import 'package:emarket_delivery_boy/localization/language_constrants.dart';
import 'package:emarket_delivery_boy/features/order/providers/order_provider.dart';
import 'package:emarket_delivery_boy/features/profile/providers/profile_provider.dart';
import 'package:emarket_delivery_boy/features/splash/providers/splash_provider.dart';
import 'package:emarket_delivery_boy/utill/dimensions.dart';
import 'package:emarket_delivery_boy/commons/widgets/custom_image_widget.dart';
import 'package:emarket_delivery_boy/commons/widgets/custom_will_pop_widget.dart';
import 'package:emarket_delivery_boy/features/home/widgets/order_widget.dart';
import 'package:emarket_delivery_boy/features/language/screens/choose_language_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {

    return CustomWillPopWidget(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        leadingWidth: 0,
        actions: [
          Consumer<OrderProvider>(builder: (context, orderProvider, child) {
            return orderProvider.isLoading ?  Center(child: SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
              width: Dimensions.paddingSizeExtraLarge,
              child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
            )) : IconButton(
              icon: Icon(Icons.refresh, color: Theme.of(context).textTheme.bodyLarge!.color),
              onPressed: () {
                orderProvider.refresh();
              },
            );

          }),

          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'language':
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChooseLanguageScreen(fromHomeScreen: true)));
              }
            },
            icon: Icon(
              Icons.more_vert_outlined,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'language',
                child: Row(
                  children: [
                    Icon(Icons.language, color: Theme.of(context).textTheme.bodyLarge!.color),
                    const SizedBox(width: Dimensions.paddingSizeLarge),
                    Text(
                      getTranslated('change_language', context)!,
                      style: Theme.of(context).textTheme.displayMedium!,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
        leading: const SizedBox.shrink(),
        title: Consumer<ProfileProvider>(builder: (context, profileProvider, child) {
          return profileProvider.userInfoModel != null ? Row(children: [
            Container(
              height: 40, width: 40,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CustomImageWidget(
                  image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.deliveryManImageUrl}/${profileProvider.userInfoModel!.image}',
                  height: 40, width: 40,
                ),
              ),
            ),
            const SizedBox(width: 10),

            Text(
              profileProvider.userInfoModel!.fName != null
                  ? '${profileProvider.userInfoModel!.fName ?? ''} ${profileProvider.userInfoModel!.lName ?? ''}'
                  : "",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: Dimensions.fontSizeLarge),
            )
          ]) : const SizedBox.shrink();
        }),
      ),
      body: Consumer<OrderProvider>(builder: (context, orderProvider, child){
        return Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated('active_order', context)!,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
              const SizedBox(height: 10),

              Expanded(child: RefreshIndicator(
                key: _refreshIndicatorKey,
                displacement: 0,
                color: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                onRefresh: () {
                  return orderProvider.refresh();
                },
                child: orderProvider.currentOrders != null
                    ? orderProvider.currentOrders!.isNotEmpty
                    ? ListView.builder(
                  itemCount: orderProvider.currentOrders!.length,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (context, index) => orderProvider.currentOrders![index].customer != null ?  OrderWidget(
                    orderModel: orderProvider.currentOrders![index],
                    index: index,
                  ) : const SizedBox(),
                )
                    :
                Center(child: Text(
                  getTranslated('no_order_found', context)!,
                  style: Theme.of(context).textTheme.displaySmall,
                )) : const SizedBox.shrink(),
              )),
            ],
          ),
        );
      }),
    ));
  }
}
