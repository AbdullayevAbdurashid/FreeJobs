import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class WebBannerShimmer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: Duration(seconds: 2),
      enabled: true,
      child: Row(children: [

        Expanded(child: Container(
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300],
          ),
        )),
        SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
        Expanded(child: Container(
          height: 220,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 600 : 300]
          ),
        )),
      ]),
    );
  }
}