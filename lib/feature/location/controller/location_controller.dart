import 'dart:convert';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/location/model/place_details_model.dart';

enum Address {service, billing }
enum AddressLabel {home, office, others }
class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  Position _position = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
  Position _pickPosition = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
  bool _loading = false;
  String _address = '';
  String _pickAddress = '';
  List<Marker> _markers = <Marker>[];
  List<AddressModel>? _addressList;
  int _addressLabelIndex = 0;
  AddressModel? _selectedAddress;
  bool _isLoading = false;
  bool _inZone = false;
  String _zoneID = '';
  bool _buttonDisabled = true;
  bool _changeAddress = true;
  GoogleMapController? _mapController;
  List<PredictionModel> _predictionList = [];
  bool _updateAddAddressData = true;
  Address _selectedAddressType = Address.service;
  AddressLabel _selectedAddressLabel = AddressLabel.home;


  List<PredictionModel> get predictionList => _predictionList;
  bool get isLoading => _isLoading;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  String get address => _address;
  String get pickAddress => _pickAddress;
  List<Marker> get markers => _markers;
  List<AddressModel>? get addressList => _addressList;
  int get addressLabelIndex => _addressLabelIndex;
  bool get inZone => _inZone;
  String get zoneID => _zoneID;
  bool get buttonDisabled => _buttonDisabled;
  GoogleMapController get mapController => _mapController!;
  ///address type like billing , shipping
  Address get selectedAddressType => _selectedAddressType;
  AddressLabel get selectedAddressLabel => _selectedAddressLabel;
  AddressModel? get selectedAddress => _selectedAddress;


  Future<AddressModel> getCurrentLocation(bool fromAddress, {GoogleMapController? mapController, LatLng? defaultLatLng, bool notify = true}) async {
    _loading = true;
    if(notify) {
      update();
    }
    AddressModel _addressModel;
    Position _myPosition;
    try {
      Geolocator.requestPermission();
      Position newLocalData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _myPosition = newLocalData;
    }catch(e) {
      if(defaultLatLng != null){
        _myPosition = Position(
          latitude:defaultLatLng.latitude,
          longitude:defaultLatLng.longitude,
          timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1,
        );
      }else{
        _myPosition = Position(
          latitude:  Get.find<SplashController>().configModel.content!.defaultLocation!.location!.lat ?? 0.0,
          longitude: Get.find<SplashController>().configModel.content!.defaultLocation!.location!.lon ?? 0.0,
          timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1,
        );
      }

    }
    if(fromAddress) {
      _position = _myPosition;
    }else {
      _pickPosition = _myPosition;
    }
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(_myPosition.latitude, _myPosition.longitude), zoom: 16),
      ));
    }
    String _addressFromGeocode = await getAddressFromGeocode(LatLng(_myPosition.latitude, _myPosition.longitude));
    fromAddress ? _address = _addressFromGeocode : _pickAddress = _addressFromGeocode;
    ZoneResponseModel _responseModel = await getZone(_myPosition.latitude.toString(), _myPosition.longitude.toString(), true);
    _buttonDisabled = !_responseModel.isSuccess;
    _addressModel = AddressModel(
      latitude: _myPosition.latitude.toString(), longitude: _myPosition.longitude.toString(), addressType: 'others',
      zoneId: _responseModel.isSuccess ? _responseModel.zoneIds : '',
      address: _addressFromGeocode,
    );
    _loading = false;
    update();
    return _addressModel;
  }

  Future<ZoneResponseModel> getZone(String lat, String long, bool markerLoad) async {
    _isLoading = true;
    update();
    ZoneResponseModel _responseModel;
    Response response = await locationRepo.getZone(lat, long);
    if(response.statusCode == 200 && response.body['content'] != null) {
      _inZone = true;
      _zoneID = response.body['content']['id'];
      _responseModel = ZoneResponseModel(true, '',_zoneID);
    }else {
      _inZone = false;
      _responseModel = ZoneResponseModel(false, response.statusText, '');
    }
    _isLoading = false;
    print("from_get_zone:$_isLoading");
    update();
    return _responseModel;
  }

  void updatePosition(CameraPosition position, bool fromAddress, {bool formCheckout = false}) async {
    if(_updateAddAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            latitude: position.target.latitude, longitude: position.target.longitude, timestamp: DateTime.now(),
            heading: 1, accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: position.target.latitude, longitude: position.target.longitude, timestamp: DateTime.now(),
            heading: 1, accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1,
          );
        }
        ZoneResponseModel _responseModel = await getZone(position.target.latitude.toString(), position.target.longitude.toString(), true);
        if( formCheckout && !_responseModel.zoneIds.contains(getUserAddress()?.zoneId)){
          Get.dialog(
            ConfirmationDialog(
                description: null, icon: null, onYesPressed: null,
                widget: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text('this_service_not_available'.tr),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  CustomButton(buttonText: 'ok'.tr, onPressed: ()=> Get.back()),
                ],)),
          );

        }else{
          if(_responseModel.isSuccess) {
            _buttonDisabled = false;
          }
        }
        if (_changeAddress) {
          String _addressFromGeocode = await getAddressFromGeocode(LatLng(position.target.latitude, position.target.longitude));
          fromAddress ? _address = _addressFromGeocode : _pickAddress = _addressFromGeocode;
        } else {
          _changeAddress = true;
        }
      } catch (e) {}
    }else {
      _updateAddAddressData = true;
    }
    _loading = false;
    update();
  }

  Future<ResponseModel> deleteUserAddressByID(AddressModel address) async {
    ResponseModel _responseModel = ResponseModel(false, 'address_delete_failed'.tr);
    Response response = await locationRepo.removeAddressByID([address.id!]);
    if (response.statusCode == 200) {
      _addressList!.removeAt(_addressList!.indexOf(address));
      _responseModel = ResponseModel(true, response.body['response_code']);
    } else {
      _responseModel = ResponseModel(false, response.statusText);
    }
    update();
    return _responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = <AddressModel>[];
      response.body['content'].forEach((address) {
        _addressList!.add(AddressModel.fromJson(address));
      });
    } else {
      ApiChecker.checkApi(response);
    }
    _addressList =_addressList != null ?  _addressList!.reversed.toList() : null;
    _isLoading = false;
    _addLocalAddress();
    update();
  }

  _addLocalAddress() {
    final _userModel = Get.find<UserController>().userInfoModel;
    AddressModel _addressModel = AddressModel(
      id: getUserAddress()?.id,
      addressLabel: 'OTHERS',
      city: '',
      street: '',
      zipCode: '',
      addressType: 'service',
      country: Get.find<SplashController>().configModel.content?.country,
      contactPersonName: '${_userModel.fName} ${_userModel.lName}',
      contactPersonNumber: '${_userModel.phone}',
      address: getUserAddress()?.address,
      latitude: getUserAddress()?.latitude,
      longitude: getUserAddress()?.longitude,
      zoneId: getUserAddress()?.zoneId,
      userId: getUserAddress()?.userId,
    );

    if(getUserAddress() != null){
      bool _isAddressContain =_addressList != null ?  _addressList!.where((element) => element.address == getUserAddress()?.address).isNotEmpty:false;
      if(!_isAddressContain){
        addAddress(_addressModel,false);
      }else{
        _selectedAddress = _addressList!.where((element) => element.address == getUserAddress()?.address).first;
      }
    }
  }

  Future<void> addAddress(AddressModel addressModel, bool _fromAddAddressScreen) async {
    print("addressModel:${addressModel.toString()}");
    _isLoading = true;
    Response response = await locationRepo.addAddress(addressModel);
    if (response.body["response_code"] == "default_store_200") {
      _selectedAddress = AddressModel.fromJson(response.body["content"]);
      getAddressList();
        if(_fromAddAddressScreen){
          Get.back();
          customSnackBar('new_address_added_successfully'.tr, isError: false);
        }else{
          print(AddressModel.fromJson(response.body["content"]));
          await saveUserAddress(AddressModel.fromJson(response.body["content"]));
        }
    } else {
      customSnackBar(response.statusText == 'out_of_coverage'.tr ? 'service_not_available_in_this_area'.tr : response.statusText, isError: false);
    }
    _isLoading = true;
    update();
  }

  Future<ResponseModel> updateAddress(AddressModel addressModel, int addressId) async {
    _isLoading = true;
    update();
    Response response = await locationRepo.updateAddress(addressModel, addressId);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      getAddressList();
      responseModel = ResponseModel(true, response.body["response_code"]);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
  Future<bool> saveUserAddress(AddressModel address) async {
    String userAddress = jsonEncode(address.toJson());
    return await locationRepo.saveUserAddress(userAddress, address.zoneId != null ?  address.zoneId : null);
  }
  AddressModel? getUserAddress() {
    AddressModel? _addressModelUser;
    try {
      _addressModelUser = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()!));
    }catch(e){
      return _addressModelUser;
    }
    return _addressModelUser;
  }


  Future<void> saveAddressAndNavigate(AddressModel address, bool fromSignUp, String? route, bool canRoute) async {
    print("save_address_and_navigate");
    ZoneResponseModel _responseModel = await getZone(address.latitude.toString(), address.longitude.toString(), true);

    if((getUserAddress() != null && getUserAddress()!.zoneId != null)? !_responseModel.zoneIds.contains(getUserAddress()!.zoneId) : true && Get.find<CartController>().cartList.length > 0) {
      Get.dialog(ConfirmationDialog(
        icon: Images.warning, title: 'are_you_sure_to_reset'.tr, description: 'if_you_change_location'.tr,
        onYesPressed: () {
          Get.back();
          _setZoneData(address, fromSignUp, route, canRoute,true, _responseModel.zoneIds);
        },
        onNoPressed: () {
          Get.back();
          Get.back();
        },
      ));
    }else {
      print("inside_set_zone");
      _setZoneData(address, fromSignUp, route != null ? route : null, canRoute,false, _responseModel.zoneIds);
    }
  }

  void _setZoneData(AddressModel address, bool fromSignUp, String? route, bool canRoute,bool shouldCartDelete, String? zoneIds) {
    if(zoneIds != null){
      Get.find<CartController>().clearCartList();
      address.zoneId = zoneIds;
      autoNavigate(address, fromSignUp, route != null ? route: null, canRoute);
    }

  }

  void autoNavigate(AddressModel address, bool fromSignUp, String? route, bool canRoute) async {
    print("inside_auth_navigate");
    if(!GetPlatform.isWeb){
      if(getUserAddress() != null){
        if (getUserAddress()!.zoneId != address.zoneId) {
          FirebaseMessaging.instance.unsubscribeFromTopic('zone_${getUserAddress()!.zoneId}_customer');
          FirebaseMessaging.instance.subscribeToTopic('zone_${address.zoneId}_customer');
        }
      }
      else {
        FirebaseMessaging.instance.subscribeToTopic('zone_${address.zoneId}_customer');
      }
    }
    await saveUserAddress(address);
    HomeScreen.loadData(true);
    print("Route:============================>$route");
    if(canRoute) {
      Get.offAllNamed(route!);
    }else {
      Get.offAllNamed(RouteHelper.getInitialRoute());
    }
    await Get.find<CartController>().removeAllCartItem();
  }

  Future<AddressModel> setLocation(String placeID, String address, GoogleMapController? mapController) async {
    _loading = true;
    update();

    LatLng _latLng = LatLng(0, 0);
    Response response = await locationRepo.getPlaceDetails(placeID);
    if(response.statusCode == 200) {
      PlaceDetailsModel _placeDetails = PlaceDetailsModel.fromJson(response.body);
      if(_placeDetails.content!.status == 'OK') {
        _latLng = LatLng(_placeDetails.content!.result!.geometry!.location!.lat!, _placeDetails.content!.result!.geometry!.location!.lng!);
      }
    }

    _pickPosition = Position(
      latitude: _latLng.latitude, longitude: _latLng.longitude,
      timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1,
    );

    _pickAddress = address;
    _changeAddress = false;
    if(mapController != null){
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _latLng, zoom: 17)));
    }
    _loading = false;
    update();
    AddressModel _address = AddressModel(
      latitude: pickPosition.latitude.toString(),
      longitude: pickPosition.longitude.toString(),
      addressType: 'others', address: pickAddress,
    );
    return _address;
  }

  void disableButton() {
    _buttonDisabled = true;
    _inZone = true;
    update();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _address = _pickAddress;
    _updateAddAddressData = false;
    update();
  }

  void setUpdateAddress(AddressModel address){
    _position = Position(
      latitude: double.parse(address.latitude!), longitude: double.parse(address.longitude!), timestamp: DateTime.now(),
      altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, floor: 1, accuracy: 1,
    );
    _address = address.address!;
  }

  void updateAddressType(Address address){
    _selectedAddressType = address;
    update();
  }

  void updateAddressLabel({AddressLabel? addressLabel,String addressLabelString = ''}){
    if(addressLabel == null) {
      _selectedAddressLabel = _getAddressLabel(addressLabelString);
    }else{
      _selectedAddressLabel = addressLabel;
      update();
    }
  }

  AddressLabel _getAddressLabel(String addressLabel) {
    late AddressLabel _label;
    if(AddressLabel.home.name.contains(addressLabel)) {
      _label = AddressLabel.home;
    }else if(AddressLabel.office.name.contains(addressLabel)){
      _label = AddressLabel.office;
    }else{
      _label = AddressLabel.others;
    }

    return _label;
  }


  ///set address index to select address from address list
  Future<bool> setAddressIndex(AddressModel address,{bool fromAddressScreen = true}) async {
    bool _isSuccess = false;
    if(fromAddressScreen){
      ZoneResponseModel _selectedZone = await  getZone('${address.latitude}', '${address.longitude}', false);
      if(_selectedZone.zoneIds.contains(getUserAddress()?.zoneId)) {
        _selectedAddress = address;

        print("selected address : ${_selectedAddress!.id}");
        update();
        _isSuccess = true;
      }
    }else{
      _selectedAddress = address;
      update();
      _isSuccess = true;
    }
    return _isSuccess;
  }

  void resetAddress(){
    _address = '';
  }

  void setPickData() {
    _pickPosition = _position;
    _pickAddress = _address;
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    String _address = 'Unknown Location Found';
    if(response.statusCode == 200 && response.body['content']['status'] == 'OK') {
      _address = response.body['content']['results'][0]['formatted_address'].toString();
    }else {
      customSnackBar(response.body['errors'][0]['message'] ?? response.bodyString);
    }
    print("getAddressFromGeocode_address:$_address");
    return _address;
  }

  Future<List<PredictionModel>> searchLocation(BuildContext context, String text) async {
    if(text.isNotEmpty) {
      Response response = await locationRepo.searchLocation(text);
      if (response.body['response_code'] == "default_200" && response.body['content']['status'] == 'OK') {
        _predictionList = [];
        response.body['content']['predictions'].forEach((prediction) => _predictionList.add(PredictionModel.fromJson(prediction)));
      } else {
        customSnackBar(response.body['message'] ?? response.bodyString,isError:false);
      }
    }
    return _predictionList;
  }

  void setPlaceMark(String address) {
    _address = address;
  }


}
