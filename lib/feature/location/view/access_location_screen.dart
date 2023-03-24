import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/feature/web_landing/web_landing_screen.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/core_export.dart';

class AccessLocationScreen extends StatelessWidget {
  final bool? fromSignUp;
  final bool? fromHome;
  final String? route;
  AccessLocationScreen({@required this.fromSignUp, @required this.fromHome, @required this.route});

  @override
  Widget build(BuildContext context) {
    if(!fromHome! && Get.find<LocationController>().getUserAddress() != null) {
      print(Get.find<LocationController>().getUserAddress());
      Future.delayed(Duration(milliseconds: 500), () {
        Get.dialog(CustomLoader(), barrierDismissible: false);
        Get.find<LocationController>().autoNavigate(
          Get.find<LocationController>().getUserAddress()!, fromSignUp!, route!, route != null,
        );
      });
    }
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn) {
      Get.find<LocationController>().getAddressList();
    }

    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(title: 'set_location'.tr, isBackButtonExist: fromHome),
      body: SafeArea(child: Center(
        child: GetBuilder<LocationController>(builder: (locationController) {
          return (ResponsiveHelper.isDesktop(context) && locationController.getUserAddress() == null) ? WebLandingPage(fromSignUp: fromSignUp, fromHome: fromHome, route: route) :
          Column(
            children: [
              Expanded(
                child: FooterBaseView(
                  isCenter: (! _isLoggedIn || locationController.addressList == null || locationController.addressList!.length == 0),
                  child: SizedBox(
                    width:Dimensions.WEB_MAX_WIDTH,
                    child: WebShadowWrap(
                      child: _isLoggedIn ? Padding(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            locationController.addressList != null ? locationController.addressList!.length > 0 ?
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: locationController.addressList!.length,
                              itemBuilder: (context, index) {
                                return Center(child: SizedBox(width: 700, child: AddressWidget(
                                  address: locationController.addressList![index],
                                  fromAddress: false,
                                  onTap: () async {
                                    Get.dialog(CustomLoader(), barrierDismissible: false);
                                    AddressModel _address = locationController.addressList![index];
                                    await locationController.setAddressIndex(_address,fromAddressScreen: false);
                                    locationController.saveAddressAndNavigate(_address, fromSignUp!, route != null ? route:null, route != null);
                                  },
                                )));
                              },
                            ):
                            NoDataScreen(text: 'no_saved_address_found'.tr,type: NoDataType.ADDRESS,) :
                            Center(child: CircularProgressIndicator()),
                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                            if(ResponsiveHelper.isDesktop(context))
                              BottomButton(locationController: locationController, fromSignUp: fromSignUp!, route: route),
                          ],
                        ),
                      ):

                      Center(child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Center(child: SizedBox(
                            width: 700,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Images.mapLocation, height: 240),
                                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                  Text(
                                    'find_services_near_you'.tr,
                                    textAlign: TextAlign.center,
                                    style: ubuntuMedium.copyWith(
                                        fontSize: Dimensions.fontSizeExtraLarge,
                                        color:Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).colorScheme.primary),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                                    child: Text(
                                      'please_select_you_location_to_start_exploring_available_services_near_you'.tr,
                                      textAlign: TextAlign.center,
                                      style: ubuntuRegular.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color:Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).colorScheme.primary
                                      ),),),
                                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                                  if(ResponsiveHelper.isDesktop(context))
                                    BottomButton(locationController: locationController, fromSignUp: fromSignUp!, route: route??''),
                                ]))),
                      )),
                    ),
                  ),
                ),
              ),
              if(!ResponsiveHelper.isDesktop(context))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  child: BottomButton(locationController: Get.find<LocationController>(), fromSignUp: fromSignUp!, route: route),
                ),
            ],
          );
        }
        ),
      ),
      )
    );
  }
}

class BottomButton extends StatelessWidget {
  final LocationController locationController;
  final bool fromSignUp;
  final String? route;
  BottomButton({required this.locationController, required this.fromSignUp, required this.route});

  @override
  Widget build(BuildContext context) {
    return Center(child: SizedBox(width: GetPlatform.isMobile && ResponsiveHelper.isTab(context) ? MediaQuery.of(context).size.width-40 : 700, child: Column(children: [

      CustomButton(
        buttonText: 'use_current_location'.tr,
        fontSize: Dimensions.fontSizeSmall,
        onPressed: () async {
          if(isRedundentClick(DateTime.now())){
            return;
          }
          _checkPermission(() async {
            Get.dialog(CustomLoader(), barrierDismissible: false);
            AddressModel _address = await Get.find<LocationController>().getCurrentLocation(true);
            ZoneResponseModel _response = await locationController.getZone(_address.latitude!, _address.longitude!, false);
            if(_response.isSuccess) {

              locationController.saveAddressAndNavigate(_address, fromSignUp, route != null ? route! : '', route != null);
            }else {
              Get.back();
              Get.toNamed(RouteHelper.getPickMapRoute(route == null ? RouteHelper.accessLocation : route!, route != null, 'false'), );
              customSnackBar('service_not_available_in_current_location'.tr);
            }
          });
        },
        icon: Icons.my_location,
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

      TextButton(
        style: TextButton.styleFrom(
            minimumSize: Size(Dimensions.WEB_MAX_WIDTH, 40),
            padding: EdgeInsets.zero,
            backgroundColor: Get.isDarkMode? Colors.grey.withOpacity(0.2):Theme.of(context).primaryColorLight
        ),

        onPressed: () {
          if(isRedundentClick(DateTime.now())){
            return;
          }
          Get.toNamed(RouteHelper.getPickMapRoute(
              route == null ? fromSignUp ? RouteHelper.signUp : RouteHelper.accessLocation : route!, route != null, 'false'
          ));
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_EXTRA_SMALL,left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Icon(Icons.location_pin, color: Get.isDarkMode? Colors.white: Theme.of(context).primaryColor),
          ),
          Text('set_from_map'.tr, textAlign: TextAlign.center, style: ubuntuMedium.copyWith(
            color:Get.isDarkMode? Colors.white: Theme.of(context).primaryColor,
            fontSize: Dimensions.fontSizeSmall,
          )),
        ]),
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
    ])));
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied ) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      customSnackBar('you_have_to_allow'.tr);
    }else if(permission == LocationPermission.deniedForever) {
      Get.dialog(PermissionDialog());
    }else {
      onTap();
    }
  }
}

