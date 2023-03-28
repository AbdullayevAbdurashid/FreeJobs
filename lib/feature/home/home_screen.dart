import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/feature/home/widget/feathered_category_view.dart';
import 'package:demandium/feature/home/widget/recommended_provider.dart';
import 'package:demandium/feature/provider/controller/provider_booking_controller.dart';
import 'package:get/get.dart';
import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/components/service_view_vertical.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/home/widget/category_view.dart';
import 'package:demandium/feature/home/widget/random_campaign_view.dart';
import 'web_home_screen.dart';

class HomeScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {
    await Get.find<BannerController>().getBannerList(true);
    await Get.find<CategoryController>().getCategoryList(1,reload);
    Get.find<ServiceController>().getPopularServiceList(1,reload);
    Get.find<ServiceController>().getTrendingServiceList(1,reload);
    Get.find<ProviderBookingController>().getProviderList(1,reload);
    Get.find<ServiceController>().getRecentlyViewedServiceList(1,reload);
    Get.find<CampaignController>().getCampaignList(reload);
    Get.find<ServiceController>().getRecommendedServiceList(1, reload);
    Get.find<ServiceController>().getAllServiceList(1,reload);
    Get.find<SearchController>().getSuggestedServicesFromServer();
    Get.find<ServiceController>().getRecommendedSearchList(reload: reload);
    Get.find<ServiceController>().getFeatherCategoryList(reload);

  }

  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    HomeScreen.loadData(false);
    if(Get.find<AuthController>().isLoggedIn())
    Get.find<LocationController>().getAddressList();
  }

  homeAppBar(){
    if(ResponsiveHelper.isDesktop(context)){
      return WebMenuBar();
    }else{
      return AddressAppBar(backButton: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Container(
      child: Scaffold(
        appBar: homeAppBar(),
        endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
        body: ResponsiveHelper.isDesktop(context) ? WebHomeScreen(scrollController: _scrollController) : SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              Get.find<ProviderBookingController>().resetProviderFilterData();
              await Get.find<BannerController>().getBannerList(true);
              await Get.find<CategoryController>().getCategoryList(1,true);
              await Get.find<ServiceController>().getRecommendedServiceList(1,true);
              await Get.find<ProviderBookingController>().getProviderList(1, true);
              await Get.find<ServiceController>().getPopularServiceList(1,true,);
              await Get.find<ServiceController>().getRecentlyViewedServiceList(1,true,);
              await Get.find<ServiceController>().getTrendingServiceList(1,true,);
              await Get.find<CampaignController>().getCampaignList(true);
              await Get.find<ServiceController>().getFeatherCategoryList(true);
              await Get.find<ServiceController>().getAllServiceList(1,true);
              await Get.find<CartController>().getCartListFromServer();

            },
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child:GetBuilder<ServiceController>(builder: (serviceController){
                return  Container(
                  child:
                  CustomScrollView( controller: _scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    slivers: [

                      SliverToBoxAdapter(child: SizedBox(height: Dimensions.PADDING_SIZE_SMALL)),

                      SliverPersistentHeader(pinned: true,
                        delegate: SliverDelegate(extentSize: 55,
                          child: InkWell(onTap: () => Get.toNamed(RouteHelper.getSearchResultRoute()),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: Dimensions.PADDING_SIZE_DEFAULT,
                                right: Dimensions.PADDING_SIZE_DEFAULT,
                                top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_DEFAULT,
                                    right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  // border:Get.isDarkMode ? Border.all(color: Colors.grey.shade700):null,
                                    boxShadow:Get.isDarkMode ?null: [BoxShadow(color: Theme.of(context).shadowColor, blurRadius: 5, spreadRadius: 1)],
                                    borderRadius: BorderRadius.circular(22),
                                    color: Theme.of(context).cardColor
                                ),
                                child: Row(mainAxisAlignment : MainAxisAlignment.spaceBetween, children: [
                                  Text('search_services'.tr, style: ubuntuRegular.copyWith(color: Theme.of(context).hintColor)),
                                  Padding(
                                    padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_EIGHT),
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE)),),
                                      // child: Image.asset(Images.searchButton),
                                      child: Icon(Icons.search_rounded,color: Theme.of(context).primaryColorLight,),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(children: [
                          BannerView(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                            child: CategoryView(),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                          RandomCampaignView(),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                          RecommendedServiceView(),
                          if(Get.find<AuthController>().isLoggedIn())
                          HomeRecommendProvider(),
                          HorizontalScrollServiceView(fromPage: 'popular_services',serviceList: serviceController.popularServiceList),
                          if(Get.find<AuthController>().isLoggedIn())
                          HorizontalScrollServiceView(fromPage: 'recently_view_services',serviceList: serviceController.recentlyViewServiceList),
                          //CampaignView(),
                          HorizontalScrollServiceView(fromPage: 'trending_services',serviceList: serviceController.trendingServiceList),

                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                          FeatheredCategoryView(),

                          (ResponsiveHelper.isMobile(context) || ResponsiveHelper.isTab(context))?  Padding(
                            padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_DEFAULT, 15, Dimensions.PADDING_SIZE_DEFAULT,  Dimensions.PADDING_SIZE_SMALL,),
                            child: TitleWidget(
                              title: 'all_service'.tr,
                              onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("all_service")),
                            ),
                          ) :SizedBox.shrink(),

                          PaginatedListView(
                            scrollController: _scrollController,
                            totalSize: serviceController.serviceContent != null ? serviceController.serviceContent!.total! : null,
                            offset: serviceController.serviceContent != null ? serviceController.serviceContent!.currentPage != null ? serviceController.serviceContent!.currentPage! : null : null,
                            onPaginate: (int offset) async => await serviceController.getAllServiceList(offset, false),
                            itemView: ServiceViewVertical(
                              service: serviceController.serviceContent != null ? serviceController.allService : null,
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_DEFAULT,
                                vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                              ),
                              type: 'others',
                              noDataType: NoDataType.HOME,
                            ),
                          ),
                        ]))),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}



class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget? child;
  double? extentSize;

  SliverDelegate({@required this.child,@required this.extentSize});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child!;
  }

  @override
  double get maxExtent => extentSize!;

  @override
  double get minExtent => extentSize!;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != maxExtent || child != oldDelegate.child;
  }
}
