import 'package:demandium/feature/provider/model/provider_model.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/voucher/controller/coupon_controller.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  List<CartModel> _cartList = [];
  List<CartModel> _initialCartList = [];
  bool _isLoading = false;
  double _amount = 0.0;
  bool _isOthersInfoValid = false;
  double _totalPrice = 0;
  bool _isButton = false;

  List<CartModel> get cartList => _cartList;
  List<CartModel> get initialCartList => _initialCartList;
  double get amount => _amount;
  bool get isLoading => _isLoading;
  bool get isOthersInfoValid => _isOthersInfoValid;
  double get totalPrice => _totalPrice;
  bool get isButton => _isButton;


  List<ProviderData>? _providerList;
  List<ProviderData>? get  providerList=> _providerList;

  double _walletBalance = 0.0;
  double get walletBalance => _walletBalance;

  bool preSelectedProvider = false;
  String selectedProviderRating ='';
  String selectedProviderProfileImages ='';
  String selectedProviderName ='';
  String selectedProviderId ='';
  String subcategoryId ='';

  int selectedProviderIndex = -1;

  @override
  void onInit() {
    if (Get.find<AuthController>().isLoggedIn()) {
      getCartListFromServer();
    } else {
      getCartData();
    }
    super.onInit();
  }

  Future<List<CartModel>> getCartData() async{
    print('Get cart data is called');
    _isLoading = false;
    _cartList = [];
    _cartList.addAll(cartRepo.getCartList());
    _cartList.forEach((cart) {
      _amount = _amount + (cart.discountedPrice * cart.quantity);
    });

    _isLoading = false;
    _cartTotalCost();
    update();
    return _cartList;

  }

  _cartTotalCost() {
    _totalPrice = 0.0;
    _cartList.forEach((cartModel) {
      _totalPrice = _totalPrice + (cartModel.totalCost * cartModel.quantity) ;
    });
  }



  Future<void> getCartListFromServer({bool shouldUpdate = true})async{
    _isLoading = true;
    Response response = await cartRepo.getCartListFromServer();
    if(response.statusCode == 200){
      _cartList = [];
      response.body['content']['cart']['data'].forEach((cart){
        _cartList.add(CartModel.fromJson(cart));

      });

      if(response.body['content']['wallet_balance']!=null){
        _walletBalance = double.tryParse(response.body['content']['wallet_balance'].toString())!;
      }

      if(_cartList.length>0){
        if(_cartList[0].provider!=null){
          preSelectedProvider = true;
          selectedProviderName =  _cartList[0].provider?.companyName??"";
          selectedProviderId =  _cartList[0].provider?.id??"";
          selectedProviderProfileImages =  _cartList[0].provider?.logo??"";
          selectedProviderRating =  _cartList[0].provider?.avgRating.toString()??"";
          subcategoryId = _cartList[0].subCategoryId;
        }
      }


    }
    else{
     // ApiChecker.checkApi(response);
    }

    _totalPrice = 0.0;
    double _couponDiscount = 0.0;
    _cartList.forEach((cartModel) {
      _totalPrice = _totalPrice + cartModel.totalCost;
      _couponDiscount = _couponDiscount + cartModel.couponDiscountPrice;
    });

    if(_couponDiscount == 0) {
      Get.find<CouponController>().removeCouponData(false);
    }

    _isLoading = false;
    if(shouldUpdate){
      update();
    }
  }

  Future<void> removeCartFromServer(String cartID)async{
    _isLoading = true;
    Response response = await cartRepo.removeCartFromServer(cartID);
    if(response.statusCode == 200){
      getCartListFromServer();
    }
    _isLoading = false;
    update();
  }


  Future<void> removeAllCartItem()async{
    Response response = await cartRepo.removeAllCartFromServer();
    if(response.statusCode == 200){
      _isLoading = false;
      getCartListFromServer(shouldUpdate: false);
    }
  }

  Future<void> updateCartQuantityToApi(String cartID, int quantity)async{
    Response response = await cartRepo.updateCartQuantity(cartID, quantity);
    if(response.statusCode == 200){
      getCartListFromServer();
    }
  }

  Future<void> updateProvider()async{
    Response response = await cartRepo.updateProvider(selectedProviderId);
    if(response.statusCode == 200){
      getCartListFromServer();
    }
  }


  void removeFromCartVariation(CartModel? cartModel) {
    if(cartModel == null) {
      _initialCartList = [];
    }else{
      _initialCartList.remove(cartModel);
      update();
    }
  }

  void removeFromCartList(int cartIndex) {
    _cartList[cartIndex].quantity = _cartList[cartIndex].quantity - 1;
    update();
  }

  void updateQuantity(int index, bool isIncrement) {
    if(isIncrement){
      _initialCartList[index].quantity += 1;
    }else{
      if(_initialCartList[index].quantity > -1) {
        _initialCartList[index].quantity -= 1;
      }
    }
    _isButton = _isQuantity();
    update();
  }

 bool _isQuantity( ) {
    int _count = 0;
    _initialCartList.forEach((cart) {
      _count += cart.quantity;
    });
    return _count > 0;
  }


  void setQuantity(bool isIncrement, CartModel cart) {
    int index = _cartList.indexWhere((element) => element == cart);
    if (isIncrement) {
      _cartList[index].quantity = _cartList[index].quantity + 1;
      _amount = _amount + _cartList[index].discountedPrice;
    } else {
      _cartList[index].quantity = _cartList[index].quantity - 1;
      _amount = _amount - _cartList[index].discountedPrice;
    }
    cartRepo.addToCartList(_cartList);

    _cartTotalCost();

    update();
  }

  void removeFromCart(int index) {
    _amount = _amount - (_cartList[index].discountedPrice * _cartList[index].quantity);
    _cartList.removeAt(index);
    cartRepo.addToCartList(_cartList);
    update();
  }


  void clearCartList() {
    _cartList = [];
    _amount = 0;
    cartRepo.addToCartList(_cartList);
    update();
  }

  void addDataToCart(){
    if(_cartList.length > 0 && _initialCartList.first.subCategoryId != _cartList.first.subCategoryId) {
      Get.back();
      Get.dialog(ConfirmationDialog(
        icon: Images.warning,
        title: "are_you_sure_to_reset".tr,
        description: 'you_have_service_from_other_sub_category'.tr,
        onYesPressed: () async {
          _initialCartList.removeWhere((_cart) => _cart.quantity < 1);
          cartRepo.addToCartList(_initialCartList);
          _cartList = _initialCartList;
          _cartTotalCost();
          update();
          onDemandToast("successfully_added_to_cart".tr,Colors.green);
          Get.back();
        },
      ));
    }else{
      cartRepo.addToCartList(_replaceCartList());
      _cartTotalCost();
      update();
      onDemandToast("successfully_added_to_cart".tr,Colors.green);
      Get.back();
    }

  }

  Future<void> addMultipleCartToServer() async {
    _isLoading = true;
    update();
    _replaceCartList();

    if(_initialCartList.first.subCategoryId != _cartList.first.subCategoryId){
      Get.back();
      Get.dialog(ConfirmationDialog(
        icon: Images.warning,
        title: "are_you_sure_to_reset".tr,
        description: 'you_have_service_from_other_sub_category'.tr,
        isLogOut: true,
        onNoPressed: (){
          Get.back();
        },
        onYesPressed: () async {
          Get.back();
          Get.dialog(CustomLoader(), barrierDismissible: false,);
          await cartRepo.removeAllCartFromServer();
          if(_initialCartList.length > 0){
            for (int index=0; index<_initialCartList.length;index++){
              await addToCartApi(_initialCartList[index]);
            }
          }
          _isLoading = false;
          onDemandToast("successfully_added_to_cart".tr,Colors.green);
          clearCartList();
          await getCartListFromServer();
          Get.back();
        },
      ));
    }else{
      await cartRepo.removeAllCartFromServer();
      if(_cartList.length > 0){
        for (int index=0; index<_cartList.length;index++){
          await addToCartApi(_cartList[index]);
        }
      }
      _isLoading = false;
      onDemandToast("successfully_added_to_cart".tr,Colors.green);
      clearCartList();
      Get.back();
    }
    update();
  }

  Future<void> addToCartApi(CartModel cartModel)async{

    if(selectedProviderId!=""){
      await cartRepo.addToCartListToServer(CartModelBody(
        serviceId:cartModel.service!.id,
        categoryId: cartModel.categoryId,
        variantKey: cartModel.variantKey,
        quantity: cartModel.quantity.toString(),
        subCategoryId: cartModel.subCategoryId,
        providerId: selectedProviderId,
      ));
    }else{
      await cartRepo.addToCartListToServer(CartModelBody(
        serviceId:cartModel.service!.id,
        categoryId: cartModel.categoryId,
        variantKey: cartModel.variantKey,
        quantity: cartModel.quantity.toString(),
        subCategoryId: cartModel.subCategoryId,
      ));
    }

  }


  void removeAllAndAddToCart(CartModel cartModel) {
    _cartList = [];
    _cartList.add(cartModel);
    _amount = cartModel.discountedPrice.toDouble() * cartModel.quantity;
    cartRepo.addToCartList(_cartList);
    update();
  }

  int isAvailableInCart(CartModel cartModel, Service service) {
    int _index = -1;
    _cartList.forEach((cart) {
      if(cart.service != null){
        if(cart.service!.id!.contains(service.id!)) {
          service.variationsAppFormat?.zoneWiseVariations?.forEach((variation) {
            if(variation.variantKey == cart.variantKey && variation.price == cart.serviceCost) {

              if(cart.variantKey == cartModel.variantKey) {
                _index = _cartList.indexOf(cart);
              }
            }
          });

        }
      }
    });
    return _index;
  }

  setInitialCartList(Service service) {
    _initialCartList = [];
    service.variationsAppFormat?.zoneWiseVariations?.forEach((variation) {
      CartModel _cartModel = CartModel(
          service.id!,
          service.id!,
          service.categoryId!,
          service.subCategoryId!,
          variation.variantKey!,
          variation.price!,
          0,
          0, 0, 0,
          service.tax,
          variation.price!,
          service
      );
      int _index =  isAvailableInCart(_cartModel, service);
      if(_index != -1) {
        _cartModel.copyWith(id: _cartList[_index].id, quantity: _cartList[_index].quantity);
      }
      _initialCartList.add(_cartModel);
    });
    _isButton = false;

  }

  List<CartModel> _replaceCartList() {
    _initialCartList.removeWhere((_cart) => _cart.quantity < 0);

    _initialCartList.forEach((_initCart) {
      _cartList.removeWhere((cart) => cart.id.contains(_initCart.id) && cart.variantKey.contains(_initCart.variantKey));
    });
    _cartList.addAll(_initialCartList);
    _cartList.removeWhere((element) => element.quantity == 0);
    return _cartList;
  }

  Future<void> getProviderBasedOnSubcategory(String subcategoryId,bool reload) async {

      Response response = await cartRepo.getProviderBasedOnSubcategory(subcategoryId);
      if (response.statusCode == 200) {
        if(reload){
          _providerList = [];
        }
        List<dynamic> _list =  response.body['content'];
        _list.forEach((element) {
          providerList!.add(ProviderData.fromJson(element));
        });

        if(selectedProviderId!="" && _providerList!=null && _providerList!.isNotEmpty){
          print('inside');

          for(int i=0;i<_providerList!.length;i++){
            if(selectedProviderId==_providerList![i].id){
              print("$selectedProviderId::::${providerList![i].id}");
              selectedProviderIndex =i;
            }
          }
        }else{
          selectedProviderIndex = -1;
        }
      } else {
        //ApiChecker.checkApi(response);
      }
    update();
  }

  void updateProviderSelectedIndex(int index){
    selectedProviderIndex = index;
    update();
  }

  void updatePreselectedProvider(String rating, String id,String profileImage,String name){
    preSelectedProvider = true;
    selectedProviderId = id;
    selectedProviderProfileImages = profileImage;
    selectedProviderRating = rating;
    selectedProviderName= name;
    update();
  }


  void resetPreselectedProviderInfo(){
    preSelectedProvider = false;
    selectedProviderId = "";
    selectedProviderProfileImages = "";
    selectedProviderRating = "";
    update();
  }

  void setSubCategoryId(String _subcategoryId){
    subcategoryId = _subcategoryId;
    update();
  }
}
