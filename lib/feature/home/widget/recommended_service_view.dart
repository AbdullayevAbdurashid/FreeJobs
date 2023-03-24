import 'package:get/get.dart';
import 'package:demandium/feature/home/web/web_recommended_service_view.dart';
import 'package:demandium/core/core_export.dart';

class RecommendedServiceView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    return GetBuilder<ServiceController>(
      builder: (serviceController){
        if(serviceController.recommendedServiceList != null && serviceController.recommendedServiceList!.length == 0){
          return SizedBox();
        }else{
          if(serviceController.recommendedServiceList != null){
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 15, Dimensions.PADDING_SIZE_DEFAULT,  Dimensions.PADDING_SIZE_SMALL,),
                  child: TitleWidget(
                    title: 'recommended_for_you'.tr,
                    onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("fromRecommendedScreen")),
                  ),
                ),
                SizedBox(
                    height: 115,
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                      itemCount: serviceController.recommendedServiceList!.length > 10 ? 10 : serviceController.recommendedServiceList!.length,
                      itemBuilder: (context, index){
                        Discount _discountValue =  PriceConverter.discountCalculation(serviceController.recommendedServiceList![index]);
                        return Padding(
                          padding: EdgeInsets.fromLTRB(2, 2, Dimensions.PADDING_SIZE_SMALL, 2),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                RouteHelper.getServiceRoute(serviceController.recommendedServiceList![index].id!),
                                arguments: ServiceDetailsScreen(serviceID: serviceController.recommendedServiceList![index].id!),
                              );
                            },
                            child: Container(
                              height: 110, width: MediaQuery.of(context).size.width/1.20,
                              child: ServiceModelView(
                                serviceList: serviceController.recommendedServiceList!,
                                discountAmountType: _discountValue.discountAmountType,
                                discountAmount: _discountValue.discountAmount,
                                index: index,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                ),
              ],
            );
          }else{
            return SizedBox(
                height: 110,
                child: RecommendedServiceShimmer(enabled: true));
          }
        }
      },
    );
  }
}

class RecommendedServiceShimmer extends StatelessWidget {
  final bool enabled;
  RecommendedServiceShimmer({required this.enabled});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL,left: Dimensions.PADDING_SIZE_SMALL,top: Dimensions.PADDING_SIZE_SMALL,),
      itemCount: 10,
      itemBuilder: (context, index){
        return Container(
          height: 90, width: 200,
          margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          decoration: BoxDecoration(
            color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: cardShadow,
          ),
          child: Shimmer(
            duration: Duration(seconds: 1),
            interval: Duration(seconds: 1),
            enabled: enabled,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 70, width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(height: 15, width: 100, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),
                    SizedBox(height: 5),
                    Container(height: 10, width: 130, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]),
                    SizedBox(height: 5),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(height: 10, width: 30, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),
                      RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                    ]),
                  ]),
                ),
              ),

            ]),
          ),
        );
      },
    );
  }
}