import 'package:demandium/components/service_view_vertical.dart';
import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';
import 'search_initial_screen.dart';

class ItemView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        builder: (searchController) {
          if(searchController.isSearchComplete){
            return SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                    if(searchController.searchServiceList != null && searchController.searchServiceList!.length > 0)
                      Container(
                        color: Theme.of(context).hoverColor,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical:  Dimensions.PADDING_SIZE_DEFAULT),
                            child: Text(
                              "${searchController.searchServiceList!.length} ${'results_found'.tr}",
                              style: ubuntuRegular.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: Dimensions.fontSizeLarge,),),),),),
                    if(searchController.searchServiceList != null && searchController.searchServiceList!.length > 0)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Text('services'.tr, style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeLarge,),),),
                    ServiceViewVertical(
                      service: searchController.searchServiceList!,
                      noDataText: 'no_service_found'.tr,
                      noDataType: NoDataType.SEARCH,),
                  ],
                ));
          }else{
            return SearchSuggestion();
          }

    });
  }
}
