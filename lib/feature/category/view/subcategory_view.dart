import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/category/view/sub_category_widget.dart';

class SubCategoryView extends GetView<CategoryController> {
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  final int? shimmerLength;
  final String? noDataText;
  final String? type;
  final Function(String type)? onVegFilterTap;
  SubCategoryView({
    this.isScrollable = false,
    this.shimmerLength = 20,
    this.padding = const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    this.noDataText, this.type,
    this.onVegFilterTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
     builder: (categoryController){
       if(categoryController.subCategoryList == null){
         return  SliverGrid(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
             mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_DEFAULT : Dimensions.PADDING_SIZE_SMALL,
             crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 3,
             mainAxisExtent: ResponsiveHelper.isMobile(context) ? 115 : 120,
           ),
           delegate: SliverChildBuilderDelegate((context, index) {
               return SubCategoryShimmer(isEnabled: true, hasDivider: index != shimmerLength!-1);
             },
             childCount: 6,
           ),
         );
       }else{
         List<CategoryModel> subCategoryList = categoryController.subCategoryList ?? [];
         return subCategoryList.length > 0 ? SliverGrid(
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisSpacing:ResponsiveHelper.isTab(context) ? 0.0 : Dimensions.PADDING_SIZE_SMALL,
             mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_DEFAULT : Dimensions.PADDING_SIZE_SMALL,
             crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 3,
             mainAxisExtent: ResponsiveHelper.isMobile(context) ? 118 : 120,
           ),
           delegate: SliverChildBuilderDelegate((context, index) {
             return SubCategoryWidget(categoryModel: subCategoryList[index]);
             },
             childCount: subCategoryList.length,
           ),
         ):
         SliverToBoxAdapter(
           child: Container(
             height: Get.height / 1.5,
             child: NoDataScreen(
               text: noDataText != null ? noDataText : 'no_category_found'.tr,
               type: NoDataType.CATEGORY_SUBCATEGORY,
             ),
           ),
         );
       }
     },
    );
  }
}


class SubCategoryShimmer extends StatelessWidget {
  final bool? isEnabled;
  final bool? hasDivider;
  SubCategoryShimmer({required this.isEnabled, required this.hasDivider});

  @override
  Widget build(BuildContext context) {
    bool _desktop = ResponsiveHelper.isDesktop(context);

    return Container(
      padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL)
          : EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Get.isDarkMode?Colors.grey[700]:Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        boxShadow: Get.isDarkMode? null: [BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
      ),
      child: Shimmer(
        duration: Duration(seconds: 2),
        enabled: isEnabled!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: _desktop ? 70 : 50,
                  width: _desktop ? 70 : 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT)
                  ),
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                Expanded(
                  flex: 5,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      height: _desktop ? 20 : 20,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)
                      ),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Container(
                      height: _desktop ? 12 : 8,
                      margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)
                      ),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Container(
                      height: _desktop ? 12 : 8,
                      margin: EdgeInsets.only(right: 100),
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

