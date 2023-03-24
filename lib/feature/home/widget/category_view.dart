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
                              color:Get.isDarkMode ?Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6) : Theme.of(context).colorScheme.primary,
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
            if(fromHomeScreen!)SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
            if(fromHomeScreen!)Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT,)),
                ),
              ),
                Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT,)),
                  ),
                )
            ],),
            if(fromHomeScreen!)SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  decoration: BoxDecoration(
                      color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT))),
                  margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                  child: Shimmer(
                    duration: Duration(seconds: 2),
                    enabled: true,
                    child: Row(children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      Container( color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),
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
