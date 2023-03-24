import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/checkout/widget/payment_method_button.dart';
import 'digital_payment.dart';

class PaymentPage extends StatefulWidget {
  final String addressId;

  const PaymentPage({Key? key, required this.addressId}) : super(key: key);
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}
class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
           Text('payment_method'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
          Gaps.verticalGapOf(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PaymentMethodButton(title: "digital_payment".tr,paymentMethodName: PaymentMethodName.digitalPayment, assetName: Images.pay,),
              Gaps.horizontalGapOf(Dimensions.PADDING_SIZE_DEFAULT),
              PaymentMethodButton(title: "cash_after_service".tr,paymentMethodName: PaymentMethodName.COS,assetName: Images.cod,),
            ],
          ),
          Gaps.verticalGapOf(26),
          GetBuilder<CheckOutController>(builder: (controller){
            if(controller.selectedPaymentMethod ==  PaymentMethodName.digitalPayment){
              List<String>? paymentGateways = Get.find<SplashController>().configModel.content?.paymentGateways!;
              if( paymentGateways!.length > 0)
              return  GridView.builder(
                padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_DEFAULT,
                  childAspectRatio: ResponsiveHelper.isMobile(context) ? 2.5  : 4,
                  crossAxisCount: 2,
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: paymentGateways.length,
                itemBuilder: (context, index)  {
                  return GetBuilder<CheckOutController>(builder: (controller){
                    return DigitalPayment(
                      paymentGateway: paymentGateways[index],
                      addressId: widget.addressId,
                    );
                  });
                },
              );
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,),
                child: Text('online_payment_option_is_not_available'.tr,
                  textAlign:TextAlign.center,
                  style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeLarge,

                    color: Theme.of(context).errorColor),),
              );
            }else{
              return SizedBox();
            }
          }),
        ],
      ),
    );

  }
}