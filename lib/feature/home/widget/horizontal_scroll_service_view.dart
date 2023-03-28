import 'package:get/get.dart';
import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/components/service_center_dialog.dart';
import 'package:demandium/core/core_export.dart';

class HorizontalScrollServiceView extends GetView<ServiceController> {
  final String? fromPage;
  final List<Service>? serviceList;
  HorizontalScrollServiceView({required this.fromPage,required this.serviceList});
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    if(serviceList != null && serviceList!.length == 0){
      return SizedBox();
    }else{
      if(serviceList!= null){
        return Stack(
          children: [
            if(fromPage=='recently_view_services')
            ClipPath(
              clipper: TsClip2(),
              child: Container(
                width: double.infinity,
                height: 200,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.PADDING_SIZE_SMALL,
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),
                    child: TitleWidget(
                      title: fromPage!,
                      onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute(fromPage!)),
                    ),
                  ),
                  SizedBox(
                    height: Get.find<LocalizationController>().isLtr ?ResponsiveHelper.isMobile(context) ? 260 :270 :  270,
                    child:ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      itemCount: serviceList!.length > 10 ? 10 : serviceList!.length,
                      itemBuilder: (context, index){
                        controller.getServiceDiscount(serviceList![index]);
                        Discount _discountModel =  PriceConverter.discountCalculation(serviceList![index]);
                        Service service = serviceList!.elementAt(index);
                        double _lowestPrice = 0.0;
                        if(service.variationsAppFormat!.zoneWiseVariations != null){
                          _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
                          for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
                            if (service.variationsAppFormat!.zoneWiseVariations![i].price! < _lowestPrice) {
                              _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
                            }
                          }
                        }
                        return Padding(
                          padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Stack(
                            alignment:Get.find<LocalizationController>().isLtr ?  Alignment.bottomRight : Alignment.bottomLeft,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: Get.width / 2.3,
                                    decoration: BoxDecoration(
                                        color:  Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                        boxShadow:Get.isDarkMode ?null: cardShadow
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            //image and service name
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL)),
                                                      child: CustomImage(
                                                        image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.thumbnail}',
                                                        fit: BoxFit.cover,
                                                        width: MediaQuery.of(context).size.width/2.5,
                                                        height: 135,
                                                      ),
                                                    ),
                                                    _discountModel.discountAmount! > 0 ?
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Container(
                                                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                        decoration: BoxDecoration(
                                                          color: Theme.of(context).colorScheme.error,
                                                          borderRadius: BorderRadius.only(
                                                            bottomRight: Radius.circular(Dimensions.RADIUS_DEFAULT),
                                                            topLeft: Radius.circular(Dimensions.RADIUS_SMALL),
                                                          ),
                                                        ),
                                                        child: Directionality(
                                                          textDirection: TextDirection.rtl,
                                                          child: Text(
                                                            PriceConverter.percentageOrAmount('${_discountModel.discountAmount}','${_discountModel.discountAmountType}'),
                                                            style: ubuntuRegular.copyWith(color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ):
                                                    SizedBox(),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EIGHT),
                                                  child: Text(
                                                      service.name!,
                                                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                                                      maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,

                                                children: [
                                                  SizedBox(height:ResponsiveHelper.isMobile(context) ? Dimensions.PADDING_SIZE_MINI: Dimensions.PADDING_SIZE_EIGHT,),
                                                  Text(
                                                    'starts_from'.tr,
                                                    style:  ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                      if(_discountModel.discountAmount! > 0)
                                                        Directionality(
                                                          textDirection: TextDirection.ltr,
                                                          child: Text(
                                                            PriceConverter.convertPrice(_lowestPrice),
                                                            style: ubuntuRegular.copyWith(
                                                                fontSize: Dimensions.fontSizeSmall,
                                                                decoration: TextDecoration.lineThrough,
                                                                color: Theme.of(context).colorScheme.error.withOpacity(.8)),
                                                          ),
                                                        ),
                                                      SizedBox(height: Dimensions.PADDING_SIZE_MINI,),
                                                      _discountModel.discountAmount! > 0?
                                                      Directionality(
                                                        textDirection: TextDirection.ltr,
                                                        child: Text(PriceConverter.convertPrice(
                                                            _lowestPrice,
                                                            discount: _discountModel.discountAmount!.toDouble(),
                                                            discountType: _discountModel.discountAmountType
                                                        ),
                                                          style: ubuntuRegular.copyWith(
                                                              fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                                                              color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                                        ),
                                                      ):
                                                      Directionality(
                                                        textDirection: TextDirection.ltr,
                                                        child: Text(
                                                          PriceConverter.convertPrice(_lowestPrice),
                                                          style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ),),
                                  Positioned.fill(
                                    child: RippleButton(
                                      onTap:() => Get.toNamed(RouteHelper.getServiceRoute(service.id!),
                                      ),
                                    ),)
                                ],),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                    child: Icon(
                                        Icons.add,
                                        color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor,
                                        size: Dimensions.PADDING_SIZE_LARGE),
                                  ),
                                  Positioned.fill(
                                    child: RippleButton(
                                      onTap: () {
                                        Get.find<CartController>().resetPreselectedProviderInfo();
                                        showModalBottomSheet(
                                          context: context,
                                          useRootNavigator: true,
                                          isScrollControlled: true,
                                          builder: (context) => ServiceCenterDialog(service: service,),
                                          backgroundColor: Colors.transparent

                                      );},
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ) ,
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,)
                ],
              ),
            ),
          ],
        );
      }
      else{
        return PopularServiceShimmer(enabled: true,);
      }
    }
  }
}


class TsClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height/2);
    path.quadraticBezierTo(
        size.width / 1.3, size.height+70, size.width, size.height/1.3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class PopularServiceShimmer extends StatelessWidget {
  final bool enabled;
  PopularServiceShimmer({required this.enabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL,left: Dimensions.PADDING_SIZE_SMALL,top: Dimensions.PADDING_SIZE_SMALL,),
        itemCount: 10,
        itemBuilder: (context, index){
          return Container(
            height: 80, width: Get.width / 2.3,
            margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL,bottom: 10,top: 10),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              color: Get.isDarkMode? Colors.grey[700]:Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
            ),
            child: Shimmer(
              duration: Duration(seconds: 1),
              interval: Duration(seconds: 1),
              enabled: enabled,
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

                Container(
                  height: 70,
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
                      Container(height: 10, width: 130, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),
                      SizedBox(height: 5),
                      Container(height: 10, width: 130, color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]),

                    ]),
                  ),
                ),

              ]),
            ),
          );
        },
      ),
    );
  }
}

