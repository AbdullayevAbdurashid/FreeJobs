import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class SettingScreen extends StatelessWidget {

   SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> settingsItems = [

      Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow:Get.isDarkMode ? null: cardShadow,
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL))
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetBuilder<ThemeController>(builder: (themeController){
                return CupertinoSwitch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    value: themeController.darkTheme, onChanged: (value){
                  themeController.toggleTheme();
                });
              }),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              Text(Get.isDarkMode ? "light_mode".tr:"dark_mode".tr ,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge),),
            ],
          ),
        ),),
      Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow:Get.isDarkMode ? null: cardShadow,
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL))
        ),
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<AuthController>(builder: (authController){
                return CupertinoSwitch(
                  activeColor: Theme.of(context).colorScheme.primary,
                    value: authController.isNotificationActive(), onChanged: (value){
                  authController.toggleNotificationSound();
                });
              }),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              Text(
                'notification_sound'.tr,
                style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                textAlign: TextAlign.center,

              ),
            ],
          ),
        ),),
      InkWell(
        onTap: (){
          Get.toNamed(RouteHelper.getLanguageScreen('fromSettingsPage'));
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow:Get.isDarkMode ? null: cardShadow,
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL))
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(Images.translate,width: 40,height: 40,),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                    Text('language'.tr,style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge),),
                  ],
                ),
              ),),
            Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Image.asset(Images.editPen,
                width: Dimensions.EDIT_ICON_SIZE,
                height: Dimensions.EDIT_ICON_SIZE,
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(
        isBackButtonExist: true,
        bgColor: Theme.of(context).primaryColor, title: 'settings'.tr,),

      body: FooterBaseView(
        isScrollView:true,
        //isCenter:false,
        child: SizedBox(
          width: Dimensions.WEB_MAX_WIDTH,
          child: GridView.builder(
            shrinkWrap: true,
            key: UniqueKey(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE ,
              mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_LARGE ,
              childAspectRatio: 1,
              crossAxisCount: ResponsiveHelper.isDesktop(context) ? 4 : ResponsiveHelper.isTab(context) ? 3 : 2,
            ),
            physics:  NeverScrollableScrollPhysics(),
            itemCount: settingsItems.length,
            padding: EdgeInsets.only(top: 50 ,right: Dimensions.PADDING_SIZE_DEFAULT,left: Dimensions.PADDING_SIZE_DEFAULT,bottom: Dimensions.PADDING_SIZE_DEFAULT),
            itemBuilder: (context, index) {
              return settingsItems.elementAt(index);
            },
          ),
        ),
      ),
    );
  }

}
