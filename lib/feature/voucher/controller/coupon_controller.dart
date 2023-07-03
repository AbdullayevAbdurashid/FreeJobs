import 'package:get/get.dart';
import '../../../core/core_export.dart';


class CouponController extends GetxController implements GetxService{
  final CouponRepo couponRepo;
  CouponController({required this.couponRepo});

  bool _isLoading = false;
  CouponModel? _coupon;

  bool get isLoading => _isLoading;
  CouponModel? get coupon => _coupon;

  List<CouponModel>? _activeCouponList;
  List<CouponModel>? get activeCouponList => _activeCouponList;

  List<CouponModel>? _expiredCouponList;
  List<CouponModel>? get expiredCouponList => _expiredCouponList;
  

  TabController? voucherTabController;
  CouponTabState __couponTabCurrentState = CouponTabState.currentCoupon;
  CouponTabState get couponTabCurrentState => __couponTabCurrentState;

  Future<void> getCouponList() async {
    _isLoading = true;
    Response response = await couponRepo.getCouponList();
    if (response.statusCode == 200) {
      _activeCouponList = [];
      _expiredCouponList = [];
      response.body["content"]['active_coupons']["data"].forEach((category) {
          _activeCouponList!.add(CouponModel.fromJson(category));
      });
      response.body["content"]['expired_coupons']["data"].forEach((category) {
        _expiredCouponList!.add(CouponModel.fromJson(category));
      });
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }

  Future<void> applyCoupon(CouponModel couponModel) async {
    Response response = await couponRepo.applyCoupon(couponModel.couponCode!);
    if(response.statusCode == 200 && response.body['response_code'] == 'default_200'){
      _coupon = couponModel;

      customSnackBar("coupon_applied_successfully".tr, isError: false);
    }else{

      customSnackBar('this_coupon_is_not_valid_for_your_cart'.tr, isError: true);

    }

    update();
  }



  Future<void> removeCoupon() async {
   // Get.dialog(CustomLoader(), barrierDismissible: false,);
    Response response = await couponRepo.removeCoupon();

    if(response.statusCode == 200 && response.body['response_code'] == 'default_update_200'){
      _coupon=null;
      Get.find<CartController>().getCartListFromServer();
      customSnackBar("coupon_removed_successfully".tr, isError: false);
    }else{
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
    update();
  }



  void updateTabBar(CouponTabState couponTabState, {bool isUpdate = true}){
    __couponTabCurrentState = couponTabState;
    if(isUpdate){
      update();
    }
  }

  void removeCouponData(bool notify) {
    _coupon = null;
    if(notify) {
      update();
    }
  }




}

enum CouponTabState {
  currentCoupon,
  usedCoupon
}