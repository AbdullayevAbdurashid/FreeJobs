import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class LanguageScreen extends StatefulWidget {
  final String fromPage;

  const LanguageScreen({Key? key, required this.fromPage}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Get.find<LocalizationController>().setSelectIndex(Get.find<LocalizationController>().isLtr ? 0: 1,shouldUpdate: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    final List<MenuModel> _menuList = [
      MenuModel(icon: Images.profile, title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
      MenuModel(icon: Images.customerCare, title: 'help_&_support'.tr, route: RouteHelper.getSupportRoute()),
    ];
    _menuList.add(MenuModel(icon: Images.logout, title: _isLoggedIn ? 'logout'.tr : 'sign_in'.tr, route: ''));

    return Scaffold(

      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar:widget.fromPage != "fromOthers" ? CustomAppBar(title: "language".tr) : null,
      body: GetBuilder<LocalizationController>(
        builder: (localizationController){
          return FooterBaseView(
            isScrollView: (ResponsiveHelper.isMobile(context) || ResponsiveHelper.isTab(context)) ? false: true,
            isCenter: true,
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Stack(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                        right: Dimensions.PADDING_SIZE_DEFAULT,
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        bottom:(ResponsiveHelper.isMobile(context) || ResponsiveHelper.isTab(context)) ?Dimensions.PADDING_SIZE_DEFAULT: 80.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(widget.fromPage != "fromSettingsPage")
                          Image.asset(
                            Images.logo,
                            width: Dimensions.LOGO_SIZE,
                          ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE),
                        Align(
                            alignment:Get.find<LocalizationController>().isLtr ?  Alignment.centerLeft : Alignment.centerRight,
                            child: Text('select_language'.tr,style: ubuntuMedium,)),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                        GridView.builder(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_RADIUS),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: ResponsiveHelper.isDesktop(context) ? 4 : ResponsiveHelper.isTab(context) ? 4 : 2,
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
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        Align(
                            alignment:Get.find<LocalizationController>().isLtr ?  Alignment.centerLeft : Alignment.centerRight,
                            child: Text('you_can_change_language'.tr,style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5)),)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: Dimensions.PADDING_SIZE_DEFAULT,
                    left: Dimensions.PADDING_SIZE_DEFAULT,
                    right: Dimensions.PADDING_SIZE_DEFAULT,
                    child: SafeArea(
                      child: CustomButton(
                          onPressed: (){
                            Get.find<SplashController>().saveSplashSeenValue(true);
                            localizationController.setLanguage(Locale(
                              AppConstants.languages[localizationController.selectedIndex].languageCode!,
                              AppConstants.languages[localizationController.selectedIndex].countryCode,)
                            );
                            if(widget.fromPage == 'fromOthers' ){
                              Get.offNamed(RouteHelper.onBoardScreen);
                            }else if(widget.fromPage == 'menuDrawer' || widget.fromPage == 'fromSettingsPage'){
                              Navigator.pop(context);
                            }
                          },
                          buttonText: 'save'.tr),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}