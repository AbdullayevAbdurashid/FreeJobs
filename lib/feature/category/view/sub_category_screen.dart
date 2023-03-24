import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatefulWidget {
  final String categoryTitle;
  final String categoryID;
  final int subCategoryIndex;
  const SubCategoryScreen({
    Key? key,
    required this.categoryTitle,
    required this.categoryID,
    required this.subCategoryIndex,
  }) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
        appBar: CustomAppBar(title: widget.categoryTitle,),
      body: GetBuilder<CategoryController>(
        initState: (state){
          Get.find<CategoryController>().getSubCategoryList(widget.categoryID, widget.subCategoryIndex,shouldUpdate: false); //banner id is category here

        },
        builder: (categoryController){

          return FooterBaseView(
            isCenter: (categoryController.subCategoryList != null &&  categoryController.subCategoryList!.length == 0),
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: CustomScrollView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(height:
                    ResponsiveHelper.isDesktop(context)?Dimensions.PADDING_SIZE_EXTRA_LARGE:0,
                    ),
                  ),
                  SubCategoryView(isScrollable: true,),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}
