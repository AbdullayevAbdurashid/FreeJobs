import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/feature/home/widget/category_view.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CategorySubCategoryScreen extends StatefulWidget {
  final String categoryID;
  final String categoryName;
  final String subCategoryIndex;
   CategorySubCategoryScreen({Key? key, required this.categoryID, required this.categoryName, required this.subCategoryIndex}) : super(key: key);

  @override
  State<CategorySubCategoryScreen> createState() => _CategorySubCategoryScreenState();
}

class _CategorySubCategoryScreenState extends State<CategorySubCategoryScreen> {
  ScrollController scrollController = ScrollController();
  String? subCategoryIndex;

  @override
  void initState() {
    Get.find<CategoryController>().getCategoryList(1,false);
    subCategoryIndex = widget.subCategoryIndex;
    Get.find<CategoryController>().getSubCategoryList(
      widget.categoryID,
      int.parse(widget.subCategoryIndex),
      shouldUpdate: false
    );
    if(!ResponsiveHelper.isWeb())
    moved();
    super.initState();
  }

  moved()async{
    Future.delayed(Duration(seconds: 1), () {
      try{
        Scrollable.ensureVisible(
          Get.find<CategoryController>().categoryList!.elementAt(int.parse(subCategoryIndex!)).globalKey!.currentContext!,
          duration: Duration(seconds: 1),
        );
      }catch(e){}
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
        builder: (categoryController) {
          return Scaffold(
            endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
            appBar: CustomAppBar(title: 'available_service'.tr,),
            body: FooterBaseView(
              child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: CustomScrollView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(child: SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),),
                    SliverToBoxAdapter(
                      child: (categoryController.categoryList != null && !categoryController.isSearching!) ?
                      Center(
                        child: Container(
                          height:ResponsiveHelper.isDesktop(context) ? 150 : ResponsiveHelper.isTab(context)? 140 : 130,
                          margin: EdgeInsets.only(
                              left: ResponsiveHelper.isDesktop(context)? 0 : Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          width: Dimensions.WEB_MAX_WIDTH,
                          padding: EdgeInsets.only(
                              bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              top: Dimensions.PADDING_SIZE_DEFAULT
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryController.categoryList!.length,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                              left: ResponsiveHelper.isDesktop(context)?0: Dimensions.PADDING_SIZE_SMALL,
                              right: ResponsiveHelper.isDesktop(context)?0: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            itemBuilder: (context, index) {
                              CategoryModel categoryModel = categoryController.categoryList!.elementAt(index);
                              return InkWell(
                                key:!ResponsiveHelper.isWeb() ?  categoryModel.globalKey: null,
                                onTap: () {
                                  subCategoryIndex = index.toString();
                                  Get.find<CategoryController>().getSubCategoryList(categoryModel.id!, index);
                                },
                                hoverColor: Colors.transparent,
                                child: Container(
                                  width: ResponsiveHelper.isDesktop(context) ? 150 : ResponsiveHelper.isTab(context)?140 :100,

                                  margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  decoration: BoxDecoration(
                                    color: index != int.parse(subCategoryIndex!) ? Theme.of(context).primaryColorLight : Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT), ),
                                  ),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                                          child: CustomImage(
                                            fit: BoxFit.cover,
                                            height: ResponsiveHelper.isDesktop(context) ? 50 : ResponsiveHelper.isTab(context)?40 :30,
                                            width: ResponsiveHelper.isDesktop(context) ? 50 : ResponsiveHelper.isTab(context)?40 :30,
                                            image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}'
                                                '/category/${categoryController.categoryList![index].image}',
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                          child: Text(categoryController.categoryList![index].name!,
                                            style: ubuntuRegular.copyWith(
                                              fontSize: Dimensions.fontSizeSmall,
                                              color:index==int.parse(subCategoryIndex!)? Colors.white:Colors.black
                                            ),
                                            maxLines: 2,textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ]),
                                ),
                              );
                            },
                          ),
                        ),
                      ) : ResponsiveHelper.isDesktop(context)?
                      WebCategoryShimmer(
                        categoryController: categoryController,
                        fromHomeScreen: false,
                      ):SizedBox(),
                    ),
                    SliverToBoxAdapter(
                        child: Container(width: Dimensions.WEB_MAX_WIDTH,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE),
                                child: Center(
                                  child: Text(
                                    'sub_categories'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                                      color:Get.isDarkMode ? Colors.white:Theme.of(context).colorScheme.primary),
                                  ),
                                ),
                            ),
                        ),
                    ),
                    SubCategoryView(
                      noDataText: "no_subcategory_found".tr,
                      isScrollable: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
