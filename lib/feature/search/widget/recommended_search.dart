import 'dart:math';

import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class RecommendedSearch extends StatefulWidget {
  const RecommendedSearch({Key? key}) : super(key: key);

  @override
  State<RecommendedSearch> createState() => _RecommendedSearchState();
}

class _RecommendedSearchState extends State<RecommendedSearch> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
      initState: (_){
        Get.find<ServiceController>().getRecommendedSearchList(reload: false);
      },
        builder: (serviceController){
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('recommended_for_you'.tr,style: ubuntuMedium.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).colorScheme.primary),),
                  InkWell(
                    onTap: (){
                      serviceController.getRecommendedSearchList();
                    },
                    child: Row(
                      children: [
                        Text('change'.tr,style: ubuntuMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),
                        ),),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                        Icon(Icons.cached,size: 16,)
                      ],
                    ),
                  )
                ],
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              if(serviceController.isLoading)
                RecommendedSearchShimmer(),


             if(serviceController.recommendedSearchList.length!=0)
               ListView.builder(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemBuilder: (context,index){
                     return Padding(
                       padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                       child: SizedBox(
                         child: InkWell(
                           onTap: (){
                             Get.find<SearchController>().searchData(
                                 serviceController.recommendedSearchList[index].name??''
                             );

                             Get.find<SearchController>().populatedSearchController(
                                 serviceController.recommendedSearchList[index].name??''
                             );
                             Get.find<SearchController>().getSuggestedServicesFromServer();
                           },
                           child: Row(
                             children: [
                               Text(
                                 serviceController.recommendedSearchList[index].name??"",
                                 style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8)),
                               ),
                             ],
                           ),
                         ),
                       ),
                     );
                   },itemCount: serviceController.recommendedSearchList.length),
            ],
          );
    });
  }
}

class RecommendedSearchShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer(
          duration: Duration(seconds: 3),
          interval: Duration(seconds: 5),
          color: Theme.of(context).backgroundColor,
          colorOpacity: 0,
          enabled: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
            child: Padding(
              padding:  EdgeInsets.only(right: Random().nextDouble() * 200),
              child: Container(
                height: 20,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  color: Theme.of(context).shadowColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


