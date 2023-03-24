import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ChooseLanguageBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    final List<MenuModel> _menuList = [
      MenuModel(icon: Images.profile, title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
      MenuModel(icon: Images.customerCare, title: 'help_&_support'.tr, route: RouteHelper.getSupportRoute()),
    ];

    _menuList.add(MenuModel(icon: Images.logout, title: _isLoggedIn ? 'logout'.tr : 'sign_in'.tr, route: ''));

    return PointerInterceptor(
      child: GetBuilder<LocalizationController>(
        builder: (localizationController){
          return Container(
            width: Dimensions.WEB_MAX_WIDTH,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Theme.of(context).cardColor,
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              InkWell(
                onTap: () => Get.back(),
                child: Icon(Icons.keyboard_arrow_down_rounded, size: 30),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  Text("select_language".tr,style: ubuntuMedium.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeDefault),),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.isDesktop(context) ? 4 : ResponsiveHelper.isTab(context) ? 3 : 2,
                      childAspectRatio: (1/1),
                    ),
                    itemCount: localizationController.languages.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => LanguageWidget(
                      languageModel: localizationController.languages[index],
                      localizationController: localizationController, index: index,
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                ],
              ),
              SizedBox(height: ResponsiveHelper.isMobile(context) ? Dimensions.PADDING_SIZE_SMALL : 0),
            ]),
          );
        },
      ),
    );
  }
}
