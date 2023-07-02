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
  List<PaymentMethodButton> listOfButton = [
    // PaymentMethodButton(title: "digital_payment".tr,paymentMethodName: PaymentMethodName.digitalPayment, assetName: Images.pay,),
    PaymentMethodButton(
      title: "cash_after_service".tr,
      paymentMethodName: PaymentMethodName.COS,
      assetName: Images.cod,
    ),
    PaymentMethodButton(
      title: "wallet_money".tr,
      paymentMethodName: PaymentMethodName.walletMoney,
      assetName: Images.walletMenu,
    ),
    PaymentMethodButton(
      title: "Kafolatili",
      paymentMethodName: PaymentMethodName.guaranteed,
      assetName: Images.cod,
      description: "Siz kafolatli ximat olasiz, oldindan ximat narxi 1000 ming",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('payment_method'.tr,
              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
          Gaps.verticalGapOf(20),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.isDesktop(context)
                    ? Dimensions.WEB_MAX_WIDTH * 0.2
                    : 0),
            child: GridView.builder(
              shrinkWrap: true,
              key: UniqueKey(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                    ? Dimensions.PADDING_SIZE_SMALL
                    : Dimensions.PADDING_SIZE_SMALL,
                mainAxisExtent: ResponsiveHelper.isMobile(context) ? 100 : 120,
                crossAxisCount: ResponsiveHelper.isDesktop(context)
                    ? 3
                    : ResponsiveHelper.isTab(context)
                        ? 3
                        : 2,
              ),
              physics: NeverScrollableScrollPhysics(),
              itemCount: listOfButton.length,
              padding: EdgeInsets.only(
                  top: 50,
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  bottom: Dimensions.PADDING_SIZE_DEFAULT),
              itemBuilder: (context, index) {
                return listOfButton.elementAt(index);
              },
            ),
          ),
          Gaps.verticalGapOf(26),
          GetBuilder<CheckOutController>(builder: (controller) {
            if (controller.selectedPaymentMethod ==
                PaymentMethodName.digitalPayment) {
              List<String>? paymentGateways = Get.find<SplashController>()
                  .configModel
                  .content
                  ?.paymentGateways!;
              if (paymentGateways!.length > 0)
                return GridView.builder(
                  padding:
                      EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
                  key: UniqueKey(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: ResponsiveHelper.isDesktop(context)
                        ? Dimensions.PADDING_SIZE_LARGE
                        : Dimensions.PADDING_SIZE_DEFAULT,
                    childAspectRatio:
                        ResponsiveHelper.isMobile(context) ? 2.5 : 4,
                    crossAxisCount: ResponsiveHelper.isDesktop(context)
                        ? 4
                        : ResponsiveHelper.isTab(context)
                            ? 3
                            : 2,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: paymentGateways.length,
                  itemBuilder: (context, index) {
                    return GetBuilder<CheckOutController>(
                        builder: (controller) {
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
                  vertical: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,
                ),
                child: Text(
                  'online_payment_option_is_not_available'.tr,
                  textAlign: TextAlign.center,
                  style: ubuntuMedium.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).colorScheme.error),
                ),
              );
            } else {
              return SizedBox();
            }
          }),
        ],
      ),
    );
  }
}