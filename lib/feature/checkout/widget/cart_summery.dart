import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/checkout/widget/row_text.dart';
import 'package:demandium/feature/voucher/controller/coupon_controller.dart';

class CartSummery extends GetView<CartController> {
  const CartSummery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(
        builder: (couponControllers){
        return GetBuilder<CartController>(
          builder: (cartController){
            List<CartModel> cartList = cartController.cartList;
            ///total and discount price will be calculated from all cart item price
            double subTotalPrice = 0;
            double disCount = 0;
            double campaignDisCount = 0;
            double couponDisCount = 0;
            double vat = 0;
            for (var cartModel in cartController.cartList) {
              subTotalPrice = subTotalPrice + (cartModel.serviceCost * cartModel.quantity); //(without any discount and coupons)
              disCount = disCount + cartModel.discountedPrice ;
              campaignDisCount = campaignDisCount + cartModel.campaignDiscountPrice;
              couponDisCount = couponDisCount + cartModel.couponDiscountPrice;

              vat = vat + (cartModel.taxAmount );

            }
            double grandTotal = (subTotalPrice  - (couponDisCount + disCount + campaignDisCount)) + vat;


            return Column(
              children: [
                const SizedBox(height: Dimensions.paddingSizeDefault),
                Text(
                  'cart_summary'.tr,
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow:Get.isDarkMode ?null: shadow
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( Dimensions.paddingSizeDefault),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: cartList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index){
                            double totalCost = cartList.elementAt(index).serviceCost.toDouble() * cartList.elementAt(index).quantity;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RowText(title: cartList.elementAt(index).service!.name!, quantity: cartList.elementAt(index).quantity, price: totalCost),
                              SizedBox(
                                width:Get.width / 2.5,
                                child: Text(
                                  cartList.elementAt(index).variantKey,
                                  style: ubuntuMedium.copyWith(
                                      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.4),
                                      fontSize: Dimensions.fontSizeSmall),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeDefault,)
                            ],
                          );
                        },
                        ),
                        Divider(
                          height: 1,
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        RowText(title: 'sub_total'.tr, price: subTotalPrice),
                        RowText(title: 'discount'.tr, price: disCount),
                        RowText(title: 'campaign_discount'.tr, price: campaignDisCount),
                        RowText(title: 'coupon_discount'.tr, price: couponDisCount),
                        RowText(title: 'vat'.tr, price: vat),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Divider(
                          height: 1,
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        RowText(title:'grand_total'.tr , price: grandTotal),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: ConditionCheckBox(),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
              ],
            );
          }
        );
      }
    );
  }
}
