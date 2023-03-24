import 'package:demandium/core/core_export.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
    children: [
      ServiceSchedule(),
      ServiceInformation(),
      ShowVoucher(),
      CartSummery(),
    ],
      ),
    );
  }
}
