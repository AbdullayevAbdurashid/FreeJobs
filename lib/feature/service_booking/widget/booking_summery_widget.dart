import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class BookingSummeryWidget extends StatelessWidget{
  final BookingDetailsContent bookingDetailsContent;
  const BookingSummeryWidget({Key? key, required this.bookingDetailsContent}) : super(key: key);

  @override
  Widget build(BuildContext context){
    double serviceDiscount = 0;
    bookingDetailsContent.detail?.forEach((service) {
      serviceDiscount = serviceDiscount + service.discountAmount!;
    });

    return GetBuilder<BookingDetailsTabsController>(
        builder:(bookingDetailsController){
          if(!bookingDetailsController.isLoading) {
            return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeDefault),
                child: Text(
                    'booking_summery'.tr,
                    style:ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color))
              ),
              Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeEight),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingSizeEight),
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  height: 40,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('service_info'.tr, style:ubuntuBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodyLarge!.color!,decoration: TextDecoration.none)),
                      Text('service_cost'.tr,style:ubuntuBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodyLarge!.color!,decoration: TextDecoration.none)),
                    ],
                  ),
                ),
              ),
              ListView.builder(itemBuilder: (context, index){
                return ServiceInfoItem(
                  bookingDetailsContent: bookingDetailsContent,
                  bookingService : bookingDetailsController.bookingDetailsContent!.detail![index],
                  bookingDetailsController: bookingDetailsController,
                  index: index,
                );
              },
                itemCount: bookingDetailsController.bookingDetailsContent!.detail?.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),

              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Divider(height: 2, color: Colors.grey,),
              ),
              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('sub_total'.tr,
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color,),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        PriceConverter.convertPrice(bookingDetailsController.allTotalCost,isShowLongPrice: true),
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                      ),
                    ),
                  ],
                ),
              ),

              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'service_discount'.tr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color:Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
                        overflow: TextOverflow.ellipsis
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        "(-) ${PriceConverter.convertPrice(serviceDiscount)}",
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color:Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),),
                    ),
                  ],
                ),
              ),
              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'coupon_discount'.tr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
                      overflow: TextOverflow.ellipsis,),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text('(-) ${PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalCouponDiscountAmount!.toDouble())}',
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),),
                    ),
                  ],
                ),
              ),

              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'campaign_discount'.tr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
                      overflow: TextOverflow.ellipsis,),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text('(-) ${PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalCampaignDiscountAmount!.toDouble())}',
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),),
                    ),
                  ],
                ),
              ),

              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'service_vat'.tr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)),
                      overflow: TextOverflow.ellipsis,),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text('(+) ${PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalTaxAmount!.toDouble(),isShowLongPrice: true)}',
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge!.color),),
                    ),
                  ],
                ),
              ),
              // if(bookingDetailsController.bookingDetailsContent?.additionalCharge!=null)
              //   Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text( bookingDetailsController.bookingDetailsContent!.additionalCharge! >= 0 ?"due".tr : "refund".tr, style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
              //             color: Theme.of(context).textTheme.bodyLarge!.color),overflow: TextOverflow.ellipsis,
              //         ),
              //         Text(PriceConverter.convertPrice(
              //             double.tryParse(bookingDetailsController.bookingDetailsContent?.additionalCharge.toString()??"0"),
              //             isShowLongPrice:true),
              //           style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
              //               color: Theme.of(context).textTheme.bodyLarge!.color
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Divider(),
              ),
              Gaps.verticalGapOf(Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'grand_total'.tr,
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                      overflow: TextOverflow.ellipsis,),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalBookingAmount!.toDouble(),isShowLongPrice: true),
                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyLarge!.color),),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.paddingForChattingButton),
            ],
          );
          }
          return const SizedBox();
        });
  }
}


class ServiceInfoItem extends StatelessWidget {
  final BookingDetailsContent bookingDetailsContent;
  final int index;
  final BookingDetailsTabsController bookingDetailsController;
  final BookingContentDetailsItem bookingService;
  const ServiceInfoItem({Key? key,required this.bookingService,required this.bookingDetailsController, required this.index, required this.bookingDetailsContent}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double unitTotalCost = 0;
    try{
      unitTotalCost = bookingDetailsController.unitTotalCost[index];
    }catch(error) {
      if (kDebugMode) {
        print('error : $error');
      }
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.verticalGapOf(Dimensions.paddingSizeDefault),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width / 2,
                      child: Text(bookingService.serviceName != null ?bookingService.serviceName!:'',
                        style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge!.color),
                        overflow: TextOverflow.ellipsis,),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        PriceConverter.convertPrice(unitTotalCost,isShowLongPrice: true),
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge!.color),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                SizedBox(
                  width: Get.width / 1.5,
                  child: Text(bookingService.variantKey??"",
                    style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)
                    ),),
                ),
                Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),
                priceText('unit_price'.tr, bookingService.serviceCost!.toDouble(), context,mainAxisAlignmentStart: true),
                Row(
                  children: [
                    Text('quantity'.tr,
                      style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall,
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)),),
                    Text(" :  ${bookingService.quantity}",style: ubuntuRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                        fontSize: Dimensions.fontSizeExtraSmall),)
                  ],
                ),
                bookingService.discountAmount! > 0 ?
                priceText('discount'.tr,bookingService.discountAmount!.toDouble(), context,mainAxisAlignmentStart: true) : const SizedBox(),
                bookingService.campaignDiscountAmount! > 0 ?
                priceText('campaign'.tr, bookingService.campaignDiscountAmount!.toDouble(), context,mainAxisAlignmentStart: true) : const SizedBox(),
                bookingService.overallCouponDiscountAmount! > 0 ?
                priceText('coupon'.tr, bookingService.overallCouponDiscountAmount!.toDouble(), context,mainAxisAlignmentStart: true) : const SizedBox(),

              ],
            ),
          ],

        ));
  }

}


Widget priceText(String title,double amount,context, {bool mainAxisAlignmentStart = false}){
  return Column(
    children: [
      Row(
        mainAxisAlignment:mainAxisAlignmentStart?MainAxisAlignment.start: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title :   ',
            style: ubuntuRegular.copyWith(
                fontSize: Dimensions.fontSizeExtraSmall,
                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)
            ),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(PriceConverter.convertPrice(amount,isShowLongPrice: true),style: ubuntuRegular.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
              fontSize: Dimensions.fontSizeExtraSmall
            ),),
          )
        ],
      ),
      Gaps.verticalGapOf(Dimensions.paddingSizeMini),
    ],
  );
}
