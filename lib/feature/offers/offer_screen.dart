import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/components/service_view_vertical.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/core_export.dart';

class OfferScreen extends GetView<ServiceController> {
  const OfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(
        isBackButtonExist: false,
        title: 'offers'.tr,
      ),
      body: GetBuilder<ServiceController>(
        initState: (state) async {
         await controller.getOffersList(1,true);
        },
        builder: (serviceController){
          if( serviceController.offerBasedServiceList == null){
            return Center(child: FooterBaseView(child: WebShadowWrap(child: Center(child: CircularProgressIndicator()))));
          }else{
            List<Service> serviceList = serviceController.offerBasedServiceList!;
              return Stack(
                children: [

                  FooterBaseView(
                    scrollController: _scrollController,
                    isCenter: (serviceList.length == 0),
                    child:serviceList.length > 0 ?  Padding(
                      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_FOR_CHATTING_BUTTON),
                      child: SizedBox(
                        width: Dimensions.WEB_MAX_WIDTH,
                        child: Column(
                          children: [
                            !ResponsiveHelper.isMobile(context)?Padding(
                              padding: EdgeInsets.fromLTRB(
                                Dimensions.PADDING_SIZE_DEFAULT,
                                Dimensions.fontSizeDefault,
                                Dimensions.PADDING_SIZE_DEFAULT,
                                Dimensions.PADDING_SIZE_SMALL,
                              ),
                              child: TitleWidget(
                                title: 'current_offers'.tr,
                              ),
                            ):SizedBox.shrink(),
                            ResponsiveHelper.isMobile(context)?SizedBox(height: 120,):SizedBox.shrink(),
                            PaginatedListView(
                              scrollController: _scrollController,
                              totalSize: serviceController.offerBasedServiceContent != null ? serviceController.offerBasedServiceContent!.total! : null,
                              offset: serviceController.offerBasedServiceContent != null ? serviceController.offerBasedServiceContent!.currentPage != null ? serviceController.offerBasedServiceContent!.currentPage! : null : null,
                              onPaginate: (int offset) async => await serviceController.getOffersList(offset, false),
                              itemView: ServiceViewVertical(
                                service: serviceList,
                                padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_DEFAULT,
                                  vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                                ),
                                type: 'others',
                                noDataType: NoDataType.HOME,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ):
                    WebShadowWrap(
                      child: NoDataScreen(
                        text: "no_offer_found".tr,
                        type:  NoDataType.OFFERS,
                      ),
                    ),
                  ),
                 ResponsiveHelper.isMobile(context) && serviceList.length > 0
                     ? Align(
                   alignment: Alignment.topCenter,
                   child: Stack(
                     children: [
                       Container(
                         height: 120,
                         width: MediaQuery.of(context).size.width,
                         color: Theme.of(context).scaffoldBackgroundColor,
                       ),
                       Image.asset(
                         Images.offerBanner,
                         width: Get.width,
                         fit: BoxFit.cover,
                         height: 100,
                       ),
                       Container(
                         color: Colors.black54,
                         height: 100,
                         child: Center(
                           child: Text('current_offers'.tr,style: ubuntuMedium.copyWith(color: Colors.white,fontSize: Dimensions.fontSizeExtraLarge),),
                         ),
                       )
                     ],
                   ),
                 )
                     :SizedBox.shrink(),
                ],
              );
          }
        },
      ),
    );
  }
}