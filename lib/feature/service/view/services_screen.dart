import 'package:get/get.dart';
import '../../../core/core_export.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddressAppBar(),
      body: SingleChildScrollView(
        child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(children: [
          ServiceView(service: Get.find<ServiceController>().popularServiceList!),
        ]))),
      ),
    );
  }
}
