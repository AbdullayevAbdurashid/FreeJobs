import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/voucher/controller/coupon_controller.dart';

class Voucher extends StatelessWidget {
  final bool isExpired;
  final CouponModel couponModel;
  const Voucher({Key? key,required this.couponModel,required this.isExpired}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        color: Theme.of(context).hoverColor,
        boxShadow: Get.isDarkMode ?null: cardShadow,
      ),
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,),
      padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,),
      width: context.width,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: Image.asset(Images.voucherImage,fit: BoxFit.fitWidth,)),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall,),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  couponModel.couponCode!,
                  style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),

                Wrap(runAlignment: WrapAlignment.start,children: [
                  Text(
                    "${'use_code'.tr} ${couponModel.couponCode!} ${'to_save_upto'.tr}",
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),
                  ),

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      " ${PriceConverter.convertPrice(couponModel.discount!.discountAmountType == 'amount'?
                      couponModel.discount!.discountAmount!.toDouble() : couponModel.discount!.maxDiscountAmount!.toDouble())} ",
                      style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),
                    ),
                  ),

                  Text('on_your_next_purchase'.tr,
                    style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),
                  ),
                ],),

                // Text(
                //   "${'use_code'.tr} ${couponModel.couponCode!} ${'to_save_upto'.tr} ${PriceConverter.convertPrice(couponModel.discount!.discountAmountType == 'amount'?
                //   couponModel.discount!.discountAmount!.toDouble() : couponModel.discount!.maxDiscountAmount!.toDouble())} ${'on_your_next_purchase'.tr}",
                //   maxLines: 2,
                //   style: ubuntuRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.5)),
                // ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("valid_till".tr,
                          style: ubuntuRegular.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                            fontSize: Dimensions.fontSizeSmall),),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                        Text(couponModel.discount!.endDate.toString(),
                            style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6), fontSize: 12))
                      ],
                    ),
                    InkWell(
                      onTap:!isExpired? ()async {
                        if(Get.find<AuthController>().isLoggedIn()){
                          bool addCoupon = false;
                          Get.find<CartController>().cartList.forEach((cart) {
                            if(cart.totalCost >= couponModel.discount!.minPurchase!.toDouble()) {
                              addCoupon = true;
                            }
                          });
                          if(addCoupon) {
                            Get.back();
                            Get.find<CouponController>().applyCoupon(couponModel).then((value) {
                              Get.find<CartController>().getCartListFromServer();
                            },
                            );
                          }else{
                            Get.back();
                            customSnackBar('please_add_service_to_apply_coupon'.tr);
                          }
                        }else{
                          onDemandToast("login_required_to_apply_coupon".tr,Colors.red);
                        }
                      }:null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeExtraSmall),
                        decoration: BoxDecoration(
                          color: isExpired?Theme.of(context).disabledColor :Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall))
                        ),
                        child: Center(
                          child: Text(
                            isExpired?'expired'.tr:'use'.tr,
                            style: ubuntuRegular.copyWith(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: Dimensions.fontSizeDefault,),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
          ),
            ),),
        ],
      ),
    );
  }
}
