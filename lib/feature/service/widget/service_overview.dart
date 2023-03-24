import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';


class ServiceOverview extends StatelessWidget {
  final String description;
  const ServiceOverview({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebShadowWrap(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: Dimensions.PADDING_SIZE_RADIUS),
          width: Dimensions.WEB_MAX_WIDTH,
          constraints:  ResponsiveHelper.isDesktop(context) ? BoxConstraints(
            minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 550,
          ) : null,
          child: Card(
            elevation: ResponsiveHelper.isMobile(context) ? 1:0,
              color: ResponsiveHelper.isMobile(context) ?  Theme.of(context).cardColor:Colors.transparent,
              child: Html(data: description,)),
        ),
      ),
    );
  }
}