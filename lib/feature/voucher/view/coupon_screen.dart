import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/voucher/controller/coupon_controller.dart';
import 'package:demandium/feature/voucher/widgets/voucher.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> with TickerProviderStateMixin{
  TabController? _couponTabController;


  @override
  initState() {
    _couponTabController = TabController(vsync: this, length: 2, initialIndex: 0);
    Get.find<CouponController>().getCouponList();
    _couponTabController?.addListener(() {
      Get.find<CouponController>().updateTabBar(
        _couponTabController?.index == 0 ?  CouponTabState.CURRENT_COUPON : CouponTabState.USED_COUPON,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(
        title: "voucher".tr,
        centerTitle: true,
        isBackButtonExist: true,
      ),
      body: GetBuilder<CouponController>(
          builder: (couponController){
            List<CouponModel>? activeCouponList = couponController.activeCouponList;
            List<CouponModel>? expiredCouponList = couponController.expiredCouponList;
            return FooterBaseView(
              isScrollView: ResponsiveHelper.isWeb()?true:false,
              isCenter: (activeCouponList == null || activeCouponList.length == 0),
              child: WebShadowWrap(
                child: Container(
                    child: ((activeCouponList != null && activeCouponList.length == 0) && (expiredCouponList != null && expiredCouponList.length == 0)) ?
                    NoDataScreen(text: "no_coupon_found".tr,type: NoDataType.COUPON):
                    (activeCouponList != null && expiredCouponList!=null) ?
                    Column(children: [
                      if(activeCouponList.length > 0 || expiredCouponList.length > 0)
                        Stack(
                          children: [
                            Container(
                              width: Get.width,
                              height: 91,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  image: AssetImage(Images.offerBanner),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              height: 91,
                              color: Colors.black54,
                              width: Get.width,
                            ),
                          ],
                        ),

                      TabBar(
                        controller: _couponTabController,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorWeight: 3,
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Get.isDarkMode?Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5):Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        labelColor: Get.isDarkMode?Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8):Theme.of(context).primaryColor,
                        unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),
                        unselectedLabelStyle: ubuntuMedium.copyWith(
                          color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge,
                        ),

                        labelStyle: ubuntuRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).primaryColor,
                        ),
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                            child: Text(
                              'current_voucher'.tr,
                              style: ubuntuMedium,
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                            child: Text('used_voucher'.tr,
                              style: ubuntuMedium,),
                          ),
                        ],
                      ),
                      Container(height: 1,color: Theme.of(context).hintColor),
                      if(!ResponsiveHelper.isWeb())
                      Expanded(
                        child: TabBarView(
                          controller: _couponTabController,
                            children: [
                          _couponList(context, activeCouponList),
                          _couponList(
                              context, expiredCouponList,isExpired: true
                          )
                        ]),
                      ),
                      if(ResponsiveHelper.isWeb())
                      _couponTabController?.index == 0?
                      _couponList(
                        context, activeCouponList
                      ):_couponList(
                          context, expiredCouponList,isExpired: true
                      ),
                    ],): Center(child: CircularProgressIndicator(),)),
              ),
            );
          }

      ),
    );
  }

  Widget _couponList(BuildContext context, List<CouponModel> couponList,{bool isExpired = false}) {
    return couponList.length > 0 ?
    Container(
        child: GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: Dimensions.PADDING_SIZE_LARGE,
            mainAxisSpacing: ResponsiveHelper.isDesktop(context) ?
            Dimensions.PADDING_SIZE_LARGE : Dimensions.PADDING_SIZE_SMALL,
            childAspectRatio: ResponsiveHelper.isMobile(context) ? 3.2 : 4,
            crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : 2,
            mainAxisExtent:Get.find<LocalizationController>().isLtr ?  130 : 140,
          ),
          itemBuilder: (context, index) {
            return Voucher(
              isExpired: isExpired,
              couponModel: couponList[index],
            );
          },
          itemCount: couponList.length,
        )
    ) : SizedBox(
        height:Get.height*0.6,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text(
              isExpired?'no_expired_coupon_found'.tr:'no_active_coupon_found'.tr,
            ),
          ),
        ),
    );
  }
}
