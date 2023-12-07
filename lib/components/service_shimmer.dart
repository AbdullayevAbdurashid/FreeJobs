import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ServiceShimmer extends StatelessWidget {
  final bool? isEnabled;
  final bool? hasDivider;
  const ServiceShimmer({super.key, required this.isEnabled, required this.hasDivider});

  @override
  Widget build(BuildContext context) {
    bool desktop = ResponsiveHelper.isDesktop(context);

    return Container(
      padding: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.all(Dimensions.paddingSizeSmall)
          : const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        color: Get.isDarkMode? Colors.grey[700]:Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: Get.isDarkMode?null:[BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
      ),
      margin: const EdgeInsets.only(top: 5),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        enabled: isEnabled!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[Get.isDarkMode ? 600 : 300],
                  borderRadius: BorderRadius.circular(10),

                ),
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
            Container(height: 15, width: double.maxFinite, color: Colors.grey[300]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Container(
              height:  10, width: double.maxFinite, color: Colors.grey[Get.isDarkMode ? 600 : 300],
              margin: const EdgeInsets.only(right: Dimensions.paddingSizeLarge),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Row(children: [
              RatingBar(rating: 0, size: desktop ? 15 : 12, ratingCount: 0),
            ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Row(children: [
              Container(height:10, width: 30, color: Colors.grey[Get.isDarkMode ? 600 : 300]),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
              Container(height: 10, width: 20, color: Colors.grey[Get.isDarkMode ? 600 : 300]),
            ]),
            const SizedBox(height: Dimensions.paddingSizeSmall,),
          ],
        ),
      ),
    );
  }
}
