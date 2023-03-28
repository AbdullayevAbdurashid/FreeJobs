import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/feature/service/model/feathered_service_model.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/service_widget_vertical.dart';
import 'package:demandium/core/core_export.dart';

class AllFeatheredCategoryServiceView extends StatefulWidget {
  final String fromPage;
  final CategoryData categoryData;
  AllFeatheredCategoryServiceView({required this.fromPage,required this.categoryData});

  @override
  State<AllFeatheredCategoryServiceView> createState() => _AllFeatheredCategoryServiceViewState();
}

class _AllFeatheredCategoryServiceViewState extends State<AllFeatheredCategoryServiceView> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(
        title:widget.fromPage ,showCart: true,),
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      body: _buildBody(widget.fromPage,context,scrollController),
    );
  }

  Widget _buildBody(String fromPage,BuildContext context,ScrollController scrollController){
    return GetBuilder<ServiceController>(

      builder: (serviceController){
        return _buildWidget( widget.categoryData.servicesByCategory ,context);
      },
    );

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

              if(ResponsiveHelper.isDesktop(context))
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.fontSizeDefault,
                      Dimensions.PADDING_SIZE_DEFAULT,
                      Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: TitleWidget(
                      title: widget.categoryData.name??"",
                    ),
                  ),
                ),

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

