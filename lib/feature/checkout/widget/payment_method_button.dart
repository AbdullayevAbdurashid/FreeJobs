import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class PaymentMethodButton extends StatelessWidget {
  final String title;
  final String assetName;
  final PaymentMethodName paymentMethodName;
  final String? description;

  const PaymentMethodButton({
    Key? key,
    required this.title,
    required this.paymentMethodName,
    required this.assetName,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            Get.find<CheckOutController>()
                .updateDigitalPaymentOption(paymentMethodName);
          },
          child: Tooltip(
            message: description ?? '', // Display the description as a tooltip
            preferBelow: false, // Show the tooltip above the button
            child: Container(
              decoration: BoxDecoration(
                color: controller.selectedPaymentMethod == paymentMethodName
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Gaps.verticalGapOf(8),
                        Image(
                          image: AssetImage(assetName),
                          height: 50,
                        ),
                        Gaps.verticalGapOf(8),
                        Text(
                          title,
                          style: ubuntuRegular.copyWith(
                            color: controller.selectedPaymentMethod ==
                                    paymentMethodName
                                ? Theme.of(context).primaryColorLight
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(.5),
                          ),
                        ),
                        if (description != null)
                          Text(
                            description!,
                            maxLines: 2, // Limit the description to 2 lines
                            overflow: TextOverflow
                                .ellipsis, // Add ellipsis if overflow
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  12, // Adjust the font size for the description
                              color: controller.selectedPaymentMethod ==
                                      paymentMethodName
                                  ? Theme.of(context).primaryColorLight
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.5),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
