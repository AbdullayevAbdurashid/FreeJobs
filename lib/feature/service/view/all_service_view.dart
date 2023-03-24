import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/components/service_view_vertical.dart';
import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/core/core_export.dart';

class AllServiceView extends StatefulWidget {
  final String fromPage;
  final String campaignID;
  AllServiceView({required this.fromPage,required this.campaignID});

  @override
  State<AllServiceView> createState() => _AllServiceViewState();
}

class _AllServiceViewState extends State<AllServiceView> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(
        title:widget.fromPage == 'allServices' ? 'all_service'.tr
            : widget.fromPage == 'fromRecommendedScreen' ? 'recommended_for_you'.tr
            : widget.fromPage == 'popular_services' ? 'popular_services'.tr
            : widget.fromPage == 'recently_view_services' ? 'recently_view_services'.tr
            : widget.fromPage == 'trending_services' ? 'trending_services'.tr
            : 'available_service'.tr,showCart: true,),
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      body: _buildBody(widget.fromPage,context,scrollController),
    );
  }

  Widget _buildBody(String fromPage,BuildContext context,ScrollController scrollController){
    if(fromPage == 'popular_services') {
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getPopularServiceList(1,true);
        },
        builder: (serviceController){
          return FooterBaseView(
            scrollController: scrollController,
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(
                children: [
                  if(ResponsiveHelper.isDesktop(context))
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.fontSizeDefault,
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: TitleWidget(
                      title: 'popular_services'.tr,
                    ),
                  ),
                  PaginatedListView(
                    scrollController: scrollController,
                    totalSize: serviceController.popularBasedServiceContent != null ? serviceController.popularBasedServiceContent!.total! : null,
                    offset: serviceController.popularBasedServiceContent != null ? serviceController.popularBasedServiceContent!.currentPage != null ? serviceController.popularBasedServiceContent!.currentPage! : null : null,
                    onPaginate: (int offset) async {
                      print("popular_service_on_paginate");
                      return await serviceController.getPopularServiceList(offset, false);
                    },
                    itemView: ServiceViewVertical(
                      service: serviceController.popularBasedServiceContent != null ? serviceController.popularServiceList : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL :  Dimensions.PADDING_SIZE_SMALL,
                      ),
                      type: 'others',
                      noDataType: NoDataType.HOME,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    else if(fromPage == 'trending_services') {
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getTrendingServiceList(1,true);
        },
        builder: (serviceController){
          return FooterBaseView(
            scrollController: scrollController,
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(
                children: [
                  if(ResponsiveHelper.isDesktop(context))
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.PADDING_SIZE_DEFAULT,
                        Dimensions.fontSizeDefault,
                        Dimensions.PADDING_SIZE_DEFAULT,
                        Dimensions.PADDING_SIZE_SMALL,
                      ),
                      child: TitleWidget(
                        title: 'trending_services'.tr,
                      ),
                    ),
                  PaginatedListView(
                    scrollController: scrollController,
                    totalSize: serviceController.trendingServiceContent != null ? serviceController.trendingServiceContent!.total! : null,
                    offset: serviceController.trendingServiceContent != null ? serviceController.trendingServiceContent!.currentPage != null ? serviceController.trendingServiceContent!.currentPage! : null : null,
                    onPaginate: (int offset) async {
                      return await serviceController.getTrendingServiceList(offset, false);
                    },
                    itemView: ServiceViewVertical(
                      service: serviceController.trendingServiceContent != null ? serviceController.trendingServiceList : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL :  Dimensions.PADDING_SIZE_SMALL,
                      ),
                      type: 'others',
                      noDataType: NoDataType.HOME,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    else if(fromPage == 'recently_view_services') {
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getRecentlyViewedServiceList(1,true);
        },
        builder: (serviceController){
          return FooterBaseView(
            scrollController: scrollController,
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(
                children: [
                  if(ResponsiveHelper.isDesktop(context))
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        Dimensions.PADDING_SIZE_DEFAULT,
                        Dimensions.fontSizeDefault,
                        Dimensions.PADDING_SIZE_DEFAULT,
                        Dimensions.PADDING_SIZE_SMALL,
                      ),
                      child: TitleWidget(
                        title: 'recently_view_services'.tr,
                      ),
                    ),
                  PaginatedListView(
                    scrollController: scrollController,
                    totalSize: serviceController.recentlyViewServiceContent != null ? serviceController.recentlyViewServiceContent!.total! : null,
                    offset: serviceController.recentlyViewServiceContent != null
                        ? serviceController.recentlyViewServiceContent!.currentPage != null ? serviceController.recentlyViewServiceContent!.currentPage! : null : null,
                    onPaginate: (int offset) async {
                      return await serviceController.getRecentlyViewedServiceList(offset, false);
                    },
                    itemView: ServiceViewVertical(
                      service: serviceController.recentlyViewServiceContent != null ? serviceController.recentlyViewServiceList : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL :  Dimensions.PADDING_SIZE_SMALL,
                      ),
                      type: 'others',
                      noDataType: NoDataType.HOME,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    else if(fromPage == 'fromCampaign') {
      return GetBuilder<ServiceController>(
        initState: (state){

          Get.find<ServiceController>().getEmptyCampaignService();
          Get.find<ServiceController>().getCampaignBasedServiceList(widget.campaignID,true);
        },
        builder: (serviceController){
          return _buildWidget(serviceController.campaignBasedServiceList,context);
        },
      );
    }
    else if(fromPage == 'fromRecommendedScreen'){
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getRecommendedServiceList(1,true);
        },
        builder: (serviceController){
          return FooterBaseView(
            scrollController: scrollController,
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(
                children: [
                  if(ResponsiveHelper.isDesktop(context))
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.fontSizeDefault,
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: TitleWidget(
                      title: 'recommended_for_you'.tr,
                    ),
                  ),
                  PaginatedListView(
                    scrollController: scrollController,
                    totalSize: serviceController.recommendedBasedServiceContent != null ? serviceController.recommendedBasedServiceContent!.total! : null,
                    offset: serviceController.recommendedBasedServiceContent != null ? serviceController.recommendedBasedServiceContent!.currentPage != null ? serviceController.recommendedBasedServiceContent!.currentPage!: null : null,
                    onPaginate: (int offset) async {
                      printLog("inside_on_paginate:$offset");
                      return await serviceController.getRecommendedServiceList(offset, false);
                    },
                    itemView: ServiceViewVertical(
                      service: serviceController.recommendedBasedServiceContent != null ? serviceController.recommendedServiceList : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL :  Dimensions.PADDING_SIZE_SMALL,
                      ),
                      type: 'others',
                      noDataType: NoDataType.HOME,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    else if(fromPage == 'all_service'){
      return GetBuilder<ServiceController>(
          initState: (state){
            Get.find<ServiceController>().getAllServiceList(1,true);
          },
          builder: (serviceController) {
        return FooterBaseView(
          scrollController: scrollController,
          child: SizedBox(
            width: Dimensions.WEB_MAX_WIDTH,
            child: Column(
              children: [
                if(ResponsiveHelper.isDesktop(context))
                  Padding(
                  padding: EdgeInsets.fromLTRB(
                    Dimensions.PADDING_SIZE_DEFAULT,
                    Dimensions.PADDING_SIZE_DEFAULT,
                    Dimensions.PADDING_SIZE_DEFAULT,
                    Dimensions.PADDING_SIZE_SMALL,
                  ),
                  child: TitleWidget(
                    title: 'all_service'.tr,
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                PaginatedListView(
                  scrollController: scrollController,
                  totalSize:serviceController.serviceContent != null ?  serviceController.serviceContent!.total != null ? serviceController.serviceContent!.total! : null:null,
                  offset: serviceController.serviceContent != null ? serviceController.serviceContent!.currentPage != null ? serviceController.serviceContent!.currentPage!: null : null,
                  onPaginate: (int offset) async => await serviceController.getAllServiceList(offset, false),
                  itemView: ServiceViewVertical(
                    service: serviceController.serviceContent != null ? serviceController.allService : null,
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                      vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                    ),
                    type: 'others',
                    noDataType: NoDataType.HOME,
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }
    else{
      return GetBuilder<ServiceController>(
        initState: (state){
          Get.find<ServiceController>().getSubCategoryBasedServiceList(fromPage,false,isShouldUpdate: true);
        },
        builder: (serviceController){
          return _buildWidget(serviceController.subCategoryBasedServiceList ,context);
        },
      );
    }
  }

  Widget _buildWidget(List<Service>? serviceList,BuildContext context){
    return FooterBaseView(
      isCenter:(serviceList == null || serviceList.length == 0),
      child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: (serviceList != null && serviceList.length == 0) ?  NoDataScreen(text: 'no_services_found'.tr,type: NoDataType.SERVICE,) :  serviceList != null ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_DEFAULT),
          child: CustomScrollView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              if(ResponsiveHelper.isWeb())
              SliverToBoxAdapter(child: SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,)),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
                  mainAxisSpacing:  Dimensions.PADDING_SIZE_DEFAULT,
                  childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? .9 : .75,
                  crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
                  mainAxisExtent: 240,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    Get.find<ServiceController>().getServiceDiscount(serviceList[index]);
                    return ServiceWidgetVertical(service: serviceList[index],  isAvailable: true,fromType: widget.fromPage,);
                  },
                  childCount: serviceList.length,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: Dimensions.WEB_CATEGORY_SIZE,)),
            ],
          ),
        ) : GridView.builder(
          key: UniqueKey(),
          padding: EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
            bottom: Dimensions.PADDING_SIZE_DEFAULT,
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: Dimensions.PADDING_SIZE_DEFAULT,
            mainAxisSpacing:  Dimensions.PADDING_SIZE_DEFAULT,
            childAspectRatio: ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context)  ? 1 : .70,
            crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : ResponsiveHelper.isTab(context) ? 3 : 5,
          ),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return ServiceShimmer(isEnabled: true, hasDivider: false);
          },
        ),
      ),
    );
  }
}

