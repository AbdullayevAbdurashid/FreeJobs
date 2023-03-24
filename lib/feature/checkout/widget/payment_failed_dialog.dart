import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class PaymentFailedDialog extends StatelessWidget {
  PaymentFailedDialog();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Image.asset(Images.warning, width: 70, height: 70),
      ),
      Text(
        'are_you_agree_with_this_order_fail'.tr, textAlign: TextAlign.center,
        style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
      CustomButton(
          onPressed: (){
            Get.back();
            Get.back();
          },
          buttonText: 'retry'.tr),
      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

      TextButton(
        onPressed: () {
          Get.offAllNamed(RouteHelper.getInitialRoute());
        },
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize: Size(Dimensions.WEB_MAX_WIDTH, 45), padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
        ),
        child: Text('continue_with_order_fail'.tr, textAlign: TextAlign.center, style: ubuntuBold.copyWith(color: Theme.of(context).textTheme.bodyText1!.color)),
      ),

    ]);
  }
}
