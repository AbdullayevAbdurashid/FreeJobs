import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CategoryView extends StatelessWidget {
  CategoryView();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(initState: (state) {
      Get.find<CategoryController>().getCategoryList(1,false);
    }, builder: (categoryController) {
      if(categoryController.categoryList != null && categoryController.categoryList!.length == 0){
        return SizedBox() ;
      }else{
        if(categoryController.categoryList != null){
          return Center(
            child: Container(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Padding(
                padding: EdgeInsets.symmetric( vertical:Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('all_categories'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                          InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.getCategoryProductRoute(
                                  categoryController.categoryList![0].id!,
                                  categoryController.categoryList![0].name!,
                                  0.toString()
                              ));
                            },
                            hoverColor: Theme.of(context).primaryColor.withOpacity(0.05),
                            child: Text('see_all'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                              decoration: TextDecoration.underline,
                              color:Get.isDarkMode ?Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6) : Theme.of(context).colorScheme.primary,
                            )),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 6 : 4,
                            crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                            mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                            childAspectRatio: ResponsiveHelper.isDesktop(context) ? 1 : 1,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: categoryController.categoryList!.length > 8 ? 8 : categoryController.categoryList!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.getCategoryProductRoute(
                                categoryController.categoryList![index].id!,
                                categoryController.categoryList![index].name!,
                                index.toString()
                              ));
                            },

                            child: Container(
                              padding: EdgeInsets.only(top : Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              decoration: BoxDecoration(
                                color: Theme.of(context).hoverColor,
                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT), ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                                      child: CustomImage(
                                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/category/${categoryController.categoryList![index].image}',
                                        fit: BoxFit.cover,
                                        height: ResponsiveHelper.isMobile(context)?28:ResponsiveHelper.isTab(context)?40:60,
                                        width: ResponsiveHelper.isMobile(context)?28:ResponsiveHelper.isTab(context)?40:60,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                      child: Text(categoryController.categoryList![index].name!,
                                        style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall),
                                        maxLines: MediaQuery.of(context).size.width<300?1:2,textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ]),
                            ),
                          );
                        },
                      ) ,
                    ]),
              ),
            ),
          );
        }else{
          return WebCategoryShimmer(categoryController: categoryController);
        }
      }
    });
  }
}



class WebCategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  final bool? fromHomeScreen;

  WebCategoryShimmer({required this.categoryController, this.fromHomeScreen=true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Dimensions.WEB_MAX_WIDTH,
        child: Column(
          children: [
            if(fromHomeScreen!)SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
            if(fromHomeScreen!)Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                height: 30,
                width: 100,
                  decoration: BoxDecoration(
                    color: Get.isDarkMode? Colors.grey[700]:Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
                  ),
                child: Center(child: Container(
                  height: ResponsiveHelper.isMobile(context)?10:ResponsiveHelper.isTab(context)?15:20,
                  color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300],
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                ),),
              ),
                Container(
                  height: 30,
                  width: 80,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode? Colors.grey[700]:Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
                    ),
                  child: Center(child: Container(
                    height: ResponsiveHelper.isMobile(context)?10:ResponsiveHelper.isTab(context)?15:20,
                    color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300],
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  ),),
                )
            ],),
            if(fromHomeScreen! && !ResponsiveHelper.isMobile(context))SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                      color: Get.isDarkMode? Colors.grey[700]:Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
                    ),
                  margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                  child: Shimmer(
                    duration: Duration(seconds: 2),
                    enabled: true,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                      Container(
                        height: ResponsiveHelper.isMobile(context)?28:ResponsiveHelper.isTab(context)?40:60,
                        width: ResponsiveHelper.isMobile(context)?28:ResponsiveHelper.isTab(context)?40:60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Container(
                        height: ResponsiveHelper.isMobile(context)?10:ResponsiveHelper.isTab(context)?15:20,
                        color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300],
                        margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                      ),
                    ]),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveHelper.isDesktop(context) ? 8 : ResponsiveHelper.isTab(context) ? 6 : 4,
                  crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                  mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                  childAspectRatio: ResponsiveHelper.isDesktop(context) ? 1 : 0.85,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
