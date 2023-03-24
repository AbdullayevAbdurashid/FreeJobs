import 'package:demandium/components/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/core_export.dart';

class AddressScreen extends GetView<LocationController> {
  final String fromPage;
  const AddressScreen({Key? key,required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'my_address'.tr),
        endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
        floatingActionButton: (!ResponsiveHelper.isDesktop(context) &&  Get.find<AuthController>().isLoggedIn()) ?  GestureDetector(
        child: Container(
            decoration: BoxDecoration(
                boxShadow:Get.isDarkMode ? null: shadow,
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_MORE_LARGE)
            ),
            height: Dimensions.ADD_ADDRESS_HEIGHT,
            width: Dimensions.ADD_ADDRESS_WIDTH,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Colors.white,size: 20,),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                Text('add_address'.tr,style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).primaryColorLight),),
              ],
            )),
        onTap:() {
          Get.toNamed(RouteHelper.getAddAddressRoute(fromPage == 'checkout' ? true : false));
        },
      ) : null,
      body: GetBuilder<LocationController>(
          initState: (state) {
           // Get.find<LocationController>().getAddressList();
            },
          builder: (locationController) {
            List<AddressModel>? _addressList = locationController.addressList;
            List<AddressModel>? zoneBasedAddress = [];
           if(_addressList != null && _addressList.length > 0 ){
              zoneBasedAddress =  _addressList.where((element) => element.zoneId == Get.find<LocationController>().getUserAddress()!.zoneId).toList();
           }
           if(fromPage == "checkout"){
             _addressList = zoneBasedAddress;
           }
            return FooterBaseView(
              isCenter: (_addressList == null || _addressList.length == 0),
                child: WebShadowWrap(
                  child: _addressList == null ? Center(child: CircularProgressIndicator()) :
                   _addressList.length > 0 ?  RefreshIndicator(
                    onRefresh: () async {
                      await locationController.getAddressList();
                    },
                    child: SizedBox(
                      width: Dimensions.WEB_MAX_WIDTH,
                      child: Column(
                        children: [
                          ResponsiveHelper.isDesktop(context) ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButton(
                                width: 200,
                                buttonText: 'add_address'.tr,
                                onPressed: () => Get.toNamed(RouteHelper.getAddAddressRoute(true)),
                              ),
                            ],
                          ):
                          SizedBox(),
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: ResponsiveHelper.isMobile(context) ?  1 :  2,
                              childAspectRatio:ResponsiveHelper.isMobile(context) ?  4 : 6,
                              crossAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                              mainAxisExtent: Dimensions.ADDRESS_ITEM_HEIGHT,
                              mainAxisSpacing:ResponsiveHelper.isDesktop(context) || ResponsiveHelper.isTab(context) ? Dimensions.PADDING_SIZE_EXTRA_LARGE: 2.0,
                              // mainAxisSpacing: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                            ),

                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            itemCount: _addressList.length + 1,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                onDismissed: (dir) {
                                  showDialog(
                                    context: context, builder: (context) => CustomLoader(), barrierDismissible: false,
                                  );
                                  locationController.deleteUserAddressByID(
                                    _addressList![index],
                                  ).then((response) {
                                    Navigator.pop(context);
                                    customSnackBar(response.message!.tr,isError:false);
                                  });
                                },
                                child: _addressList!.length + 1 == index + 1 ?
                                Container() :
                                AddressWidget(
                                  address: _addressList[index],
                                  fromAddress: true,
                                  fromCheckout: fromPage == 'checkout' ? true : false,
                                  onTap: () async {
                                    if(fromPage == 'checkout'){
                                      if(isRedundentClick(DateTime.now())){
                                        return;
                                      }
                                      await locationController.setAddressIndex(_addressList![index]).then((isSuccess){
                                        Get.back();
                                        if(!isSuccess){
                                          customSnackBar('this_service_not_available'.tr);
                                        }
                                      });
                                    }
                                  },

                                  onEditPressed: () {
                                    Get.toNamed(
                                        RouteHelper.getEditAddressRoute(_addressList![index]));
                                  },
                                  onRemovePressed: () {
                                    if (Get.isSnackbarOpen) {
                                      Get.back();
                                    }
                                    Get.dialog(ConfirmationDialog(
                                      icon: Images.warning,
                                      description: 'are_you_sure_want_to_delete_address'.tr,
                                      onYesPressed: () {
                                        Get.back();
                                        Get.dialog(
                                          CustomLoader(), barrierDismissible: false,
                                        );
                                        locationController.deleteUserAddressByID(_addressList![index],
                                        ).then((response) {Get.back();
                                        customSnackBar(response.message!.tr,isError:false);
                                        });
                                      },
                                    ));
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ) :
                  NoDataScreen(text: 'no_address_found'.tr,type: NoDataType.ADDRESS,),
                ));
            })
    );
  }
}




