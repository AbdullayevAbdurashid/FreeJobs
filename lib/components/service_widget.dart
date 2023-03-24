import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class ServiceWidget extends StatelessWidget {
  final Service? service;
  ServiceWidget({required this.service,});

  @override
  Widget build(BuildContext context) {
    bool _desktop = ResponsiveHelper.isDesktop(context);
    bool? _isAvailable;

    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getServiceRoute(service!.id!), arguments: ServiceDetailsScreen(serviceID : service!.id!));
      },
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          color: Theme.of(context).cardColor,
          boxShadow: shadow
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  child: CustomImage(
                    // image: '${Get.find<SplashController>().configModel.content!.baseUrl!.productImageUrl!}/${service!.image}',
                    image: '',
                    height: _desktop ? 120 : 78, width: _desktop ? 120 : 78, fit: BoxFit.cover,
                  ),
                ),
                // DiscountTag(discount: _discount, discountType: _discountType),
                NotAvailableWidget(
                  online: _isAvailable,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(Dimensions.RADIUS_SMALL)),
                ),
              ]),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(children: [
                    Expanded(child: Text(
                      service!.name!,
                      style: ubuntuBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                      maxLines: _desktop ? 2 : 1, overflow: TextOverflow.ellipsis,
                    )),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Text(
                    service!.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: ubuntuRegular.copyWith( color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.6)),
                  ),

                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                  Text("12 Services",style: ubuntuRegular.copyWith(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).primaryColor),)
                ]),
              ),

            ]),
          ],
        ),
      ),
    );
  }
}
