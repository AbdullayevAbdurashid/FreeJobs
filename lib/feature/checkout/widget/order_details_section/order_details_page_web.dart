import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/checkout/widget/order_details_section/provider_details_card.dart';
import 'package:get/get.dart';

class OrderDetailsPageWeb extends StatelessWidget {
  const OrderDetailsPageWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: GetBuilder<CartController>(builder: (cartController){
          return Column(
            children: [
              SizedBox(height: Dimensions.PADDING_FOR_CHATTING_BUTTON,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: cardShadow,
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ServiceSchedule(),
                          ServiceInformation(),
                          ShowVoucher(),
                          if( cartController.preSelectedProvider)
                          ProviderDetailsCard()

                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 50,),
                  Expanded(
                    flex: 2,
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: cardShadow,
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CartSummery()),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_FOR_CHATTING_BUTTON,),
            ],
          );
        }),
      ),
    );
  }
}
