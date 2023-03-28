import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class WebBannerShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 2),
      color: Colors.grey,
      enabled: true,
      child: Row(children: [

        Expanded(child: Container(
          height: 220,
            decoration: BoxDecoration(
              color: Get.isDarkMode? Colors.grey[700]:Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
            )
        )),
        SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
        Expanded(child: Container(
          height: 220,
            decoration: BoxDecoration(
              color: Get.isDarkMode? Colors.grey[700]:Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
            )
        )),
      ]),
    );
  }
}