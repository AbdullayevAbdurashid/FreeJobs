import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ApplyVoucher extends StatelessWidget {
  const ApplyVoucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: cardShadow),
      child: Center(
        child: GestureDetector(
          onTap: (){
            Get.toNamed(RouteHelper.getVoucherRoute());
          },
          child: Row(
            children: [
              const SizedBox(width: Dimensions.paddingSizeLarge),
              Image.asset(Images.couponLogo,height: 30,),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Text('apply_a_voucher'.tr,style: ubuntuMedium.copyWith(color:Get.isDarkMode? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6):Theme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
