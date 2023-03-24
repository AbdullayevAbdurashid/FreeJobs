import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/checkout/widget/row_text.dart';
import 'package:demandium/feature/voucher/controller/coupon_controller.dart';

class CartSummery extends GetView<CartController> {
  const CartSummery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(
        builder: (_couponControllers){
        return GetBuilder<CartController>(
          builder: (cartController){
            List<CartModel> cartList = cartController.cartList;
            ///total and discount price will be calculated from all cart item price
            double _subTotalPrice = 0;
            double _disCount = 0;
            double _campaignDisCount = 0;
            double _couponDisCount = 0;
            double _vat = 0;
            cartController.cartList.forEach((cartModel) {
              _subTotalPrice = _subTotalPrice + (cartModel.serviceCost * cartModel.quantity); //(without any discount and coupons)
              _disCount = _disCount + cartModel.discountedPrice ;
              _campaignDisCount = _campaignDisCount + cartModel.campaignDiscountPrice;
              _couponDisCount = _couponDisCount + cartModel.couponDiscountPrice;

              _vat = _vat + (cartModel.taxAmount );

            });
            double grandTotal = (_subTotalPrice  - (_couponDisCount + _disCount + _campaignDisCount)) + _vat;


            return Column(
              children: [
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                Text(
                  'cart_summary'.tr,
                  style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow:Get.isDarkMode ?null: shadow
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: cartList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index){
                            double totalCost = cartList.elementAt(index).serviceCost.toDouble() * cartList.elementAt(index).quantity;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RowText(title: cartList.elementAt(index).service!.name!, quantity: cartList.elementAt(index).quantity, price: totalCost),
                              Container(
                                width:Get.width / 2.5,
                                child: Text(
                                  cartList.elementAt(index).variantKey,
                                  style: ubuntuMedium.copyWith(
                                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.4),
                                      fontSize: Dimensions.fontSizeSmall),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,)
                            ],
                          );
                        },
                        ),
                        Divider(
                          height: 1,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        RowText(title: 'sub_total'.tr, price: _subTotalPrice),
                        RowText(title: 'discount'.tr, price: _disCount),
                        RowText(title: 'campaign_discount'.tr, price: _campaignDisCount),
                        RowText(title: 'coupon_discount'.tr, price: _couponDisCount),
                        RowText(title: 'vat'.tr, price: _vat),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        Divider(
                          height: 1,
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        RowText(title:'grand_total'.tr , price: grandTotal),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: ConditionCheckBox(),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              ],
            );
          }
        );
      }
    );
  }
}
