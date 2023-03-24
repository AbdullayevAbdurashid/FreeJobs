import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  final int? status;

  const OrderSuccessfulScreen({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      body: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

        Image.asset(status == 1 ? Images.successIcon : Images.warning, width: 100, height: 100),
        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

        Text(status == 1 ? 'you_placed_the_booking_successfully'.tr : 'your_bookings_is_failed_to_place'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge),),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
          child: Text(
            status == 1 ? 'your_order_is_placed_successfully'.tr : 'you_can_try_again_later'.tr,
            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: CustomButton(buttonText: 'back_to_home'.tr, onPressed: () {
            Get.offAllNamed(RouteHelper.getInitialRoute());
            // Navigator.of(context).pushNamedAndRemoveUntil(RouteHelper.getInitialRoute(), (Route<dynamic> route) => false);
          }),
        ),
      ]))),
    );
  }
}
