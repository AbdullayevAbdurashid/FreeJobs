import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/feature/service/widget/service_details_faq_section.dart';
import 'package:demandium/feature/service/widget/service_info_card.dart';
import 'package:demandium/feature/service/widget/service_overview.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/core/helper/decorated_tab_bar.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String serviceID;
  const ServiceDetailsScreen({Key? key, required this.serviceID}) : super(key: key);

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<ServiceTabController>().pageSize??0;
        if (Get.find<ServiceTabController>().offset! < pageSize) {
          Get.find<ServiceTabController>().getServiceReview(widget.serviceID, Get.find<ServiceTabController>().offset!+1);
        }}
    });
    Get.find<ServiceController>().getRecentlyViewedServiceList(1,true,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(centerTitle: false, title: 'service_details'.tr,showCart: true,),
      body: GetBuilder<ServiceDetailsController>(
          initState: (state) {
            Get.find<ServiceDetailsController>().getServiceDetails(widget.serviceID);},
          builder: (serviceController) {
            if(serviceController.service != null){
              if(serviceController.service!.id != null){
                Service? service = serviceController.service;
                Discount _discount = PriceConverter.discountCalculation(service!);
                double _lowestPrice = 0.0;
                if(service.variationsAppFormat!.zoneWiseVariations != null){
                  _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
                  for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
                    if (service.variationsAppFormat!.zoneWiseVariations![i].price! < _lowestPrice) {
                      _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
                    }
                  }
                }
                return  FooterBaseView(
                  isScrollView:ResponsiveHelper.isMobile(context) ? false: true,
                  child: SizedBox(
                    width: Dimensions.WEB_MAX_WIDTH,
                    child: DefaultTabController(
                      length: Get.find<ServiceDetailsController>().service!.faqs!.length > 0 ? 3 :2,
                      child: Column(
                        children: [
                          if(!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context))
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all((!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context)) ?  Radius.circular(8): Radius.circular(0.0)),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: Dimensions.WEB_MAX_WIDTH,
                                            height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                            child: CustomImage(
                                              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.coverImage}',
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            width: Dimensions.WEB_MAX_WIDTH,
                                            height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                            decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.6)
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: Dimensions.WEB_MAX_WIDTH,
                                          height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                          child: Center(child: Text(service.name ?? '',
                                              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white))),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 120,)
                                ],
                              ),
                              Positioned(
                                bottom: -2,
                                  left: Dimensions.PADDING_SIZE_SMALL,
                                  right: Dimensions.PADDING_SIZE_SMALL,
                                  child: ServiceInformationCard(discount: _discount,service: service,lowestPrice: _lowestPrice)),
                            ],
                          ),
                          //Tab Bar
                          GetBuilder<ServiceTabController>(
                            init: Get.find<ServiceTabController>(),
                            builder: (serviceTabController) {
                              return Container(
                                color:Theme.of(context).scaffoldBackgroundColor,
                                child: Center(
                                  child: Container(
                                    width: ResponsiveHelper.isMobile(context) ?null : Get.width / 3,
                                    color: Get.isDarkMode?Theme.of(context).scaffoldBackgroundColor:Theme.of(context).cardColor,
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                    child: DecoratedTabBar(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Theme.of(context).colorScheme.primary.withOpacity(.3),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      tabBar: TabBar(
                                          padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_MINI),
                                          unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.4),
                                          controller: serviceTabController.controller!,
                                          labelColor:Get.isDarkMode? Colors.white : Theme.of(context).primaryColor,
                                          labelStyle: ubuntuBold.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                          ),
                                          indicatorColor: Theme.of(context).colorScheme.primary,
                                          indicatorPadding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                                          labelPadding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                          indicatorWeight: 2,
                                          onTap: (int? index) {
                                            switch (index) {
                                              case 0:
                                                serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.serviceOverview);
                                                break;
                                              case 1:
                                                serviceTabController.serviceDetailsTabs().length > 2 ?
                                                serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.faq):
                                                serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.review);
                                                break;
                                              case 2:
                                                serviceTabController.updateServicePageCurrentState(ServiceTabControllerState.review);
                                                break;
                                            }
                                          },
                                          tabs: serviceTabController.serviceDetailsTabs()
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          //Tab Bar View
                          GetBuilder<ServiceTabController>(
                            initState: (state){
                              Get.find<ServiceTabController>().getServiceReview(serviceController.service!.id!,1);
                            },
                            builder: (controller){
                              Widget tabBarView = TabBarView(
                                controller: controller.controller,
                                children: [
                                  SingleChildScrollView(child: ServiceOverview(description:service.description!)),
                                  if(Get.find<ServiceDetailsController>().service!.faqs!.length > 0)
                                    SingleChildScrollView(child: ServiceDetailsFaqSection()),
                                  if(controller.reviewList != null)
                                    SingleChildScrollView(
                                      child: ServiceDetailsReview(
                                        serviceID: serviceController.service!.id!,
                                        reviewList: controller.reviewList!, rating : controller.rating,),
                                    )
                                  else
                                    EmptyReviewWidget()
                                ],
                              );

                              if(ResponsiveHelper.isMobile(context)){
                                return Expanded(
                                  child: tabBarView,
                                );
                              }else{
                                return Container(
                                  height: 500,
                                  child: tabBarView,);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }else{
                return NoDataScreen(text: 'no_service_available'.tr,type: NoDataType.SERVICE,);
              }
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

