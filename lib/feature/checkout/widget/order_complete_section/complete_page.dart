import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CompletePage extends StatelessWidget {
  const CompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80.0,),
            GetBuilder<CheckOutController>(builder: (controller) {
              return controller.cancelPayment == false
                  ? Column(
                    children: [
                      Text('you_placed_the_booking_successfully'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.blue),),
                      const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge*1.5,),
                      Image.asset(Images.orderComplete,scale: 3.5,),
                      if(ResponsiveHelper.isWeb())
                        const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,)
                    ],
                  )
                  : Text('your_bookings_is_failed_to_place'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
              );
            }),
          ],
        ),
      ),
    );
  }
}
