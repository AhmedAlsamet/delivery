import 'dart:io';
import 'package:emarket_delivery_boy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:emarket_delivery_boy/features/order/domain/models/order_model.dart';
import 'package:emarket_delivery_boy/localization/language_constrants.dart';
import 'package:emarket_delivery_boy/features/chat/providers/chat_provider.dart';
import 'package:emarket_delivery_boy/features/splash/providers/splash_provider.dart';
import 'package:emarket_delivery_boy/utill/dimensions.dart';
import 'package:emarket_delivery_boy/utill/images.dart';
import 'package:emarket_delivery_boy/utill/styles.dart';
import 'package:emarket_delivery_boy/helper/custom_snackbar_helper.dart';
import 'package:emarket_delivery_boy/features/chat/widgets/message_bubble_widget.dart';
import 'package:provider/provider.dart';
import '../widgets/message_bubble_shimmer_widget.dart';

class ChatScreen extends StatefulWidget {
  final OrderModel? orderModel;
  const ChatScreen({Key? key,required this.orderModel}) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver{
  final TextEditingController _inputMessageController = TextEditingController();
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(Get.context!, listen: false).getChatMessages(widget.orderModel!.id);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.orderModel?.customer?.fName} ${widget.orderModel?.customer?.lName}', style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        leading: const BackButton(color: Colors.white),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(width: 40,height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 2,color: Theme.of(context).cardColor),
                  color: Theme.of(context).cardColor),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: Images.profile,
                  image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl}/${widget.orderModel!.customer!.image}',
                  imageErrorBuilder: (c,t,o) => Image.asset(Images.profile),
                ),
              ),
            ),
          ),
        ],
      ),

      body: Column(children: [
        Consumer<ChatProvider>(builder: (context, chatProvider,child) {
          bool isLoading = chatProvider.messages == null;

          return Expanded(child: ListView.builder(
            reverse: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: isLoading ? 25 : chatProvider.messages!.length,
            itemBuilder: (context, index) => isLoading ? MessageBubbleShimmerWidget(
              isMe: index.isEven,
            ) : MessageBubbleWidget(messages: chatProvider.messages![index]),
          ));

        }),

        Container(
          color: Theme.of(context).cardColor,
          child: Column(children: [
            Consumer<ChatProvider>(builder: (context, chatProvider,_) {
              return chatProvider.chatImage.isNotEmpty ? SizedBox(height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: chatProvider.chatImage.length,
                  itemBuilder: (BuildContext context, index){
                    return  chatProvider.chatImage.isNotEmpty?
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Container(width: 100, height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault)),
                              child: Image.file(File(chatProvider.chatImage[index].path), width: 100, height: 100, fit: BoxFit.cover,
                              ),
                            ) ,
                          ),
                          Positioned(
                            top:0,right:0,
                            child: InkWell(
                              onTap :() => chatProvider.removeImage(index),
                              child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault))
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(Icons.clear,color: Colors.red,size: 15,),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ) : const SizedBox();

                  },),
              ):const SizedBox();

            }),

            Row(children: [
              InkWell(
                onTap: () async {
                  Provider.of<ChatProvider>(context, listen: false).pickImage(false);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(width: 25,height: 25,
                    child: Image.asset(Images.image),
                  ),
                ),
              ),

              SizedBox(
                height: 25,
                child: VerticalDivider(width: 0, thickness: 1, color: Theme.of(context).hintColor),
              ),
              const SizedBox(width: Dimensions.paddingSizeDefault),

              Expanded(child: TextField(
                controller: _inputMessageController,
                inputFormatters: [LengthLimitingTextInputFormatter(Dimensions.messageInputLength)],
                textCapitalization: TextCapitalization.sentences,
                style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (newText){
                  if(newText.trim().isNotEmpty && !Provider.of<ChatProvider>(context, listen: false).isSendButtonActive) {
                    Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                  }else if(newText.isEmpty && Provider.of<ChatProvider>(context, listen: false).isSendButtonActive) {
                    Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                  }
                },
                onSubmitted: (String newText) {
                  if(newText.trim().isNotEmpty && !Provider.of<ChatProvider>(context, listen: false).isSendButtonActive) {
                    Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                  }else if(newText.isEmpty && Provider.of<ChatProvider>(context, listen: false).isSendButtonActive) {
                    Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                  }
                },
                decoration: InputDecoration(
                  //suffixIcon: Image.asset(Images.send,scale: 3,color: Theme.of(context).primaryColor,),
                  border: InputBorder.none,
                  hintText: getTranslated('type_here', context),
                  hintStyle: rubikRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge),
                ),
              )),

              Consumer<ChatProvider>(builder: (context, chatPro,_)=> InkWell(
                onTap: () async {
                  if(Provider.of<ChatProvider>(context, listen: false).isSendButtonActive){
                    chatPro.sendMessage(_inputMessageController.text.trim(),chatPro.chatImage,widget.orderModel!.id,context).then((value){
                      if(value.statusCode==200){
                        Provider.of<ChatProvider>(context, listen: false).getChatMessages(widget.orderModel!.id);
                        _inputMessageController.clear();
                      }
                    });
                    Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                  }else{
                    showCustomSnackBar(getTranslated('write_some_thing', context)!);
                  }

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: chatPro.isLoading ? const SizedBox(
                    width: 25, height: 25,
                    child: CircularProgressIndicator(),
                  ) : Image.asset(Images.send, width: 25, height: 25,
                    color: Provider.of<ChatProvider>(context).isSendButtonActive ? Theme.of(context).primaryColor : Theme.of(context).hintColor,
                  ),
                ),
              )),

            ]),
          ],
          ),
        ),
      ]),
    );
  }
}