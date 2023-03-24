import 'package:demandium/controller/localization_controller.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:demandium/core/helper/route_helper.dart';
import 'package:demandium/feature/auth/controller/auth_controller.dart';
import 'package:demandium/feature/cart/controller/cart_controller.dart';
import 'package:demandium/feature/splash/controller/splash_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/images.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'confirmation_dialog.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState  extends State<MenuDrawer> with SingleTickerProviderStateMixin {


  List<Menu> _menuList = [
    Menu(icon: Images.profileIcon, title: 'profile'.tr, onTap: () {
      Get.offNamed(RouteHelper.getProfileRoute());
    }),
    Menu(icon: Images.chatImage, title: 'inbox'.tr, onTap: () {
      Get.offNamed(Get.find<AuthController>().isLoggedIn() ? RouteHelper.getInboxScreenRoute():RouteHelper.getSignInRoute(RouteHelper.main));
    }),
    Menu(icon: Images.translate, title: 'language'.tr, onTap: () {
      Get.back();
      Get.toNamed(RouteHelper.getLanguageScreen('menuDrawer'));
    }),
    Menu(icon: Images.settings, title: 'settings'.tr, onTap: () {
      Get.back();
      Get.toNamed(RouteHelper.getSettingRoute());
    }),
    Menu(icon: Images.bookingsIcon, title: 'bookings'.tr, onTap: () {
      Get.back();
      Get.offNamed(Get.find<AuthController>().isLoggedIn() ?
      RouteHelper.getBookingScreenRoute(true) : RouteHelper.getNotLoggedScreen('my_bookings'.tr));
    }),

    Menu(icon: Images.voucherIcon, title: 'vouchers'.tr, onTap: () {
      Get.offNamed(RouteHelper.getVoucherRoute());
    }),
    Menu(icon: Images.aboutUs, title: 'about_us'.tr, onTap: () {
      Get.offNamed(RouteHelper.getHtmlRoute('about_us'));
    }),

    Menu(icon: Images.termsIcon, title: 'terms_and_conditions'.tr, onTap: () {
      Get.offNamed( RouteHelper.getHtmlRoute('terms-and-condition'));
    }),
    Menu(icon: Images.privacyPolicyIcon, title: 'privacy_policy'.tr, onTap: () {
      Get.offNamed( RouteHelper.getHtmlRoute('privacy-policy'));
    }),

    if(Get.find<SplashController>().configModel.content!.cancellationPolicy != "")
    Menu(icon: Images.cancellationPolicy, title: 'cancellation_policy'.tr, onTap: () {
        Get.offNamed(RouteHelper.getHtmlRoute('cancellation_policy'));
      }),
    if(Get.find<SplashController>().configModel.content!.refundPolicy != "")
     Menu(icon: Images.refundPolicy, title: 'refund_policy'.tr, onTap: () {
        Get.offNamed(RouteHelper.getHtmlRoute('refund_policy'));
      }),
    Menu(icon: Images.helpIcon, title: 'help_&_support'.tr, onTap: () {
      Get.offNamed( RouteHelper.getSupportRoute());
    }),

     Menu(icon: Images.logout, title:Get.find<AuthController>().isLoggedIn() ? 'logout'.tr : 'sign_in'.tr, onTap: () {
       Get.back();
       if(Get.find<AuthController>().isLoggedIn()) {
         Get.dialog(ConfirmationDialog(icon: Images.logoutIcon, description: 'are_you_sure_to_logout'.tr, isLogOut: true, onYesPressed: () {
           Get.find<AuthController>().clearSharedData();
           Get.find<CartController>().clearCartList();
           Get.find<AuthController>().googleLogout();
           Get.find<AuthController>().signOutWithFacebook();
           Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
         }), useSafeArea: false);
       }else {
         Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
       }
      }),
  ];


  static const _initialDelayTime = Duration(milliseconds: 200);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration = _initialDelayTime + (_staggerTime * 7) + _buttonDelayTime + _buttonTime;

  AnimationController? _staggeredController;
  final List<Interval> _itemSlideIntervals = [];

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();
    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menuList.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }
  }

  @override
  void dispose() {
    _staggeredController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? _buildContent() : null;
  }

  _buildContent(){
    return Align(alignment:Get.find<LocalizationController>().isLtr? Alignment.topRight : Alignment.topLeft, child: Container(
      width: 300,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)), color: Theme.of(context).cardColor),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE, horizontal: 25),
              margin: EdgeInsets.only(right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
                color: Theme.of(context).primaryColor,
              ),
              alignment: Alignment.centerLeft,
              child: Text('menu'.tr, style: ubuntuBold.copyWith(fontSize: 20, color: Colors.white)),
            ),

            ListView.builder(
              itemCount: _menuList.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _staggeredController!,
                  builder: (context, child) {
                    final animationPercent = Curves.easeOut.transform(
                      _itemSlideIntervals[index].transform(_staggeredController!.value),
                    );
                    final opacity = animationPercent;
                    final slideDistance = (1.0 - animationPercent) * 150;

                    return Opacity(
                      opacity: opacity,
                      child: Transform.translate(
                        offset: Offset(slideDistance, 0),
                        child: child,
                      ),
                    );
                  },
                  child: InkWell(
                    onTap: _menuList[index].onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Row(children: [

                        Container(
                          height: 60, width: 60, alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Image.asset(_menuList[index].icon!, height: 30, width: 30),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                        Expanded(child: Text(_menuList[index].title!, style: ubuntuMedium, overflow: TextOverflow.ellipsis, maxLines: 1)),

                      ]),
                    ),
                  ),
                );
              },
            ),

          ],
        ),
      ),
    ));
  }
}



class Menu {
  String? icon;
  String? title;
  Function()? onTap;

  Menu({@required this.icon, @required this.title, @required this.onTap});
}