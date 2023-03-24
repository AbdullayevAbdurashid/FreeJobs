import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class SubCategoryWidget extends GetView<ServiceController> {
  final CategoryModel? categoryModel;
  SubCategoryWidget({required this.categoryModel,});

  @override
  Widget build(BuildContext context) {
    bool _desktop = ResponsiveHelper.isDesktop(context);

    return InkWell(
      onTap: () {
        Get.find<ServiceController>().cleanSubCategory();
        Get.toNamed(RouteHelper.allServiceScreenRoute("${categoryModel!.id!.toString()}"));
      },

      child: Container(
        margin: EdgeInsets.symmetric(horizontal:ResponsiveHelper.isDesktop(context)?0: Dimensions.PADDING_SIZE_DEFAULT),
        padding: EdgeInsets.all(
            Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            color: Theme.of(context).cardColor,
            boxShadow: Get.isDarkMode ? null: cardShadow
        ),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            child: CustomImage(
              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/category/${categoryModel!.image}',
              height: _desktop ? 120 : 78, width: _desktop ? 120 : 78, fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(children: [
                  Expanded(child: Text(
                    categoryModel!.name!,
                    style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                    maxLines: _desktop ? 1 : 1, overflow: TextOverflow.ellipsis,
                  )),
                ]),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text(
                  categoryModel!.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: ubuntuRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                Text(
                  "${categoryModel!.serviceCount} ${'services'.tr} ",
                  style: ubuntuRegular.copyWith(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
