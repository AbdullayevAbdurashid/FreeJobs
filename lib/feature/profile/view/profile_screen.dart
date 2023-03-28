import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/feature/profile/model/profile_cart_item_model.dart';
import 'package:demandium/core/core_export.dart';

class ProfileScreen extends GetView<UserController> {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    final _profileCartModelList = [
      ProfileCardItemModel(
        'my_address'.tr, Images.address,Get.find<AuthController>().isLoggedIn() ?
      RouteHelper.getAddressRoute('fromProfileScreen') : RouteHelper.getNotLoggedScreen('my_address'.tr),
      ),
      ProfileCardItemModel(
        'notifications'.tr, Images.notification, RouteHelper.getNotificationRoute(),
      ),
      if(!Get.find<AuthController>().isLoggedIn() )
      ProfileCardItemModel(
        'sign_in'.tr, Images.logout, RouteHelper.getSignInRoute('profileScreen'),
      ),

      if(Get.find<AuthController>().isLoggedIn() && Get.find<UserController>().referCode!="" && Get.find<SplashController>().configModel.content?.referEarnStatus==1)
        ProfileCardItemModel(
          'refer_and_earn'.tr, Images.shareIcon, RouteHelper.getReferAndEarnScreen(),
        ),

      if(Get.find<AuthController>().isLoggedIn() )
        ProfileCardItemModel(
          'suggest_new_service'.tr, Images.suggestServiceIcon,RouteHelper.getNewSuggestedServiceScreen() ,
        ),

      if(Get.find<AuthController>().isLoggedIn() )
        ProfileCardItemModel(
          'delete_account'.tr, Images.accountDelete, 'delete_account',
        ),

      if(Get.find<AuthController>().isLoggedIn() )
        ProfileCardItemModel(
        'logout'.tr, Images.logout, 'sign_out',
      ),

    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(
        title: 'profile'.tr,
        centerTitle: true,
        bgColor: Theme.of(context).primaryColor,
        isBackButtonExist: true,
      ),

      body: GetBuilder<UserController>(
        initState: (state){
          if(_isLoggedIn){
            Get.find<UserController>().getUserInfo();
          }
        },

        builder: (userController) {
          return userController.isLoading ?
          Center(child: CircularProgressIndicator()) :
          FooterBaseView(
            child: WebShadowWrap(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileHeader(userInfoModel: userController.userInfoModel,),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
                      childAspectRatio: 6,
                      crossAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    itemCount: _profileCartModelList.length,
                    itemBuilder: (context, index) {
                      return ProfileCardItem(
                        title: _profileCartModelList[index].title,
                        leadingIcon: _profileCartModelList[index].loadingIcon,
                        onTap: () {
                          if(_profileCartModelList[index].routeName == 'sign_out'){
                            if(
                            Get.find<AuthController>().isLoggedIn()) {
                              Get.dialog(ConfirmationDialog(
                                  icon: Images.logoutIcon, description: 'are_you_sure_to_logout'.tr, isLogOut: true, onYesPressed: ()async {
                                Get.find<AuthController>().clearSharedData();
                                Get.find<CartController>().clearCartList();
                                Get.find<AuthController>().googleLogout();
                                Get.find<AuthController>().signOutWithFacebook();
                                Get.find<AuthController>().signOutWithFacebook();
                                // await FacebookAuth.instance.logOut();
                                Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                              }), useSafeArea: false);
                            }else {
                              Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                            }
                          }else if(_profileCartModelList[index].routeName == 'delete_account'){
                            Get.dialog(
                                ConfirmationDialog(
                                    icon: Images.deleteProfile,
                                    title: 'are_you_sure_to_delete_your_account'.tr,
                                    description: 'it_will_remove_your_all_information'.tr,
                                    isLogOut: true,
                                    yesText: 'delete',
                                    noText: 'cancel',
                                    descriptionTextColor: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
                                    onYesPressed: () => userController.removeUser()),
                                useSafeArea: false);
                          }
                          else{
                            Get.toNamed(_profileCartModelList[index].routeName);
                          }
                        },
                      );
                    },
                  ),

                  SizedBox(height:Dimensions.PADDING_SIZE_DEFAULT,)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

