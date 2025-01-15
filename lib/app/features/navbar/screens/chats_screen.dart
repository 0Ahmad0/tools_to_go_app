import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/routing/routes.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/models/chat_model.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/app_padding.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/image_user_provider.dart';
import '../../../../core/widgets/no_data_found_widget.dart';
import '../../core/controllers/process_controller.dart';
import '../../messages/controller/chat_controller.dart';
import '../../messages/controller/chat_room_controller.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late ChatController chatController;
  final ProcessController _processController = Get.put(ProcessController());

  @override
  void initState() {
    chatController = Get.put(ChatController());
    chatController.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringManager.chatScreenText),
        ),
        body: AppPaddingWidget(
          horizontalPadding: 12.w,
          child: StreamBuilder<QuerySnapshot>(
              stream: chatController.getChats,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return    ConstantsWidgets.circularProgress();
                } else if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasError) {
                    return  Text(StringManager.emptyData);
                    // return  Text(tr(LocaleKeys.empty_data));
                  } else if (snapshot.hasData) {
                    ConstantsWidgets.circularProgress();
                    chatController.chats.listChat.clear();
                    if (snapshot.data!.docs!.length > 0) {
                      chatController.chats = Chats.fromJson(snapshot.data!.docs!);
                    }
                    return

                      (chatController.chats.listChat.isEmpty)
                          ?  Center(
                        child: NoDataFoundWidget(
                            image: AssetsManager.noMessagesIMG,
                            // text: tr(LocaleKeys.home_no_faces_available))
                            // text: StringManager.infoNotFacesYet
                            // text: tr(LocaleKeys.chat_no_chats_yet))
                            text: "لا يوجد لديك محادثات بعد!"),
                      )
                          :

                      buildChats(context, chatController.chats.listChat ?? []);
                  } else {
                    return  Text(StringManager.emptyData);
                    // return  Text(tr(LocaleKeys.empty_data));
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }),
        ),
      ),
    );
  }
  Widget buildChats(BuildContext context,List<Chat> items){

    return
      GetBuilder<ChatController>(
          builder: (ChatController controller)=>

              ListView.builder(
                  itemCount:  items.length,
                  itemBuilder: (context, index) {
                        String? idUser=(controller.currentUserId.contains(controller.chats.listChat[index].listIdUser[0]))
                            ?controller.chats.listChat[index].listIdUser[1]
                            :controller.chats.listChat[index].listIdUser[0];

                    return
                      ListTile(
                        onTap: (){
                          Get.put(ChatRoomController()).chat=controller.chats.listChat[index];

                                  context.pushNamed(Routes.messagesRoute,arguments: {
                                    'index':index.toString(),
                                    'chat':controller.chats.listChat[index]
                                  });
                          // context.pushNamed(Routes.messagesRoute);
                        },
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        leading:       GetBuilder<ProcessController>(
                                  builder: (ProcessController processController) {
                                    processController.fetchUserAsync(context, idUser: idUser);
                                    UserModel? user = processController.fetchLocalUser(idUser: idUser);
                                    return ImageUserProvider(
                                        url: user?.photoUrl,
                                      );}),
                        title:
                                fetchName(context,  idUser  ),
                        // Text(
                        //   'البائع',
                        //   style: StyleManager.font14SemiBold(),
                        // ),
                                trailing:

                                fetchTimeLastMessage(context,controller.chats.listChat[index].id),
                        subtitle:
                        fetchLastMessage(context,controller.chats.listChat[index].id)
                        // Text(
                        //   'آخر رسالة...',
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: StyleManager.font12Regular(),
                        // ),
                      );}
              )
              // ListView.separated(
              //   separatorBuilder: (_, __) => Divider(
              //     height: 0.0,
              //     thickness: .5,
              //   ),
              //   itemBuilder: (context, index) {
              //     String? idUser=(controller.currentUserId.contains(controller.chats.listChat[index].listIdUser[0]))
              //         ?controller.chats.listChat[index].listIdUser[1]
              //         :controller.chats.listChat[index].listIdUser[0];
              //
              //     return  ListTile(
              //       onTap: () {
              //         Get.put(ChatRoomController()).chat=controller.chats.listChat[index];
              //
              //         context.pushNamed(Routes.messagesRoute,arguments: {
              //           'index':index.toString(),
              //           'chat':controller.chats.listChat[index]
              //         });
              //         // context.pushNamed(Routes.chatRoute);
              //       },
              //       isThreeLine: true,
              //       contentPadding:
              //       EdgeInsets.symmetric(horizontal: 20.h, vertical: 4.h),
              //       leading:
              //       GetBuilder<ProcessController>(
              //           builder: (ProcessController processController) {
              //             processController.fetchUserAsync(context, idUser: idUser);
              //             UserModel? user = processController.fetchLocalUser(idUser: idUser);
              //             return ImageUserProvider(
              //                 url: user?.photoUrl,
              //               )
              //
              //
              //             ;
              //             // CircleAvatar(
              //             //   child: Icon(
              //             //     Icons.account_circle_outlined,
              //             //   ),
              //             // );
              //           }),
              //       trailing:
              //
              //       fetchTimeLastMessage(context,controller.chats.listChat[index].id),
              //       // Text(
              //       //   DateFormat().add_jm().format(DateTime.now()),
              //       //   style: StyleManager.font10Regular(
              //       //       color: ColorManager.blackColor),
              //       // ),
              //       title:
              //       fetchName(context,  idUser  ),
              //       // Text( 'Consultant ${index + 1}' ),
              //       subtitle: Padding(
              //         padding: EdgeInsets.only(top: 8.h),
              //         child:
              //         fetchLastMessage(context,controller.chats.listChat[index].id),
              //         // Text('Yes, the work is all done',
              //         //   style: StyleManager.font12Regular(
              //         //       color: ColorManager.hintTextColor),
              //         // ),
              //       ),
              //     );},
              //   itemCount: items.length,
              // )

      );

  }

  fetchName(BuildContext context,String idUser){
    return _processController.widgetNameUser(context, idUser: idUser,style:  StyleManager.font14SemiBold());
  }
  fetchLocalUser(BuildContext context,String idUser){
    return _processController.fetchUser(context, idUser: idUser);
  }
  fetchLastMessage(BuildContext context,String idChat){
    return Get.put(ChatController()).widgetLastMessage(context, idChat: idChat);
  }
  fetchTimeLastMessage(BuildContext context,String idChat){
    return Get.put(ChatController()).widgetTimeLastMessage(context, idChat: idChat);
  }
}
