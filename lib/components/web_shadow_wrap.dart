import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:demandium/utils/dimensions.dart';

class WebShadowWrap extends StatelessWidget {
  final Widget child;
  final double? width;
  const WebShadowWrap({Key? key, required this.child, this.width = Dimensions.webMaxWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? Padding(
      padding: ResponsiveHelper.isMobile(context) ? EdgeInsets.zero : const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeLarge, horizontal: Dimensions.paddingSizeExtraSmall,
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 380,
        ),
        padding: !ResponsiveHelper.isMobile(context) ? const EdgeInsets.all(Dimensions.paddingSizeDefault) : null,
        decoration: !ResponsiveHelper.isMobile(context) ? BoxDecoration(
          color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
            offset: const Offset(1, 1),
            blurRadius: 5,
            color: Theme.of(context).primaryColor.withOpacity(0.12),
          )],
        ) : null,
        width: width,
        child: child,
      ),
    ) : child;
  }
}