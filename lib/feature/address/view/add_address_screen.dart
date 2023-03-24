import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class AddAddressScreen extends StatefulWidget {
  final bool fromCheckout;
  final AddressModel? address;
  AddAddressScreen({required this.fromCheckout, this.address});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _serviceAddressController = TextEditingController();
  final TextEditingController _contactPersonNameController = TextEditingController();
  final TextEditingController _contactPersonNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final FocusNode _serviceAddressNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _countryNode = FocusNode();
  final FocusNode _streetNode = FocusNode();
  final FocusNode _zipNode = FocusNode();
  final FocusNode _numberNode = FocusNode();
  LatLng? _initialPosition;
  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _cameraPosition;

  @override
  void initState() {
    super.initState();
    Get.find<LocationController>().resetAddress();
    if(widget.address != null) {
      _serviceAddressController.text = widget.address!.address!;
      _contactPersonNameController.text = widget.address!.contactPersonName!;
      _contactPersonNumberController.text = widget.address!.contactPersonNumber!;
      _cityController.text = widget.address!.city ?? '';
      _countryController.text = widget.address!.country ?? '';
      _streetController.text = widget.address!.street ?? 'street'.toString();
      _zipController.text = widget.address!.zipCode ?? '';
      Get.find<LocationController>().updateAddressLabel(addressLabelString: widget.address!.addressLabel);

    }else{
      Get.find<LocationController>().updateAddressLabel(addressLabelString: 'home'.tr);
    }

    if(widget.address == null) {
      _countryController.text = Get.find<SplashController>().configModel.content?.userLocationInfo?.countryName ?? '';
      _initialPosition = LatLng(
        Get.find<SplashController>().configModel.content!.defaultLocation!.location!.lat ?? 0.0,
        Get.find<SplashController>().configModel.content!.defaultLocation!.location!.lon ?? 0.0,
      );

    }else {
      Get.find<LocationController>().setUpdateAddress(widget.address!);
      _initialPosition = LatLng(
        double.parse(widget.address!.latitude ?? '0'),
        double.parse(widget.address!.longitude ?? '0'),
      );
    }
  }

  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.address == null ? 'add_new_address'.tr : 'update_address'.tr),
      body:  GetBuilder<UserController>(builder: (userController) {
        return GetBuilder<LocationController>(builder: (locationController) {
          return Form(
            key: addressFormKey,
            child: Column(children: [
              Expanded(child: Scrollbar(child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL),
                child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      child: Stack(clipBehavior: Clip.none, children: [
                        if(_initialPosition != null)
                          GoogleMap(
                            minMaxZoomPreference: MinMaxZoomPreference(0, 16),
                            onTap: (latLng) {
                              Get.toNamed(
                                RouteHelper.getPickMapRoute('add-address', false,  '${widget.fromCheckout}'),
                                arguments: PickMapScreen(
                                  fromAddAddress: true, fromSignUp: false, googleMapController: locationController.mapController,
                                  route: '', canRoute: false, formCheckout: widget.fromCheckout,
                                ),
                              );
                            },
                            initialCameraPosition: CameraPosition(
                              target: _initialPosition!,
                              zoom: 14.4746,
                            ),
                            zoomControlsEnabled: false,
                            onCameraIdle: () {
                              try{
                                locationController.updatePosition(_cameraPosition!, true, formCheckout: widget.fromCheckout);
                              }catch(error){
                                print('error : $error');
                              }
                            },
                            onCameraMove: ((position) => _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                              controller.setMapStyle(
                                Get.isDarkMode ? Get.find<ThemeController>().darkMap : Get.find<ThemeController>().lightMap,
                              );
                              _controller.complete(controller);

                              if(widget.address == null) {
                                locationController.getCurrentLocation(true, mapController: controller);
                              }
                            },
                          ),
                        locationController.loading ? Center(child: CircularProgressIndicator()) : SizedBox(),
                        Center(child: !locationController.loading ? Image.asset(Images.marker, height: 50, width: 50)
                            : CircularProgressIndicator()),
                        Positioned(
                          bottom: 10,
                          left:Get.find<LocalizationController>().isLtr ? null: Dimensions.PADDING_SIZE_SMALL,
                          right:Get.find<LocalizationController>().isLtr ?  0:null,
                          child: InkWell(
                            onTap: () => _checkPermission(() {
                              locationController.getCurrentLocation(true, mapController: locationController.mapController);
                            }),
                            child: Container(
                              width: 30, height: 30,
                              margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color:Theme.of(context).primaryColorLight.withOpacity(.5)),
                              child: Icon(Icons.my_location, color: Theme.of(context).primaryColor, size: 20),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left:Get.find<LocalizationController>().isLtr ? null: Dimensions.PADDING_SIZE_SMALL,
                          right:Get.find<LocalizationController>().isLtr ?  0:null,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                RouteHelper.getPickMapRoute('add-address', false, '${widget.fromCheckout}'),
                                arguments: PickMapScreen(
                                  fromAddAddress: true, fromSignUp: false, googleMapController: locationController.mapController,
                                  route: null, canRoute: false, formCheckout: widget.fromCheckout,
                                ),
                              );
                            },
                            child: Container(
                              width: 30, height: 30,
                              margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), 
                                  color: Theme.of(context).primaryColorLight.withOpacity(.5)),
                              child: Icon(Icons.fullscreen, color: Theme.of(context).primaryColor, size: 20),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  Center(
                      child: Text(
                        'add_the_location_correctly'.tr,
                        style: ubuntuRegular.copyWith(
                            color: Theme.of(context).disabledColor,
                            fontSize: Dimensions.fontSizeExtraSmall),
                  )),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  AddressLabelWidget(),

                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomTextField(
                    title: 'service_address'.tr,
                    hintText: 'service_address_hint'.tr,
                    inputType: TextInputType.streetAddress,
                    focusNode: _serviceAddressNode,
                    nextFocus: _streetNode,
                    controller: _serviceAddressController..text = locationController.address,
                    onChanged: (text) => locationController.setPlaceMark(text),
                    onValidate: (String? value){
                      return FormValidation().isValidLength(value!);
                    }
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  CustomTextField(
                    title: 'street'.tr,
                      hintText: 'street'.tr,
                      inputType: TextInputType.streetAddress,
                      focusNode: _streetNode,
                      nextFocus: _cityNode,
                      controller: _streetController,
                      onValidate: (String? value){
                        return FormValidation().isValidLength(value!);
                      }
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  CustomTextField(
                    title: 'city'.tr,
                      hintText: 'city'.tr,
                      inputType: TextInputType.streetAddress,
                      focusNode: _cityNode,
                      nextFocus: _countryNode,
                      controller: _cityController,
                      onValidate: (String? value){
                        return FormValidation().isValidLength(value!);
                      }
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  CustomTextField(
                    title: 'country'.tr,
                    hintText: 'country'.tr,
                    inputType: TextInputType.text,
                    focusNode: _countryNode,
                    inputAction: TextInputAction.next,
                    nextFocus: _zipNode,
                    controller: _countryController,
                    onValidate: (String? value){
                        return FormValidation().isValidLength(value!);
                    }
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),


                  CustomTextField(
                    title: 'zip'.tr,
                    hintText: 'zip'.tr,
                    inputType: TextInputType.number,
                    focusNode: _zipNode,
                    nextFocus: _nameNode,
                    controller: _zipController,
                    onValidate: (String? value){
                      return FormValidation().isValidLength(value!);
                    },
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  CustomTextField(
                    title: 'contact_person_name'.tr,
                    hintText: 'contact_person_name_hint'.tr,
                    inputType: TextInputType.name,
                    controller: _contactPersonNameController,
                    focusNode: _nameNode,
                    nextFocus: _numberNode,
                    capitalization: TextCapitalization.words,
                    onValidate: (String? value){
                      return FormValidation().isValidLength(value!);
                    },
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  CustomTextField(
                    title: 'contact_person_number'.tr,
                    hintText: 'contact_person_number_hint'.tr,
                    inputType: TextInputType.phone,
                    inputAction: TextInputAction.done,
                    focusNode: _numberNode,
                    controller: _contactPersonNumberController,
                    onValidate: (String? value){
                      return FormValidation().isValidLength(value!);
                    },
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                ]))),
              ))),

              Container(
                width: Dimensions.WEB_MAX_WIDTH,
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: !locationController.isLoading ? CustomButton(
                  buttonText: widget.address == null ? 'save_location'.tr : 'update_address'.tr,
                  onPressed:  () {
                    final isValid = addressFormKey.currentState!.validate();
                    if(isRedundentClick(DateTime.now())){
                      return;
                    }
                    if(isValid){
                      addressFormKey.currentState!.save();

                      AddressModel _addressModel = AddressModel(
                        id: widget.address != null ? widget.address!.id : null,
                        addressType: locationController.selectedAddressType.name,
                        addressLabel:locationController.selectedAddressLabel.name.toLowerCase(),
                        contactPersonName: _contactPersonNameController.text,
                        contactPersonNumber: _contactPersonNumberController.text,
                        address: _serviceAddressController.text,
                        city: _cityController.text,
                        zipCode: _zipController.value.text,
                        country: _countryController.text,
                        latitude: locationController.position.latitude.toString(),
                        longitude: locationController.position.longitude.toString(),
                        zoneId: locationController.zoneID,
                        street: _streetController.text,
                      );
                      if(widget.address == null) {
                        locationController.addAddress(_addressModel, true);
                      }else {
                        locationController.updateAddress(_addressModel, widget.address!.id!).then((response) {
                          if(response.isSuccess!) {
                            Get.back();
                            customSnackBar(response.message!.tr,isError: false);
                          }else {
                            customSnackBar(response.message!.tr);
                          }
                        });
                      }
                    }
                  },
                ) : Center(child: CircularProgressIndicator()),
              ),

            ]),
          );
        });
      }),
    );
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
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

