import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/feature/search/controller/search_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/images.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentSearch extends StatelessWidget {
  const RecentSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<SearchController>(
      builder: (searchController){
        return searchController.historyListFromServer!=null && searchController.historyListFromServer!.length > 0 ?
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('recent_search'.tr,style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Theme.of(context).colorScheme.primary),),
                InkWell(
                  onTap: (){
                    searchController.removeSuggestedServicesFromServer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Text(
                      'clear_all'.tr,
                      style: ubuntuMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                ),
              ],
            ),

            Wrap(
              direction: Axis.horizontal,
              alignment:WrapAlignment.start,
              children: [
                for (int index =0;index<searchController.historyListFromServer!.length;index++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_RADIUS),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Get.isDarkMode?Colors.grey.withOpacity(0.2): Theme.of(context).primaryColor.withOpacity(0.1)
                        ),
                        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL-3, horizontal: Dimensions.PADDING_SIZE_SMALL,),
                        margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Text(
                                  searchController.historyListFromServer![index].keyword!,
                                  style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5)),
                                ),
                                Positioned.fill(child: RippleButton(onTap: () {
                                  searchController.populatedSearchController(searchController.historyListFromServer![index].keyword!);
                                  searchController.searchData(searchController.historyListFromServer![index].keyword!);
                                }))
                              ],
                            ),
                            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                            InkWell(
                                onTap: (){
                                  searchController.removeSuggestedServicesFromServer(
                                    id: searchController.historyListFromServer![index].id!,
                                    index: index,
                                  );
                                },
                                child: Image.asset(Images.cancel,color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),))
                          ],
                        )),
                  )
              ],
            ),
          ],
        ):
        SizedBox();
      }
    );
  }
}
