import 'package:demandium/components/text_hover.dart';
import 'package:get/get.dart';
import 'package:demandium/components/web_search_widget.dart';
import 'package:demandium/core/core_export.dart';

class WebMenuBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
      width: Dimensions.WEB_MAX_WIDTH,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 8,
            color: Theme.of(context).primaryColor.withOpacity(0.15),
          )],
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(Dimensions.RADIUS_DEFAULT),
              bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT))
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL
      ),
      child: Row(children: [
        InkWell(
          onTap: () => Get.toNamed(RouteHelper.getInitialRoute()),
          child: Image.asset(Get.isDarkMode?Images.webAppbarLogoDark:Images.webAppbarLogo,width: 150),
        ),

        Get.find<LocationController>().getUserAddress() != null ? Expanded(
            child: InkWell(
              onTap: () => Get.toNamed(RouteHelper.getAccessLocationRoute('home')),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: GetBuilder<LocationController>(builder: (locationController) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Icon(
                        locationController.getUserAddress()!.addressType == 'home' ?
                        Icons.home_filled : locationController.getUserAddress()!.addressType == 'office' ? Icons.work : Icons.location_on,
                        size: 20, color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Flexible(
                    child: Text(
                      locationController.getUserAddress()!.address!,
                      style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: Dimensions.fontSizeExtraSmall,),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Get.isDarkMode? light.cardColor : Theme.of(context).primaryColor,
                  ),
                ],
              );
            }),
          ),
        )) :
        Expanded(child: SizedBox()),
        MenuButtonWeb(
            title: 'home'.tr,
            onTap: () => Get.toNamed(RouteHelper.getInitialRoute())),
        SizedBox(width: 10),
        MenuButtonWeb(
            title: 'categories'.tr,
            onTap: () {
              Get.toNamed(RouteHelper.getCategoryProductRoute(
                  Get.find<CategoryController>().categoryList![0].id!,
                  Get.find<CategoryController>().categoryList![0].name!,
                  0.toString()
        ));
            }),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        MenuButtonWeb( title: 'services'.tr, onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute('all_service'))),
        ///search widget
        SearchWidgetWeb(),
        MenuButtonWebIcon( icon: Images.notification, isCart: false, onTap: () => Get.toNamed(RouteHelper.getNotificationRoute())),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        MenuButtonWebIcon( icon: Images.offerMenu, isCart: false, onTap: () => Get.toNamed(RouteHelper.getOffersRoute('offer'))),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        MenuButtonWebIcon( icon: Images.webCartIcon, isCart: true, onTap: () => Get.toNamed(RouteHelper.getCartRoute())),
        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
        MenuButtonWebIcon(icon: Images.webHomeIcon, onTap: () {
          Scaffold.of(context).openEndDrawer();
        }),
        SizedBox(width: 10),
        GetBuilder<AuthController>(
            builder: (authController){
              return InkWell(
                onTap: () {
                  if(authController.isLoggedIn()){
                    Get.toNamed(RouteHelper.getBookingScreenRoute(true));
                  }else{
                    Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL,
                    vertical: Dimensions.PADDING_SIZE_SMALL-2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  ),
                  child: Row(children: [
                    authController.isLoggedIn() ?SizedBox.shrink():Image.asset(Images.webSignInButton,width: 16.0,height: 16.0,),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                    Text(authController.isLoggedIn() ? 'my_bookings'.tr : 'sign_in'.tr, style: ubuntuRegular.copyWith(color: Colors.white)),
                  ]),
                ),
              );
            }
        ),
      ]),
    ));
  }
  @override
  Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH, 70);
}

class MenuButtonWebIcon extends StatelessWidget {
  final String? icon;
  final bool isCart;
  final Function() onTap;
  MenuButtonWebIcon({@required this.icon, this.isCart = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(children: [
        Stack(clipBehavior: Clip.none, children: [

          Image.asset(
            icon!,
            height: 16,
            width: 16,
            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.7),
          ),

          isCart ? GetBuilder<CartController>(builder: (cartController) {
            return cartController.cartList.length > 0 ? Positioned(
              top: -7, right: -7,
              child: Container(
                padding: EdgeInsets.all(2),
                height: 15, width: 15, alignment: Alignment.center,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                child: FittedBox(
                  child: Text(
                    cartController.cartList.length.toString(),
                    style: ubuntuRegular.copyWith(fontSize: 12, color: light.cardColor),
                  ),
                ),
              ),
            ) : SizedBox();
          }) : SizedBox(),



        ]),
        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      ]),
    );
  }
}

class MenuButtonWeb extends StatelessWidget {
  final String? title;
  final bool isCart;
  final Function() onTap;
  MenuButtonWeb({@required this.title, this.isCart = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextHover(
      builder: (hovered){
        return Container(
          decoration: BoxDecoration(
            color:hovered ? Theme.of(context).colorScheme.primary.withOpacity(.1) : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT))
          ),
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:Dimensions.PADDING_SIZE_RADIUS, horizontal: Dimensions.PADDING_SIZE_RADIUS),
              child: Text(title!, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
            ),
          ),
        );
      },
    );
  }
}

