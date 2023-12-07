import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/components/text_hover.dart';
import 'package:demandium/feature/home/widget/feathered_category_view.dart';
import 'package:demandium/feature/home/widget/home_create_post_view.dart';
import 'package:demandium/feature/home/widget/recommended_provider.dart';
import 'package:demandium/feature/provider/controller/provider_booking_controller.dart';
import 'package:get/get.dart';
import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/components/service_view_vertical.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/home/widget/category_view.dart';
import 'package:demandium/feature/home/widget/random_campaign_view.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'web_home_screen.dart';

class HomeScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {
    Get.find<BannerController>().getBannerList(reload);
    Get.find<CategoryController>().getCategoryList(1,reload);
    Get.find<ServiceController>().getPopularServiceList(1,reload);
    Get.find<ServiceController>().getTrendingServiceList(1,reload);
    Get.find<ProviderBookingController>().getProviderList(1,reload);
    Get.find<CampaignController>().getCampaignList(reload);
    Get.find<ServiceController>().getRecommendedServiceList(1, reload);
    Get.find<ServiceController>().getAllServiceList(1,reload);
    if(Get.find<AuthController>().isLoggedIn()){
      Get.find<ServiceController>().getRecentlyViewedServiceList(1,reload);
    }
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
    if(Get.find<AuthController>().isLoggedIn()) {
      Get.find<LocationController>().getAddressList();
    }
  }

  homeAppBar(){
    if(ResponsiveHelper.isDesktop(context)){
      return const WebMenuBar();
    }else{
      return const AddressAppBar(backButton: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: homeAppBar(),
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      body: ResponsiveHelper.isDesktop(context) ? WebHomeScreen(scrollController: scrollController) : SafeArea(
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
              return  CustomScrollView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [

                  const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeSmall)),

                  SliverPersistentHeader(pinned: true,
                    delegate: SliverDelegate(extentSize: 55,
                      child: InkWell(onTap: () => Get.toNamed(RouteHelper.getSearchResultRoute()),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: Dimensions.paddingSizeDefault,
                            right: Dimensions.paddingSizeDefault,
                            top: Dimensions.paddingSizeExtraSmall,
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: Dimensions.paddingSizeDefault,
                                right: Dimensions.paddingSizeExtraSmall),
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
                                padding: const EdgeInsets.only(right: Dimensions.paddingSizeEight),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeExtraLarge)),),
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
                    child: Center(child: SizedBox(width: Dimensions.webMaxWidth, child: Column(children: [
                      const BannerView(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: CategoryView(),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                      const RandomCampaignView(),

                      const SizedBox(height: Dimensions.paddingSizeLarge),
                      const RecommendedServiceView(),

                      if(Get.find<SplashController>().configModel.content?.directProviderBooking==1)
                      const HomeRecommendProvider(),

                      if(Get.find<SplashController>().configModel.content!.biddingStatus == 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: HomeCreatePostView(),
                      ),

                      HorizontalScrollServiceView(fromPage: 'popular_services',serviceList: serviceController.popularServiceList),
                      if(Get.find<AuthController>().isLoggedIn())
                      HorizontalScrollServiceView(fromPage: 'recently_view_services',serviceList: serviceController.recentlyViewServiceList),
                      //CampaignView(),
                      HorizontalScrollServiceView(fromPage: 'trending_services',serviceList: serviceController.trendingServiceList),

                      const SizedBox(height: Dimensions.paddingSizeDefault,),

                      const FeatheredCategoryView(),

                      (ResponsiveHelper.isMobile(context) || ResponsiveHelper.isTab(context))?  Padding(
                        padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, 15, Dimensions.paddingSizeDefault,  Dimensions.paddingSizeSmall,),
                        child: TitleWidget(
                          title: 'all_service'.tr,
                          onTap: () => Get.toNamed(RouteHelper.allServiceScreenRoute("all_service")),
                        ),
                      ) :const SizedBox.shrink(),

                      PaginatedListView(
                        scrollController: scrollController,
                        totalSize: serviceController.serviceContent != null ? serviceController.serviceContent!.total! : null,
                        offset: serviceController.serviceContent != null ? serviceController.serviceContent!.currentPage != null ? serviceController.serviceContent!.currentPage! : null : null,
                        onPaginate: (int offset) async => await serviceController.getAllServiceList(offset, false),
                        showBottomSheet: true,
                        itemView: ServiceViewVertical(
                          service: serviceController.serviceContent != null ? serviceController.allService : null,
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault,
                            vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0,
                          ),
                          type: 'others',
                          noDataType: NoDataType.home,
                        ),
                      ),
                    ]))),
                  ),
                ],
              );
            }),
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


class FooterButton extends StatelessWidget {
  final String title;
  final String route;
  final bool url;
  const FooterButton({super.key, required this.title, required this.route, this.url = false});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return InkWell(
        hoverColor: Colors.transparent,
        onTap: route.isNotEmpty ? () async {
          if(url) {
            if(await canLaunchUrlString(route)) {
              launchUrlString(route, mode: LaunchMode.externalApplication);
            }
          }else {
            Get.toNamed(route);
          }
        } : null,
        child: Text(title, style: hovered ? ubuntuMedium.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontSize: 100)
            : ubuntuRegular.copyWith(
            color: Colors.black,
            fontSize: Dimensions.fontSizeExtraSmall)),
      );
    });
  }
}
