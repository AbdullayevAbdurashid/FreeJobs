import 'package:demandium/components/service_center_dialog.dart';
import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class ServiceInformationCard extends StatelessWidget {
  final Discount? discount;
  final Service service;
  final double lowestPrice;
  const ServiceInformationCard({Key? key, required this.discount, required this.service, required this.lowestPrice,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceDetailsController>(builder: (serviceController){
      return Center(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT ,vertical:Dimensions.PADDING_SIZE_DEFAULT),
          child: Container(
            height: 150,
            width: Dimensions.WEB_MAX_WIDTH,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              // border: Border.all(color: Theme.of(context).colorScheme.primary),
              color:Get.isDarkMode ? Theme.of(context).primaryColorDark:Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
              boxShadow: cardShadow,
            ),
            child:
            Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          child: CustomImage(
                            image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.thumbnail}',
                            fit: BoxFit.cover,
                            placeholder: Images.placeholder,
                            height:ResponsiveHelper.isMobile(context) ? Dimensions.IMAGE_SIZE_LARGE :Dimensions.IMAGE_SIZE_MEDIUM,
                            width:ResponsiveHelper.isMobile(context) ? Dimensions.IMAGE_SIZE_MEDIUM: Dimensions.IMAGE_SIZE_MEDIUM,
                          ),
                        ),
                        DiscountTag(fromTop: 0,
                            color: Theme.of(context).errorColor,
                            discount: discount!.discountAmount!,
                            discountType: discount!.discountAmountType)
                      ],
                    ),
                    //SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                    if(ResponsiveHelper.isMobile(context))
                    Row(
                      children: [
                        SizedBox(height: 25,
                          child: Row(
                            children: [
                              Gaps.horizontalGapOf(3),
                              Image(image: AssetImage(Images.starIcon)),
                              Gaps.horizontalGapOf(5),
                              Text(
                                  service.avgRating!.toStringAsFixed(2),
                                  style: ubuntuBold.copyWith(color: Theme.of(context).colorScheme.secondary)),
                            ],
                          ),
                        ),
                        Gaps.horizontalGapOf(5),
                        Text(
                            "(${service.ratingCount})",
                            style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)))
                      ],
                    ),
                  ],
                ),
                //description price and add to card
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !ResponsiveHelper.isMobile(context)?
                            Row(
                              children: [
                                SizedBox(height: 25,
                                  child: Row(
                                    children: [
                                      Gaps.horizontalGapOf(3),
                                      Image(image: AssetImage(Images.starIcon)),
                                      Gaps.horizontalGapOf(5),
                                      Text(
                                          service.avgRating!.toStringAsFixed(2),
                                          style: ubuntuBold.copyWith(color: Theme.of(context).colorScheme.secondary)),
                                    ],
                                  ),
                                ),
                                Gaps.horizontalGapOf(5),
                                Text(
                                    "(${service.ratingCount})",
                                    style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)))
                              ],
                            ):SizedBox(),

                          if(ResponsiveHelper.isWeb())
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                          Row(
                            children: [
                              //price with discount
                              if(discount!.discountAmount! > 0)
                                Padding(
                                  padding:  EdgeInsets.only(left: Get.find<LocalizationController>().isLtr ?  0.0 : Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: Text(PriceConverter.convertPrice(lowestPrice,isShowLongPrice: true),
                                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                                        decoration: TextDecoration.lineThrough,
                                        color: Theme.of(context).errorColor.withOpacity(.8)),
                                  ),
                                ),
                              discount!.discountAmount! > 0 ?
                              Padding(
                                padding:  EdgeInsets.only(left: Get.find<LocalizationController>().isLtr ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0.0),
                                child: Text(PriceConverter.convertPrice(
                                  lowestPrice,
                                  discount: discount!.discountAmount!.toDouble(),
                                  discountType: discount!.discountAmountType,
                                  isShowLongPrice:true,
                                ),
                                  style: ubuntuRegular.copyWith(fontSize: Dimensions.PADDING_SIZE_DEFAULT, color:Get.isDarkMode ? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor),
                                ),
                              ): Text(
                                PriceConverter.convertPrice(double.parse(lowestPrice.toString())),
                                style: ubuntuRegular.copyWith(
                                    fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                                    color: Get.isDarkMode? Theme.of(context).primaryColorLight: Theme.of(context).primaryColor
                                ),
                              ),
                            ],
                          )

                        ],
                      ),

                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              serviceController.service!.shortDescription!,
                              textAlign: TextAlign.start, maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: ubuntuRegular.copyWith(
                                  fontSize: 14.0,
                                  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)
                              ),),
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  useRootNavigator: true,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => ServiceCenterDialog(service: service, isFromDetails: true,)
                              );
                            },
                            child: Text("add".tr+' +',style: ubuntuRegular.copyWith(color: Colors.white),),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
