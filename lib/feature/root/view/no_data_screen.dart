import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

enum NoDataType {
  CART, NOTIFICATION, ORDER, COUPON, OTHERS, HOME, OFFERS, ADDRESS, BOOKING,SEARCH, SERVICE,INBOX, CATEGORY_SUBCATEGORY
}

class NoDataScreen extends StatelessWidget {
  final NoDataType? type;
  final String? text;
  final bool isShowHomePage;
  NoDataScreen({required this.text, this.type,  this.isShowHomePage = true, });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.03),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset((type == NoDataType.CART || type == NoDataType.ORDER) ? Images.emptyCart:
              type == NoDataType.COUPON ? Images.emptyCoupon:
              type == NoDataType.NOTIFICATION ? Images.emptyNotification:
              type == NoDataType.ADDRESS ? Images.emptyAddress:
              type == NoDataType.BOOKING ? Images.emptyBooking:
              type == NoDataType.SERVICE ? Images.emptyService:
              type == NoDataType.SEARCH ? Images.emptySearchService:
              type == NoDataType.INBOX ? Images.chatImage:
              type == NoDataType.OFFERS ? Images.emptyOffer:Images.emptyService,
                width: type == NoDataType.COUPON ? 50.0:MediaQuery.of(context).size.height*0.12 ,
                height:type == NoDataType.COUPON ? 50.0: MediaQuery.of(context).size.height*0.12,
                color: Get.isDarkMode && (
                    type == NoDataType.BOOKING ||
                    type == NoDataType.HOME ||
                    type == NoDataType.SERVICE ||
                    type == NoDataType.CATEGORY_SUBCATEGORY ||
                    type == NoDataType.NOTIFICATION
                )? Theme.of(context).primaryColorLight:null,
              ),
        ),
        Text(
          type == NoDataType.CART ? 'your_cart_is_empty'.tr :
          type == NoDataType.ORDER ? 'sorry_your_order_history_is_Empty'.tr :
          type == NoDataType.COUPON ? 'no_coupon_found'.tr:
          type == NoDataType.NOTIFICATION ? 'empty_notifications'.tr : text!,
          style: ubuntuMedium.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.4),),
          textAlign: TextAlign.center,
        ),

        if(type == NoDataType.SEARCH)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text('there_are_no_services_related_to_your_search'.tr,style: ubuntuRegular.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.4),
          ),
            textAlign: TextAlign.center,),
        ),
        SizedBox(height: MediaQuery.of(context).size.height*0.04),
        if(
            type != NoDataType.CATEGORY_SUBCATEGORY &&
            type != NoDataType.INBOX &&
            type != NoDataType.BOOKING &&
            type != NoDataType.SERVICE  &&
            type != NoDataType.SEARCH  &&
            type != NoDataType.OFFERS &&
            type != NoDataType.CART &&
            type != NoDataType.ADDRESS &&
            type != NoDataType.HOME &&
            type != NoDataType.COUPON &&
            (type == NoDataType.NOTIFICATION && ResponsiveHelper.isMobile(context) || type == NoDataType.NOTIFICATION && ResponsiveHelper.isTab(context)) &&

            isShowHomePage )
        CustomButton(
          height: 40, width: 200,
          buttonText: 'back_to_homepage'.tr,
          onPressed: () => Get.offAllNamed(RouteHelper.getInitialRoute()),
        ),

      ]),
    );
  }
}
