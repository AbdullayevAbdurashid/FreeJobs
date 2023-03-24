import 'package:demandium/components/service_center_dialog.dart';
import 'package:demandium/feature/home/web/web_campaign_view.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class WebPopularServiceView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
      initState: (state){
        Get.find<ServiceController>().getPopularServiceList(1,false);
      },
      builder: (serviceController){
        if(serviceController.popularServiceList != null && serviceController.popularServiceList!.length == 0){
          return SizedBox();
        }else{
          if(serviceController.popularServiceList != null){
            List<Service>? _serviceList = serviceController.popularServiceList;
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('popular_services'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                        InkWell(
                          onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("popular_services")),
                          child: Text('see_all'.tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeDefault,
                            decoration: TextDecoration.underline,
                            color:Get.isDarkMode ?Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6) : Theme.of(context).colorScheme.primary,
                          )),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio:ResponsiveHelper.isMobile(context) ? 0.78:0.89,
                      crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                      mainAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    itemCount: _serviceList!.length > 7 ? 8 : _serviceList.length,
                    itemBuilder: (context, index){
                      Discount _discount = PriceConverter.discountCalculation(serviceController.popularServiceList![index]);
                      return InkWell(
                        onTap: () {
                          //TODO: Product Details
                          Get.toNamed(
                            RouteHelper.getServiceRoute(_serviceList[index].id!),
                            arguments: ServiceDetailsScreen(serviceID: _serviceList[index].id!),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL-2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            boxShadow: Get.isDarkMode ? null: cardShadow,
                          ),
                          child: Column(children: [


                            Expanded(flex: 2,
                              child: SizedBox(
                                width: double.maxFinite,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                      child: CustomImage(
                                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${_serviceList[index].thumbnail}',
                                        fit: BoxFit.cover, width: double.maxFinite
                                      ),
                                    ),

                                    if( _discount.discountAmount != null && _discount.discountAmountType!=null && _discount.discountAmount! > 0) Positioned.fill(
                                      child: Align(alignment: Alignment.topRight,
                                        child: Container(
                                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).errorColor,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT),
                                              topRight: Radius.circular(Dimensions.RADIUS_SMALL),
                                            ),
                                          ),
                                          child: Text(
                                            PriceConverter.percentageOrAmount('${_discount.discountAmount}', _discount.discountAmountType!),
                                            style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 3,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                Text(
                                  _serviceList[index].name!,
                                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                Text(
                                  _serviceList[index].shortDescription!,
                                  style: ubuntuLight.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
                                  maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


                                RatingBar(
                                  rating: double.parse(_serviceList[index].avgRating.toString()), size: 15,
                                  ratingCount: _serviceList[index].ratingCount,
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


                                Row(
                                  children: [
                                    if(_serviceList[index].variationsAppFormat!.defaultPrice != null )
                                      Expanded(flex: 3,
                                        child: Text(
                                          PriceConverter.convertPrice(
                                            double.parse(_serviceList[index].variationsAppFormat!.defaultPrice.toString()),
                                            discount: 2.0, discountType: "DiscountType",
                                          ),
                                          style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
                                          maxLines: 1, overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              useRootNavigator: true,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.transparent,
                                              context: context,
                                              builder: (context) => ServiceCenterDialog(service: _serviceList[index])
                                          );
                                        },
                                        child: Icon
                                          (Icons.add,
                                            color: Get.isDarkMode?light.cardColor: Theme.of(context).primaryColor,
                                            size: Dimensions.PADDING_SIZE_LARGE
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ]),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          }
          else{
            return WebCampaignShimmer(enabled: true,);
          }
        }
      },
    );
  }
}
