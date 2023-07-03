import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:get/get.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/checkout/widget/custom_header_icon_section.dart';
import 'package:demandium/feature/checkout/widget/custom_header_line.dart';
import 'package:demandium/feature/checkout/widget/custom_text.dart';
import 'package:demandium/feature/checkout/widget/order_complete_section/complete_page.dart';
import 'package:demandium/feature/checkout/widget/order_details_section/order_details_page.dart';
import 'package:demandium/feature/checkout/widget/order_details_section/order_details_page_web.dart';
import 'package:demandium/feature/checkout/widget/payment_section/payment_page.dart';

class CheckoutScreen extends StatefulWidget {
  final String pageState;
  final String addressId;

  const CheckoutScreen(this.pageState, this.addressId, {Key? key,}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  @override
  void initState() {
    if(widget.pageState == 'complete'){
      Get.find<CheckOutController>().updateState(PageState.complete,shouldUpdate: false);
    }
    Get.find<CheckOutController>().updateDigitalPaymentOption(PaymentMethodName.none,shouldUpdate: false);
    Get.find<UserController>().getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()  => _exitApp(),
      child: Scaffold(
        endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
        appBar: CustomAppBar(
          title: 'checkout'.tr,
          onBackPressed: () {
            if(widget.pageState == 'payment' || Get.find<CheckOutController>().currentPageState == PageState.payment) {
              Get.find<CheckOutController>().updateDigitalPaymentOption(PaymentMethodName.cos,shouldUpdate: false);
              Get.find<CheckOutController>().updateState(PageState.orderDetails);
              if(ResponsiveHelper.isWeb()) {
                Get.toNamed(RouteHelper.getCheckoutRoute('cart','orderDetails','null'));
              }
            }else {
              Get.back();
            }
          }
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: FooterBaseView(
                  child: WebShadowWrap(
                    child: SizedBox(
                      width: Dimensions.webMaxWidth,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimensions.paddingSizeDefault,),
                          SizedBox(
                            width: 426,
                            child: GetBuilder<CheckOutController>(
                              builder: (controller){
                                return Column(
                                  children: [
                                    Padding(
                                      padding:  const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeSmall),
                                      child:  Stack(
                                        children: [
                                          SizedBox(
                                            height: 55,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CustomHeaderIcon(
                                                  assetIconSelected: Images.orderDetailsSelected,
                                                  assetIconUnSelected: Images.orderDetailsUnselected,
                                                  isActiveColor: controller.currentPageState == PageState.orderDetails ? true : false,
                                                ),
                                                controller.currentPageState == PageState.orderDetails ?
                                                const CustomHeaderLine(
                                                    color: Color(0xffFF833D),
                                                    gradientColor1: Color(0xffFDA21A),
                                                    gradientColor2: Colors.orangeAccent) :
                                                const CustomHeaderLine(
                                                    gradientColor1: Colors.deepOrange,
                                                    gradientColor2: Colors.orangeAccent),

                                                CustomHeaderIcon(
                                                  assetIconSelected: Images.paymentSelected,
                                                  assetIconUnSelected: Images.paymentUnSelected,
                                                  isActiveColor: controller.currentPageState == PageState.payment ? true : false,),
                                                controller.cancelPayment ?
                                                const CustomHeaderLine(
                                                    cancelOrder: true,
                                                    gradientColor1: Colors.grey,
                                                    gradientColor2: Colors.grey) :
                                                controller.currentPageState == PageState.payment ?
                                                const CustomHeaderLine(
                                                    color: Colors.green,
                                                    gradientColor1: Colors.orangeAccent,
                                                    gradientColor2: Colors.green) :
                                                const CustomHeaderLine(
                                                    gradientColor1: Colors.orangeAccent,
                                                    gradientColor2: Colors.greenAccent),
                                                CustomHeaderIcon(
                                                  assetIconSelected: controller.cancelPayment? Images.completeSelected : Images.completeSelected,
                                                  assetIconUnSelected: Images.completeUnSelected,
                                                  isActiveColor: controller.currentPageState == PageState.complete ?
                                                  true : false,
                                                ),
                                              ],),),

                                          if(controller.currentPageState == PageState.orderDetails  && PageState.orderDetails.name == widget.pageState)
                                            Positioned(
                                              left: Get.find<LocalizationController>().isLtr ? 0: null,
                                              right:Get.find<LocalizationController>().isLtr ? null: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: GestureDetector(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      height: 55,
                                                      width: 55,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50),
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage( Images.orderDetailsSelected,))),
                                                    ),)),),
                                          if(controller.currentPageState == PageState.payment  || PageState.payment.name == widget.pageState)
                                            Positioned(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: GestureDetector(
                                                    child: GestureDetector(
                                                      child: Container(
                                                        height: 55,
                                                        width: 55,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                                                            image: DecorationImage(
                                                                fit: BoxFit.fill,
                                                                image: AssetImage( Images.paymentSelected,))),
                                                      ),)),
                                              ),
                                            ), if(controller.currentPageState == PageState.complete || widget.pageState == 'complete')
                                            Positioned(
                                              right: Get.find<LocalizationController>().isLtr ? 0:null,
                                              left: Get.find<LocalizationController>().isLtr ? null: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: GestureDetector(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      height: 55,
                                                      width: 55,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50),
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage( Images.completeSelected,))),),)),),],
                                      ),),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault,left: 20.0,right: 20.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  [
                                          CustomText(
                                              text: "booking_details".tr,isActive :controller.currentPageState == PageState.orderDetails
                                              && PageState.orderDetails.name == widget.pageState),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 25.0),
                                            child: CustomText(text: "payment".tr,isActive :controller.currentPageState == PageState.payment
                                                || PageState.payment.name == widget.pageState),
                                          ),
                                          CustomText(text: "complete".tr,isActive : controller.currentPageState == PageState.complete  || widget.pageState == 'complete'),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          /// Main Body
                          GetBuilder<CheckOutController>(builder: (controller) {
                            return controller.currentPageState == PageState.orderDetails  && PageState.orderDetails.name == widget.pageState
                                ?   ResponsiveHelper.isDesktop(context) ? const OrderDetailsPageWeb():  const OrderDetailsPage()
                                : controller.currentPageState == PageState.payment || PageState.payment.name == widget.pageState
                                ?  PaymentPage(addressId: widget.addressId,)
                                : const CompletePage();
                          }),
                          if(!ResponsiveHelper.isMobile(context))
                           GetBuilder<ServiceBookingController>(builder: (serviceBookingController){
                             return  GetBuilder<CheckOutController>(builder: (controller){
                               if(controller.currentPageState == PageState.complete || widget.pageState == 'complete'){
                                 return GestureDetector(
                                   onTap: (){
                                     Get.offAllNamed(RouteHelper.getMainRoute('home'));
                                   },
                                   child: Container(
                                     height: 50,
                                     width: Get.width,
                                     decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                                     child: Center(
                                       child: Text(
                                         'back_to_homepage'.tr,
                                         style:
                                         ubuntuMedium.copyWith(
                                             color: Colors.white,
                                             fontSize: Dimensions.fontSizeDefault
                                         ),
                                       ),
                                     ),
                                   ),
                                 );
                               }else{
                                 if(controller.selectedPaymentMethod != PaymentMethodName.digitalPayment){
                                   return Column(
                                     children: [
                                       const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,),
                                       Container(
                                         height: 50,
                                         decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,),
                                         child: Center(
                                             child:Row(mainAxisAlignment: MainAxisAlignment.center,children:[

                                               Text('${"total_price".tr} ',
                                                 style: ubuntuRegular.copyWith(
                                                   fontSize: Dimensions.fontSizeLarge,
                                                   color: Theme.of(context).textTheme.bodyLarge!.color,
                                                 ),
                                               ),
                                               GetBuilder<CartController>(builder: (cartController){
                                                 return Directionality(
                                                   textDirection: TextDirection.ltr,
                                                   child: Text(PriceConverter.convertPrice(Get.find<CartController>().totalPrice),
                                                     style: ubuntuBold.copyWith(
                                                       color: Theme.of(context).colorScheme.error,
                                                       fontSize: Dimensions.fontSizeLarge,
                                                     ),
                                                   ),
                                                 );
                                               })])
                                         ),
                                       ),
                                       GestureDetector(
                                         onTap: () {
                                           if(Get.find<AuthController>().acceptTerms){
                                             if(controller.selectedPaymentMethod !=  PaymentMethodName.digitalPayment) {
                                               AddressModel? addressModel = Get.find<LocationController>().selectedAddress;

                                               if(!Get.find<ScheduleController>().checkScheduleTime()) {
                                                 customSnackBar('set_your_schedule_time'.tr);
                                               }else if(widget.pageState == 'payment' ?  false : addressModel == null ||  addressModel.contactPersonNumber == "null") {
                                                 customSnackBar('add_address_first'.tr);
                                               }
                                               else{
                                                 if(controller.currentPageState == PageState.orderDetails && PageState.orderDetails.name == widget.pageState){
                                                   List<AddressModel>  addressList = Get.find<LocationController>().addressList!;
                                                   if(addressList.isNotEmpty){
                                                     controller.updateState(PageState.payment);
                                                     ///navigate replace
                                                     Get.toNamed(RouteHelper.getCheckoutRoute('cart',Get.find<CheckOutController>().currentPageState.name, widget.pageState == 'payment' ? widget.addressId : addressModel!.id.toString()));
                                                   }else{

                                                   }
                                                 }else if(controller.currentPageState == PageState.payment || PageState.payment.name == widget.pageState ){

                                                   if(Get.find<CartController>().cartList.isNotEmpty){

                                                     String schedule = DateConverter.dateToDateAndTime(Get.find<ScheduleController>().selectedData);
                                                     String userId = Get.find<UserController>().userInfoModel.id!;

                                                     if(controller.selectedPaymentMethod== PaymentMethodName.none){
                                                       customSnackBar("select_payment_method".tr);
                                                     }
                                                     else if(controller.selectedPaymentMethod == PaymentMethodName.cos || controller.selectedPaymentMethod == PaymentMethodName.walletMoney){

                                                       String paymentMethod;
                                                       if(controller.selectedPaymentMethod == PaymentMethodName.cos){
                                                         paymentMethod = "cash_after_service";
                                                         Get.find<ServiceBookingController>().placeBookingRequest(
                                                           paymentMethod: paymentMethod,
                                                           userID: userId,
                                                           serviceAddressId: widget.pageState == 'payment' ? widget.addressId : addressModel!.id.toString(),
                                                           schedule: schedule,
                                                         );
                                                       }else{
                                                         paymentMethod = "wallet_payment";

                                                         if(Get.find<CartController>().walletBalance>= Get.find<CartController>().totalPrice){
                                                           Get.find<ServiceBookingController>().placeBookingRequest(
                                                             paymentMethod: paymentMethod,
                                                             userID: userId,
                                                             serviceAddressId: widget.pageState == 'payment' ? widget.addressId : addressModel!.id.toString(),
                                                             schedule: schedule,
                                                           );
                                                         }else{
                                                           customSnackBar("insufficient_wallet_balance".tr);
                                                         }
                                                       }
                                                     }
                                                   }else{
                                                     Get.offAllNamed(RouteHelper.getMainRoute('home'));
                                                   }
                                                 }
                                               }
                                             }
                                             else{
                                               customSnackBar('please_select_a_digital_payment'.tr);
                                             }
                                           }else{
                                             customSnackBar('please_agree_with_terms_conditions'.tr);
                                           }
                                         },
                                         child: serviceBookingController.isLoading?
                                         const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraLarge),
                                           child: Center(child: CircularProgressIndicator(),),
                                         ) :

                                         Container(height:  ResponsiveHelper.isDesktop(context)? 50 : 45, width: Get.width,
                                           decoration: BoxDecoration(
                                             color: Theme.of(context).colorScheme.primary,
                                             borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                                           ),
                                           child: Center(
                                             child: Text(
                                               'proceed_to_checkout'.tr,
                                               style: ubuntuMedium.copyWith(
                                                 color: Theme.of(context).primaryColorLight,
                                                 fontSize: Dimensions.fontSizeDefault,
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                       const SizedBox(height: Dimensions.paddingSizeExtraMoreLarge,),
                                     ],
                                   );
                                 }else{
                                   return const SizedBox();
                                 }
                               }
                             });
                           })
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if(ResponsiveHelper.isMobile(context))
                GetBuilder<CheckOutController>(builder: (controller){
                  if(controller.currentPageState == PageState.complete || widget.pageState == 'complete'){
                    return GestureDetector(
                      onTap: (){
                        Get.offAllNamed(RouteHelper.getMainRoute('home'));
                      },
                      child: Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                        child: Center(
                          child: Text(
                            'back_to_homepage'.tr,
                            style:
                            ubuntuMedium.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }else{
                    if(controller.selectedPaymentMethod !=  PaymentMethodName.digitalPayment){
                      return Column(
                        children: [
                         GetBuilder<ServiceBookingController>(builder: (serviceBookingController){
                           return  GetBuilder<AuthController>(
                               builder: (authController){
                                 return GestureDetector(
                                   onTap: authController.acceptTerms ? () {
                                     if(controller.selectedPaymentMethod !=  PaymentMethodName.digitalPayment) {
                                       AddressModel? addressModel = Get.find<LocationController>().selectedAddress;

                                       if(!Get.find<ScheduleController>().checkScheduleTime()) {
                                         customSnackBar('set_your_schedule_time'.tr);
                                       }else if(addressModel == null || addressModel.contactPersonNumber == "null") {
                                         customSnackBar('add_address_first'.tr);
                                       } else{
                                         if(controller.currentPageState == PageState.orderDetails){
                                           List<AddressModel>  addressList = Get.find<LocationController>().addressList!;
                                           if(addressList.isNotEmpty){
                                             controller.updateState(PageState.payment);
                                           }else{
                                             customSnackBar('add_address_first'.tr);
                                           }
                                         }else if(controller.currentPageState == PageState.payment){

                                           String schedule = DateConverter.dateToDateAndTime(Get.find<ScheduleController>().selectedData);
                                           String userId = Get.find<UserController>().userInfoModel.id!;
                                           ///call booking api after select payment method
                                           ///now only cash on service implemented

                                           if(controller.selectedPaymentMethod== PaymentMethodName.none){
                                             customSnackBar("select_payment_method".tr);
                                           }
                                           else if(controller.selectedPaymentMethod == PaymentMethodName.cos || controller.selectedPaymentMethod == PaymentMethodName.walletMoney){
                                             String paymentMethod;
                                             if(controller.selectedPaymentMethod == PaymentMethodName.cos){
                                               paymentMethod = "cash_after_service";
                                               Get.find<ServiceBookingController>().placeBookingRequest(
                                                 paymentMethod: paymentMethod,
                                                 userID: userId,
                                                 serviceAddressId: addressModel.id.toString(),
                                                 schedule: schedule,
                                               );
                                             }else{
                                               paymentMethod = "wallet_payment";

                                               if(Get.find<CartController>().walletBalance>= Get.find<CartController>().totalPrice){
                                                 Get.find<ServiceBookingController>().placeBookingRequest(
                                                   paymentMethod: paymentMethod,
                                                   userID: userId,
                                                   serviceAddressId: widget.pageState == 'payment' ? widget.addressId : addressModel.id.toString(),
                                                   schedule: schedule,
                                                 );
                                               }else{
                                                 customSnackBar("insufficient_wallet_balance".tr);
                                               }
                                             }
                                           }
                                         }
                                       }
                                     }
                                     else{
                                       customSnackBar('please_select_a_digital_payment'.tr);
                                     }
                                   }:null,
                                   child: serviceBookingController.isLoading?
                                   const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                                     child: Center(child: CircularProgressIndicator(),),
                                   )
                                   :Container(
                                     height:  ResponsiveHelper.isDesktop(context)? 50 : 45,
                                     width: Get.width,
                                     decoration: BoxDecoration(color:authController.acceptTerms ? Theme.of(context).colorScheme.primary:Theme.of(context).disabledColor),
                                     child: Center(
                                       child: Text(
                                         'proceed_to_checkout'.tr,
                                         style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                                       ),
                                     ),
                                   ),
                                 );
                               });
                         })
                        ],
                      );
                    }else{
                      return const SizedBox(height: 0.0,);
                    }
                  }
                })
            ],
          ),
        ),
      ),
    );
  }


  Future<bool> _exitApp() async {
    if(widget.pageState == 'payment' || Get.find<CheckOutController>().currentPageState == PageState.payment) {
      Get.find<CheckOutController>().updateDigitalPaymentOption(PaymentMethodName.cos,shouldUpdate: false);
      Get.find<CheckOutController>().updateState(PageState.orderDetails);
      if(ResponsiveHelper.isWeb()) {
        Get.toNamed(RouteHelper.getCheckoutRoute('cart','orderDetails','null'));
      }
      return false;
    }else {
      return true;
    }
  }
}



