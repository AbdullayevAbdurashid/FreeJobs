import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/core/core_export.dart';

class CategoryScreen extends StatefulWidget {
   final String fromPage;
   final String campaignID;

  const CategoryScreen({Key? key, required this.fromPage, required this.campaignID}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel>? categoryList;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(title: 'categories'.tr),
      body: SafeArea(
          child: Scrollbar(
              child: widget.fromPage == 'fromCampaign' ?
              GetBuilder<CategoryController>(
                initState: (state){
                  Get.find<CategoryController>().getCampaignBasedCategoryList(widget.campaignID,false);
                },
                  builder: (categoryController) {
                    return _buildBody(categoryController.campaignBasedCategoryList);
                  }) :
              GetBuilder<CategoryController>(
                  initState: (state){
                    Get.find<CategoryController>().getCategoryList(1,false);
                  },
                  builder: (categoryController) {
                    return _buildBody(categoryController.categoryList);
                  }))),
    );
  }

  Widget _buildBody(List<CategoryModel>? categoryList){
     if(categoryList != null && categoryList.length == 0){
      return FooterBaseView(
          isCenter: true,
          child: NoDataScreen(
              type: NoDataType.CATEGORY_SUBCATEGORY,
              text: 'no_category_found'.tr));
    }else{
      if(categoryList != null){
        return FooterBaseView(
          child: SizedBox(
            width: Dimensions.WEB_MAX_WIDTH,
            child: SingleChildScrollView(
              controller: Get.find<CategoryController>().scrollController,
              child: Column(
                children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.isDesktop(context) ? 6 : ResponsiveHelper.isTab(context) ? 4 : 3,
                      childAspectRatio: (1 / 1),
                      mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                      crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                      mainAxisExtent: 120,
                    ),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    itemCount: categoryList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if(widget.fromPage == 'fromCampaign'){
                            Get.find<CategoryController>().getSubCategoryList(categoryList[index].id!,index); //banner id is category here
                            Get.toNamed(RouteHelper.subCategoryScreenRoute(categoryList[index].name!,categoryList[index].id!,index));
                          }else{
                            Get.toNamed(RouteHelper.getCategoryProductRoute(categoryList[index].id!, categoryList[index].name!,index.toString()));
                          }
                        },

                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                              boxShadow:Get.isDarkMode ? null: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200]!, blurRadius: 5, spreadRadius: 1)]),
                          alignment: Alignment.center,
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                  child: CustomImage(height: 50, width: 50, fit: BoxFit.cover,
                                    image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/category/${categoryList[index].image}',
                                  ),
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Padding(
                                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                                  child: Text(categoryList[index].name!,
                                    textAlign: TextAlign.center,
                                    style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }else{
        return Center(child: CircularProgressIndicator());
      }
    }
  }
}
