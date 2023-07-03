import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/voucher/controller/coupon_controller.dart';

class ShowVoucher extends StatelessWidget {
  const ShowVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(
      builder: (couponController){
        return couponController.coupon != null ?
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6).withOpacity(.3), width: 1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  Get.toNamed(RouteHelper.getVoucherRoute());
                },
                child: Row(
                  children: [
                    Image.asset(Images.couponIcon,width: 20.0,height: 20.0,),
                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                    Text(couponController.coupon!.couponCode!,
                      style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                    Text("applied".tr,style: ubuntuMedium.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),),),
                  ],
                ),
              ),

              TextButton(
                onPressed: () async {
                  //Get.dialog(CustomLoader(), barrierDismissible: false,);
                  await Get.find<CouponController>().removeCoupon();
                  // await Get.find<CartController>().getCartListFromServer();
                  //Get.back();
                },
                child: Text('remove'.tr,
                style: ubuntuMedium.copyWith(color: Theme.of(context).colorScheme.error),),
              )
            ],
          ),
        ):
        const ApplyVoucher();
      }
    );
  }
}
