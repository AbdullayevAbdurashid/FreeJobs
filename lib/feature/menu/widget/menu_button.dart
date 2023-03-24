import 'package:get/get.dart';
import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/core/core_export.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MenuButton extends StatelessWidget {
  final MenuModel? menu;
  final bool? isLogout;
  MenuButton({@required this.menu, @required this.isLogout});

  @override
  Widget build(BuildContext context) {
    int _count = ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 6 : 4;
    double _size = ((context.width > Dimensions.WEB_MAX_WIDTH ? Dimensions.WEB_MAX_WIDTH : context.width)/_count)-Dimensions.PADDING_SIZE_DEFAULT;

    return Stack(
      children: [
        Column(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
            height: _size-(_size*0.3),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            alignment: Alignment.center,
            child: Image.asset(menu!.icon!, width: _size, height: _size),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_RADIUS),
          Text(menu!.title!, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center),
        ]),
        Positioned.fill(child: RippleButton(onTap: () async {
          if(isLogout!) {
            print('inside_logout');
            Get.back();
            if(Get.find<AuthController>().isLoggedIn()) {
              Get.dialog(ConfirmationDialog(
                  icon: Images.logoutIcon,
                  description: 'are_you_sure_to_logout'.tr, isLogOut: true,
                  onYesPressed: () {
                Get.find<AuthController>().clearSharedData();
                Get.find<CartController>().clearCartList();
                Get.find<AuthController>().googleLogout();
                Get.find<AuthController>().signOutWithFacebook();

                Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
              }), useSafeArea: false);
            }else {
              Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
            }
          }else if(menu!.route!.startsWith('http')) {
            if(await canLaunchUrlString(menu!.route!)) {
          launchUrlString(menu!.route!, mode: LaunchMode.externalApplication);}}
          else {
            Get.offNamed(menu!.route!);
          }
        }))
      ],
    );
  }
}

