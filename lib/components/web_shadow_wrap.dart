import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:demandium/utils/dimensions.dart';

class WebShadowWrap extends StatelessWidget {
  final Widget child;
  final double? width;
  const WebShadowWrap({Key? key, required this.child, this.width = Dimensions.WEB_MAX_WIDTH}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? Padding(
      padding: ResponsiveHelper.isMobile(context) ? EdgeInsets.zero : const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE, horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 380,
        ),
        padding: !ResponsiveHelper.isMobile(context) ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
        decoration: !ResponsiveHelper.isMobile(context) ? BoxDecoration(
          color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
            offset: Offset(1, 1),
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