import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/conversation/model/conversation_user.dart';

class ChannelItem extends StatelessWidget {
  final String channelupdatedAt;
  final ConversationUserModel conversationUserModel;
  final int isRead;
  final String bookingID;
  const ChannelItem({Key? key, required this.conversationUserModel, required this.channelupdatedAt, required this.isRead,required this.bookingID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String imagePath = conversationUserModel.user!.userType=="customer"?"/user/profile_image/"
        :conversationUserModel.user!.userType=="provider-admin"?"/provider/logo/"
        :conversationUserModel.user!.userType=="super-admin"?"/user/profile_image/"
        :conversationUserModel.user!.userType=="provider-serviceman"?"/serviceman/profile/":"";
    String name = '';
    String image = '';
    String userTypeImage = '';
    String phone = '';

    if(conversationUserModel.user!.provider != null){
      name =  conversationUserModel.user!.provider!.companyName!;
      print(conversationUserModel.user!.provider!.companyName!);
      image = '${Get.find<SplashController>().configModel.content!.imageBaseUrl}''$imagePath${conversationUserModel.user!.provider!.logo!}';
      userTypeImage =  'provider'.tr;
      phone = conversationUserModel.user!.phone!;

    }else{
      name = conversationUserModel.user!.firstName!+ " " +conversationUserModel.user!.lastName!;
      phone = conversationUserModel.user!.phone!;
      image = '${Get.find<SplashController>().configModel.content!.imageBaseUrl}''$imagePath${conversationUserModel.user!.profileImage!}';
      userTypeImage = conversationUserModel.user!.userType! == 'provider-serviceman'?"provider-serviceman".tr:"super-admin".tr;
    }


    return InkWell(
      onTap:(){
        Get.find<ConversationController>().setChannelId(conversationUserModel.channelId!);
        Get.find<ConversationController>().setUserImageType(userTypeImage);
        Get.toNamed(RouteHelper.getChatScreenRoute(conversationUserModel.channelId!,name,image,phone,bookingID));
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isRead == 0? Theme.of(context).colorScheme.primary.withOpacity(.5) : Theme.of(context).hoverColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                ClipRRect(borderRadius: BorderRadius.circular(50),
                  child: CustomImage(height: 50, width: 50,
                      image: image),
                ),
                Gaps.horizontalGapOf(Dimensions.PADDING_SIZE_SMALL),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: ubuntuMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color:Get.isDarkMode ? Theme.of(context).primaryColorLight:Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.8)
                          )
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              userTypeImage,
                              style: ubuntuRegular.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color:Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6) ),),
                            Text( "${DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(channelupdatedAt))}",
                                textDirection: TextDirection.ltr,
                                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall,
                                  color:Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),)),
                          ],
                        ),
                      ],
                    )
                ),



                SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
              ],
            ),
          ),
          if(conversationUserModel.user!.userType == "super-admin")
          Positioned(
            top: Dimensions.PADDING_SIZE_DEFAULT,
            right:Get.find<LocalizationController>().isLtr ?  Dimensions.PADDING_SIZE_DEFAULT : null,
            left:Get.find<LocalizationController>().isLtr ?  null : Dimensions.PADDING_SIZE_DEFAULT,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(.2),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_RADIUS,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Text('support'.tr,style: ubuntuMedium.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: Dimensions.fontSizeDefault),),
                )),
          ),
        ],
      ),
    );
  }
}

