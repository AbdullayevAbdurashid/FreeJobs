import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class BookingSummeryWidget extends StatelessWidget{
  final BookingDetailsContent bookingDetailsContent;
  const BookingSummeryWidget({Key? key, required this.bookingDetailsContent}) : super(key: key);

  @override
  Widget build(BuildContext context){
    double _serviceDiscount = 0;
    bookingDetailsContent.detail?.forEach((service) {
      _serviceDiscount = _serviceDiscount + service.discountAmount!;
    });

    return GetBuilder<BookingDetailsTabsController>(
        builder:(bookingDetailsController){
          if(!bookingDetailsController.isLoading)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                    'booking_summery'.tr,
                    style:ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyText1!.color))
              ),
              Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_RADIUS),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_RADIUS),
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  height: 40,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('service_info'.tr, style:ubuntuBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodyText1!.color!,decoration: TextDecoration.none)),
                      Text('service_cost'.tr,style:ubuntuBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).textTheme.bodyText1!.color!,decoration: TextDecoration.none)),
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
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),

              Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Divider(height: 2, color: Colors.grey,),
              ),
              Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('sub_total'.tr,
                        style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color,),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${PriceConverter.convertPrice(bookingDetailsController.allTotalCost,isShowLongPrice: true)}',
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color),
                    ),
                  ],
                ),
              ),

              Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'service_discount'.tr,
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color:Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                          overflow: TextOverflow.ellipsis
                      )),
                    Text(
                      "(-) ${PriceConverter.convertPrice(_serviceDiscount)}",
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color:Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),),
                  ],
                ),
              ),
              Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'coupon_discount'.tr,
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                        overflow: TextOverflow.ellipsis,),),
                    Text('(-) ${PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalCouponDiscountAmount!.toDouble())}',
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),),
                  ],
                ),
              ),

              Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child: Text(
                      'campaign_discount'.tr,
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                      overflow: TextOverflow.ellipsis,),),
                    Text('(-) ${PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalCampaignDiscountAmount!.toDouble())}',
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),),
                  ],
                ),
              ),

              Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'service_vat'.tr,
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)),
                        overflow: TextOverflow.ellipsis,)),
                    Text('(+) ${PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalTaxAmount!.toDouble(),isShowLongPrice: true)}',
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyText1!.color),),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Divider(),
              ),
              Gaps.verticalGapOf(Dimensions.PADDING_SIZE_SMALL),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'grand_total'.tr,
                        style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1!.color),
                        overflow: TextOverflow.ellipsis,),),
                    Text(
                      '${PriceConverter.convertPrice(bookingDetailsController.bookingDetailsContent!.totalBookingAmount!.toDouble(),isShowLongPrice: true)}',
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyText1!.color),),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.PADDING_FOR_CHATTING_BUTTON),
            ],
          );
          return SizedBox();
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
    double _unitTotalCost = 0;
    try{
      _unitTotalCost = bookingDetailsController.unitTotalCost[index];
    }catch(error) {
      print('error : $error');
    }
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.verticalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width / 2,
                      child: Text(bookingService.serviceName != null ?bookingService.serviceName!:'',
                        style: ubuntuRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyText1!.color),
                        overflow: TextOverflow.ellipsis,),
                    ),
                    Expanded(
                      child: Text(
                        '${PriceConverter.convertPrice(_unitTotalCost,isShowLongPrice: true)}',
                        style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyText1!.color),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                Container(
                  width: Get.width / 1.5,
                  child: Text('${bookingService.variantKey!}',
                    style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall,
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)
                    ),),
                ),
                Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                priceText('unit_price'.tr, bookingService.serviceCost!.toDouble(), context,mainAxisAlignmentStart: true),
                Row(
                  children: [
                    Text('quantity'.tr,
                      style: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5)),),
                    Text(" :  ${bookingService.quantity}",style: ubuntuRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
                        fontSize: Dimensions.fontSizeExtraSmall),)
                  ],
                ),
                bookingService.discountAmount! > 0 ?
                priceText('discount'.tr,bookingService.discountAmount!.toDouble(), context,mainAxisAlignmentStart: true) : SizedBox(),
                bookingService.campaignDiscountAmount! > 0 ?
                priceText('campaign'.tr, bookingService.campaignDiscountAmount!.toDouble(), context,mainAxisAlignmentStart: true) : SizedBox(),
                bookingService.overallCouponDiscountAmount! > 0 ?
                priceText('coupon'.tr, bookingService.overallCouponDiscountAmount!.toDouble(), context,mainAxisAlignmentStart: true) : SizedBox(),

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
            title+' :   ',
            style: ubuntuRegular.copyWith(
                fontSize: Dimensions.fontSizeExtraSmall,
                color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6)
            ),
          ),
          Text('${PriceConverter.convertPrice(amount,isShowLongPrice: true)}',style: ubuntuRegular.copyWith(
            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.6),
            fontSize: Dimensions.fontSizeExtraSmall
          ),)
        ],
      ),
      Gaps.verticalGapOf(Dimensions.PADDING_SIZE_MINI),
    ],
  );
}
