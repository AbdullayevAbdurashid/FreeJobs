import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ServiceView extends StatelessWidget {
  final List<Service>? service;
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  final int? shimmerLength;
  final String? noDataText;
  final String? type;
  final Function(String type)? onVegFilterTap;
  ServiceView({required this.service, this.isScrollable = false, this.shimmerLength = 20,
    this.padding = const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL), this.noDataText, this.type, this.onVegFilterTap});

  @override
  Widget build(BuildContext context) {
    bool _isNull = true;
    int _length = 0;
    _isNull = service == null;
    if(!_isNull) {
      _length = service!.length;
    }

    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dimensions.fontSizeDefault),
        child: Text('sub_categories'.tr,style: ubuntuBold.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context).primaryColor),),
      ),
      !_isNull ? _length > 0 ? GridView.builder(
        key: UniqueKey(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_SMALL,
          childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 3.5,
          crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
        ),
        physics: isScrollable! ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
        shrinkWrap: isScrollable! ? false : true,
        itemCount: _length,
        padding: padding,
        itemBuilder: (context, index) {
          return ServiceWidget(service: service![index]);
        },
      ) : NoDataScreen(
        text: noDataText != null ? noDataText : 'no_services_found'.tr,
      ) : GridView.builder(
        key: UniqueKey(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_LARGE : 0.01,
          childAspectRatio: ResponsiveHelper.isDesktop(context) ? 4 : 4,
          crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
        ),
        physics: isScrollable! ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(),
        shrinkWrap: isScrollable! ? false : true,
        itemCount: shimmerLength,
        padding: padding,
        itemBuilder: (context, index) {
          return ServiceShimmer(isEnabled: _isNull, hasDivider: index != shimmerLength!-1);
        },
      ),

    ]);
  }
}
