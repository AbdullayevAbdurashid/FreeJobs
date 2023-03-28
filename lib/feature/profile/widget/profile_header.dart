import 'package:demandium/feature/profile/controller/edit_profile_tab_controller.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ProfileHeader extends GetView<UserController> {
  final UserInfoModel userInfoModel;
   ProfileHeader({Key? key,required this.userInfoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    return GetBuilder<UserController>(builder: (userController){
      return Container(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
            child: Stack(
              children: [
                Container(
                  width: Get.width,
                  child: Column(children: [
                    SizedBox(height:Dimensions.PADDING_SIZE_DEFAULT),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(150.0)),
                          child: CustomImage(
                            width: 130.0,
                            height: 130.0,
                            image:_isLoggedIn ? userController.userInfoModel.image != null ? Get.find<SplashController>().configModel.content!.imageBaseUrl!+"/user/profile_image/"+userController.userInfoModel.image! : '':'',
                          ),
                        ),

                      ],
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_LARGE, height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                    if(!_isLoggedIn)
                      Text('guest_user'.tr,
                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.5)),
                      ),
                    if( _isLoggedIn && userInfoModel.fName != null && userInfoModel.lName != null )
                      Text("${userInfoModel.fName! +" "+ userInfoModel.lName!}",
                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).textTheme.bodyMedium!.color),
                      ),

                    SizedBox(width: Dimensions.PADDING_SIZE_LARGE, height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                    _isLoggedIn ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(userInfoModel.bookingsCount != null)
                          ColumnText(
                            amount: userInfoModel.bookingsCount!,
                            title: 'bookings'.tr,
                          ),
                        ColumnText(
                          isProfileTimeAgo: true,
                          accountAgo: Get.find<UserController>().createdAccountAgo.tr,
                          amount: 340,
                          title: 'since_joined'.tr,
                        ),
                      ],
                    ) : SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  ],),
                ),

                _isLoggedIn ? Positioned(
                  right:Get.find<LocalizationController>().isLtr ? Dimensions.PADDING_SIZE_DEFAULT : null,
                  left:Get.find<LocalizationController>().isLtr ?null: Dimensions.PADDING_SIZE_DEFAULT,
                  top:Dimensions.PADDING_SIZE_SMALL,
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.profileEdit);
                      Get.find<EditProfileTabController>().resetPasswordText();
                    },
                    child: Row(
                      children: [
                        Text('edit'.tr,style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge,color: Theme.of(context).colorScheme.primary),),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                        Icon(Icons.edit,color: Theme.of(context).colorScheme.primary,size: Dimensions.fontSizeExtraLarge,)
                      ],
                    ),
                  ),
                ): SizedBox()
              ],
            ),
          ));
    });
  }
}
