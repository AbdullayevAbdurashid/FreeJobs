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
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        color: Colors.grey[Get.isDarkMode ? 700 : 300],
        boxShadow: ResponsiveHelper.isDesktop(context) ? cardShadow : null,
      ),
      child: Shimmer(
        duration: Duration(seconds: 2),
        enabled: isEnabled!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(height: _desktop ? 20 : 20, width: double.maxFinite, color: Colors.grey[400]),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Container(
                  height: _desktop ? 15 : 10, width: double.maxFinite, color: Colors.grey[Get.isDarkMode ? 600 : 400],
                  margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                ),
                RatingBar(rating: 0, size: _desktop ? 15 : 12, ratingCount: 0),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Row(children: [
                  Container(height: _desktop ? 20 : 15, width: 30, color: Colors.grey[Get.isDarkMode ? 600 : 400]),
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Container(height: _desktop ? 15 : 10, width: 20, color: Colors.grey[Get.isDarkMode ? 600 : 400]),
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
