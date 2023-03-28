import 'package:demandium/feature/home/web/web_campaign_view.dart';
import 'package:demandium/feature/home/web/web_recently_service_view.dart';
import 'package:demandium/feature/home/web/web_recommended_service_view.dart';
import 'package:demandium/feature/home/web/web_trending_service_view.dart';
import 'package:demandium/feature/home/web/web_feathered_category_view.dart';
import 'package:demandium/feature/home/widget/recommended_provider.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_view.dart';
import 'package:demandium/components/paginated_list_view.dart';
import 'package:demandium/components/service_view_vertical.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/home/widget/category_view.dart';

class WebHomeScreen extends StatelessWidget {
  final ScrollController? scrollController;
  WebHomeScreen({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    Get.find<BannerController>().setCurrentIndex(0, false);
    return CustomScrollView(
      controller: scrollController,
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,)),
        SliverToBoxAdapter(
          child: Center(
            child: SizedBox(width: Dimensions.WEB_MAX_WIDTH,
              child: WebBannerView(),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),),
        SliverToBoxAdapter(child: CategoryView(),),
        SliverToBoxAdapter(
          child: Center(
            child: SizedBox(width: Dimensions.WEB_MAX_WIDTH,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                WebRecommendedServiceView(),
                SizedBox(width: Dimensions.PADDING_SIZE_LARGE,),
                Expanded(child: WebPopularServiceView()),
              ],),
            ),
          ),
        ),
        if(Get.find<AuthController>().isLoggedIn())
        SliverToBoxAdapter(
          child: Center(
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: HomeRecommendProvider(),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),),
        SliverToBoxAdapter(
          child: Center(
            child: SizedBox(width: Dimensions.WEB_MAX_WIDTH,
                child: WebTrendingServiceView()
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),),

        if(Get.find<AuthController>().isLoggedIn())
        SliverToBoxAdapter(child: Center(
          child: SizedBox(width: Dimensions.WEB_MAX_WIDTH,
            child: WebRecentlyServiceView(),
          ),
        )),
        SliverToBoxAdapter(child: SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),),

        SliverToBoxAdapter(
          child: Center(
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: Column(
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  WebCampaignView(),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
            child: SizedBox(
              width: Dimensions.WEB_MAX_WIDTH,
              child: WebFeatheredCategoryView(),
            ),
          ),
        ),

        SliverToBoxAdapter(child: Center(
          child: SizedBox(
            width: Dimensions.WEB_MAX_WIDTH,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0,
                    Dimensions.PADDING_SIZE_DEFAULT,
                    Dimensions.PADDING_SIZE_SMALL,
                  ),
                  child: TitleWidget(
                    title: 'all_service'.tr,
                  ),
                ),
                GetBuilder<ServiceController>(builder: (serviceController) {
                  return PaginatedListView(
                    scrollController: scrollController!,
                    totalSize:serviceController.serviceContent != null ?  serviceController.serviceContent!.total != null ? serviceController.serviceContent!.total! : null:null,
                    offset: serviceController.serviceContent != null ? serviceController.serviceContent!.currentPage != null ? serviceController.serviceContent!.currentPage: null : null,
                    onPaginate: (int offset) async => await serviceController.getAllServiceList(offset,false),
                    itemView: ServiceViewVertical(
                      service: serviceController.serviceContent != null ? serviceController.allService : null,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                        vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                      ),
                      type: 'others',
                      noDataType: NoDataType.HOME,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),),
        SliverToBoxAdapter(child: FooterView(),),
      ],
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}
