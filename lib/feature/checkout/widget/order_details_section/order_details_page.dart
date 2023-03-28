import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/checkout/widget/order_details_section/provider_details_card.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ServiceSchedule(),
        ServiceInformation(),
        ShowVoucher(),
        if( Get.find<CartController>().preSelectedProvider)
          ProviderDetailsCard(),
        CartSummery()
    ]));
  }
}
