import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CustomPostPaymentMethodButton extends StatelessWidget {
  final String title;
  final String assetName;
  final PaymentMethodName paymentMethodName;
  const CustomPostPaymentMethodButton({Key? key, required this.title, required this.paymentMethodName, required this.assetName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutController>(builder: (controller){
      return GestureDetector(
        onTap:(){
          Get.find<CheckOutController>().updateDigitalPaymentOption(paymentMethodName);
          Get.find<CheckOutController>().updateSelectedDigitalPaymentIndex(-1,shouldUpdate: false);
        },
        child: Container(
          decoration: BoxDecoration(color: controller.selectedPaymentMethod == paymentMethodName ? Theme.of(context).colorScheme.primary:
          Theme.of(context).primaryColorLight,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(assetName,height: 30,width: 30,),
              const SizedBox(width: Dimensions.paddingSizeSmall,),
              Flexible(
                child: Text(title, style: ubuntuRegular.copyWith(
                    color: controller.selectedPaymentMethod == paymentMethodName ? Theme.of(context).primaryColorLight:Theme.of(context).colorScheme.primary.withOpacity(.5)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
