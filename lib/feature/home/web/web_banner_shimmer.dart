import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class WebBannerShimmer extends StatelessWidget {
  const WebBannerShimmer({super.key});


  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Shimmer(
        duration: const Duration(seconds: 2),
        enabled: true,
        child: Container(
          height: 220,
            decoration: BoxDecoration(
              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              //boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
            )
        ),
      )),
      const SizedBox(width: Dimensions.paddingSizeLarge),
      Expanded(child: Shimmer(
        duration: const Duration(seconds: 2),
        enabled: true,
        child: Container(
          height: 220,
            decoration: BoxDecoration(
              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
             // boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
            )
        ),
      )),
    ]);
  }
}