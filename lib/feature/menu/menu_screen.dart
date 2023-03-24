import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'widget/menu_button.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    double _ratio = ResponsiveHelper.isDesktop(context) ? 1.1 : ResponsiveHelper.isTab(context) ? 1.1 : 1.2;
    final List<MenuModel> _menuList = [
      MenuModel(icon: Images.profileIcon, title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
      MenuModel(icon: Images.chatImage, title: 'inbox'.tr, route:_isLoggedIn? RouteHelper.getInboxScreenRoute() :  RouteHelper.getSignInRoute(RouteHelper.main)),
      MenuModel(icon: Images.translate, title: 'language'.tr, route: RouteHelper.getLanguageScreen('fromSettingsPage')),
      MenuModel(icon: Images.settings, title: 'settings'.tr, route: RouteHelper.getSettingRoute()),
      MenuModel(icon: Images.bookingsIcon, title: 'bookings'.tr, route:_isLoggedIn ?
      RouteHelper.getBookingScreenRoute(true) : RouteHelper.getNotLoggedScreen('my_bookings'.tr)),
      MenuModel(icon: Images.voucherIcon, title: 'vouchers'.tr, route: RouteHelper.getVoucherRoute()),
      MenuModel(icon: Images.aboutUs, title: 'about_us'.tr, route: RouteHelper.getHtmlRoute('about_us')),
      if(Get.find<SplashController>().configModel.content!.termsAndConditions != "")
      MenuModel(icon: Images.termsIcon, title: 'terms_and_conditions'.tr, route: RouteHelper.getHtmlRoute('terms-and-condition')),
      MenuModel(icon: Images.privacyPolicyIcon, title: 'privacy_policy'.tr, route: RouteHelper.getHtmlRoute('privacy-policy')),
      if(Get.find<SplashController>().configModel.content!.cancellationPolicy != "")
        MenuModel(icon: Images.cancellationPolicy, title: 'cancellation_policy'.tr, route: RouteHelper.getHtmlRoute('cancellation_policy')),
      if(Get.find<SplashController>().configModel.content!.refundPolicy != "")
        MenuModel(icon: Images.refundPolicy, title: 'refund_policy'.tr, route: RouteHelper.getHtmlRoute('refund_policy')),
      MenuModel(icon: Images.helpIcon, title: 'help_&_support'.tr, route: RouteHelper.getSupportRoute()),
    ];
    _menuList.add(MenuModel(icon: Images.logout, title: _isLoggedIn ? 'logout'.tr : 'sign_in'.tr, route: ''));

    return PointerInterceptor(
      child: Container(
        width: Dimensions.WEB_MAX_WIDTH,
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Theme.of(context).cardColor,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.keyboard_arrow_down_rounded, size: 30,color: Theme.of(context).colorScheme.primary,),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 6 : 4,
              childAspectRatio: (1/_ratio),
              crossAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_SMALL, mainAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            itemCount: _menuList.length,
            itemBuilder: (context, index) {
              return MenuButton(menu: _menuList[index], isLogout: index == _menuList.length-1);
            },
          ),
          Text("${'app_version'.tr} ${AppConstants.APP_VERSION}",style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5)),),
          SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.PADDING_SIZE_DEFAULT : 0),

        ]),
      ),
    );
  }
}
