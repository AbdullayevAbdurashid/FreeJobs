import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class PaymentMethodButton extends StatelessWidget {
  final String title;
  final String assetName;
  final PaymentMethodName paymentMethodName;
  const PaymentMethodButton({Key? key, required this.title, required this.paymentMethodName, required this.assetName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),),
      ),
      onPressed:(){
        Get.find<CheckOutController>().updateDigitalPaymentOption(paymentMethodName);
      },
      child: GetBuilder<CheckOutController>(builder: (controller){
        return Container(
          height: 90,
          width: 140,
          decoration: BoxDecoration(
              color: controller.selectedPaymentMethod == paymentMethodName ? Theme.of(context).colorScheme.primary:
              Theme.of(context).primaryColorLight,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: [
              Gaps.verticalGapOf(8),
              Image(image: AssetImage(assetName),height: 50,),
              Gaps.verticalGapOf(8),
              Text(title, style: ubuntuRegular.copyWith(
                  color: controller.selectedPaymentMethod == paymentMethodName ? Theme.of(context).primaryColorLight:Theme.of(context).colorScheme.primary.withOpacity(.5)),)
            ],
          ),
        );
      }),
    );
  }
}
