import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/conversation/widgets/inbox_shimmer.dart';

class ChannelList extends GetView<ConversationController> {
  const ChannelList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(title: 'inbox'.tr, isBackButtonExist: true,),
      body: GetBuilder<ConversationController>(
        initState:(state) async  {
          await Get.find<ConversationController>().createChannel(Get.find<SplashController>().configModel.content!.adminDetails!.id??"", "",shouldUpdate: false);
          print(Get.find<SplashController>().configModel.content!.adminDetails!.id);
          Get.find<ConversationController>().getChannelList(1);
          Get.find<UserController>().getUserInfo();
        },
        builder: (conversationController){



            return FooterBaseView(
              isCenter: (conversationController.channelList == null || conversationController.channelList!.length == 0),
              child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: conversationController.channelList == null ?
                InboxShimmer() :
                conversationController.channelList!.length > 0 ?
                Column(
                  children: [
                    if(ResponsiveHelper.isWeb())
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                    conversationController.adminConversationModel!=null?
                    ChannelItem(
                      conversationUserModel: conversationController.adminConversationModel!,
                      channelupdatedAt: conversationController.adminConversationModel!.createdAt,
                      isRead: 1,
                      bookingID: '',
                    ): SizedBox(),
                    ListView.builder(
                        controller: conversationController.scrollController,
                        itemCount: controller.channelList!.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          bool user =
                          ((controller.channelList![index].channelUsers![0].user != null && controller.channelList![index].channelUsers![0].user!.userType !='super-admin')
                              &&  (controller.channelList![index].channelUsers![1].user != null && controller.channelList![index].channelUsers![1].user!.userType !='super-admin'));
                          int? _isRead;
                          if(user){
                            _isRead = controller.channelList![index].channelUsers![0].user!.userType == "customer" ?
                            controller.channelList![index].channelUsers![0].isRead! : controller.channelList![index].channelUsers![1].isRead!;
                          }
                          return user? ChannelItem(
                            conversationUserModel:  controller.channelList![index].channelUsers![0].user!.userType != "customer" ?
                            controller.channelList![index].channelUsers![0] : controller.channelList![index].channelUsers![1],
                            channelupdatedAt: controller.channelList!.elementAt(index).updatedAt!,
                            isRead: _isRead!,
                            bookingID: controller.channelList!.elementAt(index).referenceId??'',
                          ): SizedBox();
                        }
                    ),
                  ],
                ):
                NoDataScreen(text: 'your_inbox_list_empty'.tr,type: NoDataType.INBOX,)
              ),
            );
        },
      ),
      // floatingActionButton: GestureDetector(
      //   onTap: (){
      //     if(isRedundentClick(DateTime.now())){
      //       return;
      //     }
      //     String userId = Get.find<SplashController>().configModel.content!.adminDetails!.id!;
      //     String name = Get.find<SplashController>().configModel.content!.adminDetails!.firstName!+" "+Get.find<SplashController>().configModel.content!.adminDetails!.lastName!;
      //     String image = "$imageBaseUrl/user/profile_image/${Get.find<SplashController>().configModel.content!.adminDetails!.profileImage!}";
      //     Get.find<ConversationController>().createChannel(userId, "");
      //   },
      //   child: Container(
      //     height: Dimensions.FLOATING_BUTTON_HEIGHT,
      //     width: 180,
      //     margin: EdgeInsets.symmetric(horizontal:ResponsiveHelper.isDesktop(context)? (MediaQuery.of(context).size.width-Dimensions.WEB_MAX_WIDTH)/2:0),
      //     decoration: BoxDecoration(
      //         color: Theme.of(context).colorScheme.primary,
      //         borderRadius: BorderRadius.circular(50)
      //     ),
      //
      //     child: Center(
      //       child: Text('chat_with_admin'.tr,
      //         style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).primaryColorLight),),
      //     ),
      //   ),
      // ),
    );
  }
}
