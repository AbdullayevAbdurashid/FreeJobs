import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class WebRecentlyServiceView extends StatelessWidget {
  const WebRecentlyServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getRecentlyViewedServiceList(1,false);
        },
        builder: (serviceController){
      if(serviceController.recentlyViewServiceList != null && serviceController.recentlyViewServiceList!.length == 0){
        return SizedBox();
      }else{
        if(serviceController.recentlyViewServiceList != null){
          return  Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('recently_view_services'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                  InkWell(
                    onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("recently_view_services")),
                    child: Text('see_all'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                      decoration: TextDecoration.underline,
                      color:Get.isDarkMode ?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6) : Theme.of(context).colorScheme.primary,
                    )),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
              GridView.builder(
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                  mainAxisSpacing:  Dimensions.PADDING_SIZE_DEFAULT,
                  childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? 0.92 : .70,
                  crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
                ),
                physics:NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: serviceController.recentlyViewServiceList!.length>5?5:serviceController.recentlyViewServiceList!.length,
                itemBuilder: (context, index) {
                  return ServiceWidgetVertical(service: serviceController.recentlyViewServiceList![index],  isAvailable: true,fromType: '',);
                },
              )
            ],
          );
        }
        else{
          return SizedBox();
        }
      }
    });
  }
}
