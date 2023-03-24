import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBackButtonExist;
  final Function()? onBackPressed;
  final bool? showCart;
  final bool? centerTitle;
  final Color? bgColor;
  CustomAppBar({required this.title, this.isBackButtonExist = true, this.onBackPressed, this.showCart = false,this.centerTitle = true,this.bgColor});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? WebMenuBar() : AppBar(
      title: Text(title!, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color:  Theme.of(context).primaryColorLight),),
      centerTitle: centerTitle,
      leading: isBackButtonExist! ? IconButton(

        hoverColor:Colors.transparent,
        icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).primaryColorLight),
        color: Theme.of(context).textTheme.bodyText1!.color,
        onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
      ) : SizedBox(),
      backgroundColor:Get.isDarkMode ? Theme.of(context).cardColor.withOpacity(.2):Theme.of(context).primaryColor,
      shape: Border(bottom: BorderSide(
          width: .4,
          color: Theme.of(context).primaryColorLight.withOpacity(.2))),
      elevation: 0,
      actions: showCart! ? [
        IconButton(onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
          icon:  CartWidget(
              color: Get.isDarkMode
                  ? Theme.of(context).primaryColorLight
                  : Colors.white,
              size: Dimensions.CART_WIDGET_SIZE),
        )] : null,
    );
  }
  @override
  Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH, ResponsiveHelper.isDesktop(Get.context) ? Dimensions.PREFERRED_SIZE_WHEN_DESKTOP : Dimensions.PREFERRED_SIZE );
}