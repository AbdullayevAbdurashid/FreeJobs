import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/core/core_export.dart';


class SearchResultScreen extends StatefulWidget {
  final String? queryText;

  const SearchResultScreen({Key? key, required this.queryText}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {

  @override
  void initState() {
    Get.find<SearchController>().removeService();
    if(widget.queryText!.length > 0){
      Get.find<SearchController>().searchData(widget.queryText!, shouldUpdate: false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: SearchAppBar(backButton: true),
      body: GetBuilder<SearchController>(

        builder: (searchController){
          return FooterBaseView(
              isCenter: searchController.isSearchComplete &&  ( searchController.searchServiceList == null || searchController.searchServiceList!.length == 0) ? true:false,
              child: searchController.searchServiceList == null ?
              Center(
                child: SizedBox(
                  width: Dimensions.WEB_MAX_WIDTH,
                  child: GridView.builder(
                    key: UniqueKey(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                      mainAxisSpacing:  Dimensions.PADDING_SIZE_DEFAULT,
                      childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? 1 : .70,
                      crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap:  true,
                    itemCount: 15,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    itemBuilder: (context, index) {
                      return ServiceShimmer(isEnabled: true, hasDivider: true,);
                    },
                  ),
                ),
              ) :
              ItemView());
        },
      ),
    );
  }
}
