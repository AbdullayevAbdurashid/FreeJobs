import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class AddressAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? backButton;
  AddressAppBar({this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:Get.isDarkMode ? Theme.of(context).cardColor.withOpacity(.2):Theme.of(context).primaryColor,
      shape: Border(
          bottom: BorderSide(
          width: .4,
          color: Theme.of(context).primaryColorLight.withOpacity(.2))),
      elevation: 0, leadingWidth: backButton! ? Dimensions.PADDING_SIZE_LARGE : 0,
      leading: backButton! ? IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Theme.of(context).cardColor,
        onPressed: () => Navigator.pop(context),
      ):
      SizedBox(),
      title: Row(
          children: [
            Expanded(
                child: InkWell(
                  hoverColor: Colors.transparent,
                  onTap: (){
                    Get.toNamed(RouteHelper.getAccessLocationRoute('home'));
                    },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('services_in'.tr, style: ubuntuRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeExtraSmall)),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_SMALL : 0,),
                          child: GetBuilder<LocationController>(builder: (locationController) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if(locationController.getUserAddress() != null)
                                  Flexible(
                                    child: Text(
                                      locationController.getUserAddress()!.address!,
                                      style: ubuntuRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeSmall),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 12),
                  ],
                );
              }),
            ),
                      ],),
                ),
            ),
            InkWell(
                hoverColor: Colors.transparent,
                onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
                child: Icon(Icons.notifications, size: 25, color: Colors.white)),
      ]),
    );
  }

  @override
  Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH, GetPlatform.isDesktop ? 70 :  56);
}