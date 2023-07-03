import 'package:demandium/data/provider/checker_api.dart';
import 'package:demandium/feature/checkout/model/post_details_model.dart';
import 'package:demandium/feature/checkout/repo/checkout_repo.dart';
import 'package:get/get.dart';
import 'package:demandium/feature/profile/controller/user_controller.dart';

enum PageState {orderDetails, payment, complete}

enum PaymentMethodName  {digitalPayment, cos,walletMoney,none}
class CheckOutController extends GetxController implements GetxService{
 final CheckoutRepo checkoutRepo;
  CheckOutController({required this.checkoutRepo});
  PageState currentPageState = PageState.orderDetails;
  var selectedPaymentMethod = PaymentMethodName.cos;
  bool showCoupon = false;
  bool cancelPayment = false;

  PostDetailsContent? postDetails;
  double totalAmount = 0.0;
  double totalVat = 0.0;
  int _selectedDigitalPaymentIndex = -1;
  int get selectedDigitalPayment => _selectedDigitalPaymentIndex;


  @override
  void onInit() {
    Get.find<UserController>().getUserInfo();
    super.onInit();
  }


  void cancelPaymentOption(){
    cancelPayment = true;
    update();
  }

  void updateState(PageState currentPage,{bool shouldUpdate = true}){
    currentPageState=currentPage;
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


  Future<void> getPostDetails(String postID) async {
    totalAmount = 0.0;
    postDetails = null;
    Response response = await checkoutRepo.getPostDetails(postID);
    if (response.body['response_code'] == 'default_200' ) {
      postDetails = PostDetailsContent.fromJson(response.body['content']);
      totalAmount = postDetails?.service?.tax??0;
    } else {
      postDetails = PostDetailsContent();
      if(response.statusCode != 200){
        ApiChecker.checkApi(response);
      }
    }
    update();
  }



  void calculateTotalAmount(double amount){
    totalAmount = 0.00;
    totalVat = 0.00;
    double serviceTax = postDetails?.service?.tax??1;
    totalAmount = amount + (amount*serviceTax)/100;
    totalVat = (amount*serviceTax)/100;

  }

  void updateSelectedDigitalPaymentIndex(int index, {bool shouldUpdate = true}){
    _selectedDigitalPaymentIndex = index;

    if(shouldUpdate){
      update();
    }
  }


}