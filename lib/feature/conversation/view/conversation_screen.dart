import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/conversation/widgets/chatting_shimmer.dart';
import 'package:demandium/feature/conversation/widgets/message_widget.dart';

class ConversationScreen extends StatefulWidget {
  final String channelID;
  final String name;
  final String image;
  final String phone;
  final String bookingID;
  final String userType;

  ConversationScreen({
    required this.name,
    required this.image,
    required this.channelID,
    required this.phone,
    required this.bookingID,
    required this.userType});
  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar:ResponsiveHelper.isWeb() ? CustomAppBar(title:"${widget.name}\n+${widget.phone}",): AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColorLight),
          color: Theme.of(context).textTheme.bodyLarge!.color,
          onPressed: () => Navigator.pop(context),
        ) ,
        title: Text(
            "${widget.name}\n"
                "${widget.userType=="provider"
                && Get.find<SplashController>().configModel.content?.phoneNumberVisibility==0?"": "+${widget.phone}"}",
            style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CustomImage(image: widget.image),
              ),
            ),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL,)
        ],
      ),

      body: FooterBaseView(
        isScrollView:(!ResponsiveHelper.isTab(context) && !ResponsiveHelper.isMobile(context) && ResponsiveHelper.isWeb())  ? true: false,
        child: WebShadowWrap(
          child: GetBuilder<ConversationController>(
              initState: (state) {
                Get.find<ConversationController>().cleanOldData();
                Get.find<ConversationController>().setChannelId(widget.channelID);
                Get.find<ConversationController>().getConversation(widget.channelID, 1,isInitial:true);
                },
              builder: (conversationController) {
                if(conversationController.conversationList != null){
                  List<ConversationData>? conversationList = conversationController.conversationList!;
                  String customerID = Get.find<UserController>().userInfoModel.id?? '';
                  return Container(
                    height:(!ResponsiveHelper.isTab(context) && !ResponsiveHelper.isMobile(context) && ResponsiveHelper.isWeb()) ? 500 : null,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EIGHT),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                        if(ResponsiveHelper.isWeb() && !ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context))
                        Text(widget.name,
                          style: ubuntuMedium.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),
                          textDirection: TextDirection.ltr,
                        ),
                        if(ResponsiveHelper.isWeb() && !ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context))
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                        if(ResponsiveHelper.isWeb() && !ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context))
                          Text("${widget.userType=="provider"
                              && Get.find<SplashController>().configModel.content?.phoneNumberVisibility==0?"":"+${widget.phone}"}",
                          style: ubuntuMedium.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),
                          textDirection: TextDirection.ltr,
                        ),
                        Expanded(
                          child:conversationList.length>0 ?
                          ListView.builder(
                              itemCount:  conversationList.length,
                              reverse: true,
                              itemBuilder: (context,index){
                                bool isRightMessage = conversationList.elementAt(index).userId == customerID;
                                return ConversationBubble(
                                  conversationData:conversationList.elementAt(index),
                                  oppositeName: widget.name,
                                  oppositeImage: widget.image,
                                  isRightMessage: isRightMessage,);}):
                          SizedBox(child: Center(child: Text('no_conversation_yet'.tr)),),
                        ),
                        Column(
                          children: [
                            conversationController.pickedImageFile != null && conversationController.pickedImageFile!.length > 0 ?
                            Container(
                              height: 90,
                              width: Get.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index){
                                  return  Stack(children: [
                                    Padding(padding: const EdgeInsets.only(left: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          child:ResponsiveHelper.isWeb() ? Image.network(
                                            conversationController.pickedImageFile![index].path,
                                            fit: BoxFit.cover,
                                          ) : Image.file(
                                            File(conversationController.pickedImageFile![index].path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: InkWell(
                                        child: Icon(Icons.cancel_outlined, color: Colors.red),
                                        onTap: () {
                                          conversationController.pickMultipleImage(true,index: index);
                                        },
                                      ),
                                    )
                                  ],
                                  );
                                },
                                itemCount: conversationController.pickedImageFile!.length,
                              ),
                            ) :
                            SizedBox(),
                            conversationController.otherFile != null ?
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(horizontal: 25),
                                      child: Center(child: Text(conversationController.otherFile!.names.elementAt(0).toString()))),
                                  InkWell(
                                    child: Icon(Icons.cancel_outlined, color: Colors.red),
                                    onTap: () {
                                      conversationController.pickOtherFile(true);
                                    },
                                  )
                                ],
                              ),
                            ):
                            SizedBox(),
                            Container(
                              margin: EdgeInsets.only(
                                  left: Dimensions.PADDING_SIZE_SMALL,
                                  right: Dimensions.PADDING_SIZE_SMALL,
                                  bottom: Dimensions.PADDING_SIZE_SMALL),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                  boxShadow: Get.isDarkMode?null:shadow,
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_EXTRA_LARGE))),
                              child: Form(
                                key: conversationController.conversationKey,
                                child: Row(children: [
                                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                                  Expanded(
                                    child: TextField(
                                      controller: conversationController.conversationController,
                                      textCapitalization: TextCapitalization.sentences,
                                      cursorColor: Theme.of(context).hintColor,
                                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color:Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8)),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "type_here".tr,
                                        hintStyle: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.8), fontSize: 16),),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                        child: InkWell(
                                          child: Image.asset(
                                            Images.image,
                                            width: 20.0,
                                            height: 20.0,
                                            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                                          ),
                                          onTap: () => conversationController.pickMultipleImage(false),
                                        ),
                                      ),
                                      InkWell(
                                        child: Image.asset(
                                          Images.file,
                                          width: 20.0,
                                          height: 20.0,
                                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                                        ),
                                        onTap: () => conversationController.pickOtherFile(false),
                                      ),
                                      conversationController.isLoading! ?
                                      Container(padding: EdgeInsets.symmetric(horizontal: 10),
                                          height: 20, width: 40,
                                          child: Center(child: CircularProgressIndicator())) :
                                      InkWell(
                                        onTap: (){
                                          if(conversationController.conversationController.text.isEmpty
                                              && conversationController.pickedImageFile!.isEmpty
                                              && conversationController.otherFile==null){
                                            customSnackBar("write_something".tr);
                                          }
                                          else if(conversationController.conversationKey.currentState!.validate()){
                                            conversationController.sendMessage(widget.channelID);
                                          }
                                          conversationController.conversationController.clear();
                                        },
                                        child: Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                            child:Image.asset(Images.sendMessage, width: 25, height: 25, color: Colors.lightBlueAccent)
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }else{
                  return Container(
                      height: ResponsiveHelper.isWeb() ? 500 : null,
                      child: ChattingShimmer());
                }
              }),
        ),
      ),
    );
  }
}
