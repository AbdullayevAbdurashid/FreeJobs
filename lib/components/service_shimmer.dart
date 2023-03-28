import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ServiceShimmer extends StatelessWidget {
  final bool? isEnabled;
  final bool? hasDivider;
  ServiceShimmer({required this.isEnabled, required this.hasDivider});

  @override
  Widget build(BuildContext context) {
    bool _desktop = ResponsiveHelper.isDesktop(context);

    return Container(
      padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL)
          : EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      decoration: BoxDecoration(
        color: Get.isDarkMode? Colors.grey[700]:Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
      ),
      margin: EdgeInsets.only(top: 5),
      child: Shimmer(
        duration: Duration(seconds: 2),
        enabled: isEnabled!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[Get.isDarkMode ? 600 : 300],
                  borderRadius: BorderRadius.circular(10),

                ),
              ),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
            Container(height: 15, width: double.maxFinite, color: Colors.grey[300]),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Container(
              height:  10, width: double.maxFinite, color: Colors.grey[Get.isDarkMode ? 600 : 300],
              margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Row(children: [
              RatingBar(rating: 0, size: _desktop ? 15 : 12, ratingCount: 0),
            ]),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Row(children: [
              Container(height:10, width: 30, color: Colors.grey[Get.isDarkMode ? 600 : 300]),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Container(height: 10, width: 20, color: Colors.grey[Get.isDarkMode ? 600 : 300]),
            ]),
            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          ],
        ),
      ),
    );
  }
}
