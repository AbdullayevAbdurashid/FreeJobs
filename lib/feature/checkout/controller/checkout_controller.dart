import 'package:get/get.dart';
import 'package:demandium/feature/profile/controller/user_controller.dart';

enum PageState {orderDetails, payment, complete}

enum PaymentMethodName  {digitalPayment, COS}
class CheckOutController extends GetxController implements GetxService{
  PageState currentPage = PageState.orderDetails;

  var selectedPaymentMethod = PaymentMethodName.COS;
  bool showCoupon = false;
  bool cancelPayment = false;

  @override
  void onInit() {
    Get.find<UserController>().getUserInfo();
    super.onInit();
  }


  void cancelPaymentOption(){
    cancelPayment = true;
    update();
  }

  void updateState(PageState _currentPage,{bool shouldUpdate = true}){
    currentPage=_currentPage;
    if(shouldUpdate){
      update();
    }
  }

  void updateDigitalPaymentOption(PaymentMethodName paymentMethodName,{bool shouldUpdate = true}){
    selectedPaymentMethod = paymentMethodName;
    if(shouldUpdate){
      update();
    }
  }





}