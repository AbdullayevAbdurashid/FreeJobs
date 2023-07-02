import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class FeatheredCategoryView extends StatefulWidget {
  const FeatheredCategoryView({Key? key}) : super(key: key);

  @override
  State<FeatheredCategoryView> createState() => _FeatheredCategoryViewState();
}

class _FeatheredCategoryViewState extends State<FeatheredCategoryView> {
  @override
  void initState() {
    super.initState();
    Get.find<ServiceController>().getFeatherCategoryList(false);
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(builder: (serviceController){
      return SizedBox(
        height: serviceController.categoryList.length*345,
        child: ListView.builder(itemBuilder: (context,categoryIndex){

          int serviceItemCount;
          serviceItemCount = serviceController.categoryList[categoryIndex].servicesByCategory!.length>5?5
                : serviceController.categoryList[categoryIndex].servicesByCategory!.length;

          return  Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            ),
            margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: EdgeInsets.only(bottom:ResponsiveHelper.isMobile(context)?Dimensions.PADDING_SIZE_SMALL:0,left: 7,right: 7),
                      child: Text(serviceController.categoryList[categoryIndex].name??"", style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.getFeatheredCategoryService(
                            serviceController.categoryList[categoryIndex].name??"", serviceController.categoryList[categoryIndex]));
                      },
                      child: Text('see_all'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                        decoration: TextDecoration.underline,
                        color:Get.isDarkMode ?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6) : Theme.of(context).colorScheme.primary,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 270,
                  width: Get.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: serviceItemCount,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                        child: SizedBox(
                           width: Get.width / 2.3,child: ServiceWidgetVertical(service: serviceController.categoryList[categoryIndex].servicesByCategory![index],
                          isAvailable: true,fromType: '',)
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT)
              ],
            ),
          );
        },itemCount: serviceController.categoryList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
        ),
      );
    });
  }
}