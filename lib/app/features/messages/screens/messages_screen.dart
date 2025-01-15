import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/models/message_model.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/image_user_provider.dart';
import '../../core/controllers/process_controller.dart';
import '../controller/chat_controller.dart';
import '../controller/chat_room_controller.dart';
import '/app/features/auth/screens/change_password_screen.dart';
import '/core/helpers/sizer.dart';
import '/core/helpers/spacing.dart';
import '/core/utils/assets_manager.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/style_manager.dart';
import '/core/widgets/app_padding.dart';
import '/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../widgets/receiver_text_widget.dart';
import '../widgets/sender_text_widget.dart';

var _borderTextFiled = ({Color color = ColorManager.primaryColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: color, width: 1.sp));

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _messageController = TextEditingController();
  List<String> _listMessages = [];
  late ChatRoomController controller;
  var args;
  var initData;
  @override
  void initState() {
    controller = Get.put(ChatRoomController());
    // messageController.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }



  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    Get.lazyPut(() => ProcessController());
    ProcessController.instance.fetchUser(context,idUser: controller.recId??'');
    return FadeInUp(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.more_vert,
          //       ))
          // ],
          leading: CustomBackButton(),
          titleSpacing: 0,
          leadingWidth: 30.w,
          title:

          GetBuilder<ProcessController>(
              builder: (ProcessController processController) =>

                  ListTile(
                    leading:  ImageUserProvider(
                      url:  '${processController.fetchLocalUser(idUser: controller.recId ?? '')?.photoUrl ?? ''}',
                    ),
                    title: Text(
                      '${processController.fetchLocalUser(idUser: controller.recId ?? 'عامل التوصيل')?.name ?? 'عامل التوصيل'}',
                      // 'البائع',
                      style: StyleManager.font14Bold(),
                    ),
                  ),
            )

        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

        Expanded(
        child:
        StreamBuilder<QuerySnapshot>(
            stream: controller.getChat,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return    ConstantsWidgets.circularProgress();
              } else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return  Text(StringManager.emptyData);
                  // return  Text(tr(LocaleKeys.empty_data));
                } else if (snapshot.hasData) {

                  // ConstantsWidgets.circularProgress();
                  controller.chat?.messages.clear();
                  if (snapshot.data!.docs!.length > 1) {
                    controller.chat?.messages =
                        Messages.fromJson(snapshot.data!.docs!).listMessage;
                  }

                  return GetBuilder<ChatRoomController>(
                      init: controller,
                      builder: (ChatRoomController chatRoomController){
                        Message? message=controller.waitMessage.lastOrNull;
                        message?.checkSend=false;
                        if(message!=null)
                          controller.chat?.messages.add( message);

                        return
                          buildChat(context,controller.chat?.messages ?? []);
                      });

                } else {
                  return  Text(StringManager.emptyData);
                  // return  Text(tr(LocaleKeys.empty_data));
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),),

            // _listMessages.isEmpty
            //     ? Flexible(
            //       child: Center(
            //                   child: Text("No Messages Yet!!😢",
            //                   style: StyleManager.font14Bold(),),
            //                 ),
            //     )
            //     : Expanded(
            //         child: ListView.builder(
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            //           itemCount: _listMessages.length,
            //           itemBuilder: (context, index) => index.isEven
            //               ? SenderTextWidget(text: _listMessages[index])
            //               : ReceiverTextWidget(text: _listMessages[index]),
            //         ),
            //       ),
            AppPaddingWidget(
              horizontalPadding: 10.w,
              child: TextField(
                controller: controller.messageController,
                // controller: _messageController,
                maxLines: 1,
                minLines: 1,
                decoration: InputDecoration(
                    focusedBorder: _borderTextFiled(),
                    border: _borderTextFiled(color: Colors.transparent),
                    enabledBorder: _borderTextFiled(color: Colors.transparent),
                    errorBorder: _borderTextFiled(color: ColorManager.errorColor),
                    iconColor: ColorManager.grayColor,
                    filled: true,
                    fillColor: ColorManager.grayColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        if(controller.messageController.text.trim().isNotEmpty)
                        // if(_messageController.text.trim().isNotEmpty)
                        // _listMessages.add(_messageController.text);
                        // _messageController.clear();
                        // setState(() {
                        //
                        // });
                        sendText();
                      },
                      icon: SvgPicture.asset(
                        AssetsManager.messageSendButtonIcon,
                      ),
                    ),
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          AssetsManager.chatSquareIcon,
                        ))),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget buildChat(BuildContext context, List<Message> messages) {
    controller.chatList = messages;

    return controller.chatList.isEmpty
        ? Flexible(
            child: Center(
                        child: Text("لا يوجد رسائل بعد!!😢",
                        style: StyleManager.font14Bold(),),
                      ),
          )
        :

    ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  itemCount:  messages.length,
                  itemBuilder: (context, index) => controller.chatList[index].senderId ==
                      controller.currentUserId
                      ? SenderTextWidget(text: messages[index].textMessage,sendingTime:messages[index].sendingTime ,)
                      : ReceiverTextWidget(text: messages[index].textMessage,sendingTime:messages[index].sendingTime),
                );
  }
  sendText() async {
    if (controller.messageController.value.text.trim().isNotEmpty) {
      String message = controller.messageController.value.text;
      controller.messageController.clear();
      await controller.sendMessage(
        context,
        idChat: controller.chat?.id ?? '',
        message: Message(
          textMessage: message,
          typeMessage: TypeMessage.text.name,
          senderId: controller.currentUserId,
          receiveId: controller.recId ?? '',
          sendingTime: DateTime.now(),
        ),
      );
      controller.update();
      Get.put(ChatController()).update();
    }
  }
}
