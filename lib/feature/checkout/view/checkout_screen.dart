import 'package:demandium/components/menu_drawer.dart';
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

  CheckoutScreen(this.pageState, this.addressId, {Key? key,}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  @override
  void initState() {
    if(widget.pageState == 'complete'){
      Get.find<CheckOutController>().updateState(PageState.complete,shouldUpdate: false);
    }
    Get.find<CheckOutController>().updateDigitalPaymentOption(PaymentMethodName.COS,shouldUpdate: false);
    Get.find<UserController>().getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print("page_state: ${widget.pageState}");

    return WillPopScope(
      onWillPop: ()  => _exitApp(),
      child: Scaffold(
        endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
        appBar: CustomAppBar(
          title: 'checkout'.tr,
          onBackPressed: () {
            if(widget.pageState == 'payment' || Get.find<CheckOutController>().currentPage == PageState.payment) {
              print("inside_here_true");
              Get.find<CheckOutController>().updateDigitalPaymentOption(PaymentMethodName.COS,shouldUpdate: false);
              Get.find<CheckOutController>().updateState(PageState.orderDetails);
              if(ResponsiveHelper.isWeb())
                Get.toNamed(RouteHelper.getCheckoutRoute('cart','orderDetails','null'));
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
                  child: SizedBox(
                    width: Dimensions.WEB_MAX_WIDTH,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                        Container(
                          width: 426,
                          child: GetBuilder<CheckOutController>(
                            builder: (controller){
                              return Column(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
                                    child:  Stack(
                                      children: [
                                        Container(
                                          height: 55,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomHeaderIcon(
                                                assetIconSelected: Images.orderDetailsSelected,
                                                assetIconUnSelected: Images.orderDetailsUnselected,
                                                isActiveColor: controller.currentPage == PageState.orderDetails ? true : false,
                                              ),
                                              controller.currentPage == PageState.orderDetails ?
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
                                                isActiveColor: controller.currentPage == PageState.payment ? true : false,),
                                              controller.cancelPayment ?
                                              const CustomHeaderLine(
                                                  cancelOrder: true,
                                                  gradientColor1: Colors.grey,
                                                  gradientColor2: Colors.grey) :
                                              controller.currentPage == PageState.payment ?
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
                                                isActiveColor: controller.currentPage == PageState.complete ?
                                                true : false,
                                              ),
                                            ],),),

                                        if(controller.currentPage == PageState.orderDetails  && PageState.orderDetails.name == widget.pageState)
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
                                        if(controller.currentPage == PageState.payment  || PageState.payment.name == widget.pageState)
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
                                          ), if(controller.currentPage == PageState.complete || widget.pageState == 'complete')
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
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT,left: 20.0,right: 20.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  [
                                          CustomText(
                                              text: "booking_details".tr,isActive :controller.currentPage == PageState.orderDetails
                                              && PageState.orderDetails.name == widget.pageState),
                                          Padding(
                                            padding: EdgeInsets.only(right: 25.0),
                                            child: CustomText(text: "payment".tr,isActive :controller.currentPage == PageState.payment
                                                || PageState.payment.name == widget.pageState),
                                          ),
                                          CustomText(text: "complete".tr,isActive : controller.currentPage == PageState.complete  || widget.pageState == 'complete'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        /// Main Body
                        GetBuilder<CheckOutController>(builder: (controller) {
                          print("current_page_initial:${controller.currentPage}");
                          print("pageState:${widget.pageState}");
                          return controller.currentPage == PageState.orderDetails  && PageState.orderDetails.name == widget.pageState
                              ?   ResponsiveHelper.isDesktop(context) ? OrderDetailsPageWeb():  const OrderDetailsPage()
                              : controller.currentPage == PageState.payment || PageState.payment.name == widget.pageState
                              ?  PaymentPage(addressId: widget.addressId,)
                              : const CompletePage();
                        }),
                        if(!ResponsiveHelper.isMobile(context))
                          GetBuilder<CheckOutController>(builder: (controller){
                            if(controller.currentPage == PageState.complete || widget.pageState == 'complete'){
                              return GestureDetector(
                                onTap: (){
                                  Get.offAllNamed(RouteHelper.getInitialRoute());
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
                                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,),
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor,),
                                      child: Center(
                                        child: RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: 'total_price'.tr,
                                            style: ubuntuRegular.copyWith(
                                              fontSize: Dimensions.fontSizeLarge,
                                              color: Theme.of(context).textTheme.bodyText1!.color,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: ' ${PriceConverter.convertPrice(Get.find<CartController>().totalPrice)}',
                                                style: ubuntuBold.copyWith(
                                                  color: Theme.of(context).errorColor,
                                                  fontSize: Dimensions.fontSizeLarge,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
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
                                              if(controller.currentPage == PageState.orderDetails && PageState.orderDetails.name == widget.pageState){
                                                List<AddressModel>  addressList = Get.find<LocationController>().addressList!;
                                                if(addressList.length > 0){
                                                  controller.updateState(PageState.payment);
                                                  ///navigate replace
                                                  Get.toNamed(RouteHelper.getCheckoutRoute('cart',Get.find<CheckOutController>().currentPage.name, widget.pageState == 'payment' ? widget.addressId : addressModel!.id.toString()));
                                                }else{

                                                }
                                              }else if(controller.currentPage == PageState.payment || PageState.payment.name == widget.pageState ){

                                                if(Get.find<CartController>().cartList.length > 0){
                                                  print("inside_length:${Get.find<CartController>().cartList.length}");
                                                  String schedule = DateConverter.dateToDateAndTime(Get.find<ScheduleController>().selectedData);
                                                  String userId = Get.find<UserController>().userInfoModel.id!;
                                                  if(Get.find<CheckOutController>().selectedPaymentMethod == PaymentMethodName.COS){
                                                    String paymentMethod = "cash_after_service";

                                                    Get.find<ServiceBookingController>().placeBookingRequest(
                                                      paymentMethod: paymentMethod,
                                                      userID: userId,
                                                      serviceAddressId: widget.pageState == 'payment' ? widget.addressId : addressModel!.id.toString(),
                                                      schedule: schedule,
                                                    );
                                                  }
                                                }else{
                                                  Get.offAllNamed(RouteHelper.getInitialRoute());
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
                                      child: Container(
                                        height: 50,
                                        width: Get.width,
                                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
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
                                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_MORE_LARGE,),
                                  ],
                                );
                              }else{
                                return SizedBox();
                              }
                            }
                          })
                      ],
                    ),
                  ),
                ),
              ),
              if(ResponsiveHelper.isMobile(context))
                GetBuilder<CheckOutController>(builder: (controller){
                  if(controller.currentPage == PageState.complete || widget.pageState == 'complete'){
                    return GestureDetector(
                      onTap: (){
                        Get.offAllNamed(RouteHelper.getInitialRoute());
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
                          GetBuilder<AuthController>(
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
                                        if(controller.currentPage == PageState.orderDetails){
                                          List<AddressModel>  addressList = Get.find<LocationController>().addressList!;
                                          if(addressList.length > 0){
                                            controller.updateState(PageState.payment);
                                          }else{
                                            customSnackBar('add_address_first'.tr);
                                          }
                                        }else if(controller.currentPage == PageState.payment){

                                          String schedule = DateConverter.dateToDateAndTime(Get.find<ScheduleController>().selectedData);
                                          String userId = Get.find<UserController>().userInfoModel.id!;
                                          ///call booking api after select payment method
                                          ///now only cash on service implemented
                                          print("address_model_id:${addressModel.id.toString()}");
                                          if(Get.find<CheckOutController>().selectedPaymentMethod == PaymentMethodName.COS){
                                            String paymentMethod = "cash_after_service";
                                            Get.find<ServiceBookingController>().placeBookingRequest(
                                              paymentMethod: paymentMethod,
                                              userID: userId,
                                              serviceAddressId: addressModel.id.toString(),
                                              schedule: schedule,
                                            );
                                          }
                                        }
                                      }
                                    }
                                    else{
                                      customSnackBar('please_select_a_digital_payment'.tr);
                                    }
                                  }:null,
                                  child: Container(
                                    height: 50,
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
                              })
                        ],
                      );
                    }else{
                      return SizedBox(height: 0.0,);
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
    print("inside_Exit_app");

    if(widget.pageState == 'payment' || Get.find<CheckOutController>().currentPage == PageState.payment) {
      print("inside_here_true");
      Get.find<CheckOutController>().updateDigitalPaymentOption(PaymentMethodName.COS,shouldUpdate: false);
      Get.find<CheckOutController>().updateState(PageState.orderDetails);
      if(ResponsiveHelper.isWeb())
        Get.toNamed(RouteHelper.getCheckoutRoute('cart','orderDetails','null'));
      return false;
    }else {
      print("inside_here_else");
      return true;
    }
  }
}



