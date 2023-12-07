import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/helper/decorated_tab_bar.dart';
import 'package:demandium/feature/profile/controller/edit_profile_tab_controller.dart';
import 'package:demandium/feature/profile/view/account_info.dart';
import 'package:demandium/feature/profile/view/edit_profile_general_info.dart';
import 'package:demandium/core/core_export.dart';

class EditProfileScreen extends GetView<EditProfileTabController> {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(
        title: 'edit_profile'.tr,
        centerTitle: true,
        bgColor: Theme.of(context).primaryColor,
        isBackButtonExist: true,
      ),
      body: FooterBaseView(
        isScrollView: ResponsiveHelper.isMobile(context) ? false : true,
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: WebShadowWrap(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  if(!ResponsiveHelper.isMobile(context))
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                  DecoratedTabBar(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.primary.withOpacity(.3),
                          width: 1.0,
                        ),
                      ),
                    ),
                    tabBar: TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(text: 'general_info'.tr),
                        Tab(text: 'account_information'.tr),
                      ],
                      onTap: (int index) {
                        switch (index) {
                          case 0:
                            Get.find<EditProfileTabController>().updateEditProfilePage(EditProfileTabControllerState.generalInfo,index);
                            break;
                          case 1:
                            Get.find<EditProfileTabController>().updateEditProfilePage(EditProfileTabControllerState.accountIno,index);
                            break;
                        }
                      },

                    ),
                  ),
                  if(!ResponsiveHelper.isMobile(context))
                    GetBuilder<EditProfileTabController>(builder: (editProfileTabController){
                      return  editProfileTabController.editProfilePageCurrentState == EditProfileTabControllerState.generalInfo?
                      const EditProfileGeneralInfo():const EditProfileAccountInfo();
                    }),
                  if(ResponsiveHelper.isMobile(context))
                    const Expanded(child: TabBarView(
                      children: [
                        EditProfileGeneralInfo(),
                        EditProfileAccountInfo(),
                      ],
                    ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
