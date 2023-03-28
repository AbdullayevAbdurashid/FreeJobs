import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? backButton;
  SearchAppBar({this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? WebMenuBar() :  AppBar(
      title: Container(
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Theme.of(context).cardColor.withOpacity(0.0):Theme.of(context).primaryColor,
          border: Border(
              bottom: BorderSide(
                  width: .4,
                  color: Theme.of(context).primaryColorLight.withOpacity(.2))),
        ),
        child: SearchWidget(),
      ),
      titleSpacing: 0,
      leading:  IconButton(
        icon: Icon(Icons.arrow_back_ios,),
        color: Theme.of(context).primaryColorLight,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
  @override
  Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH, ResponsiveHelper.isDesktop(Get.context) ? Dimensions.PREFERRED_SIZE_WHEN_DESKTOP : Dimensions.PREFERRED_SIZE );
}