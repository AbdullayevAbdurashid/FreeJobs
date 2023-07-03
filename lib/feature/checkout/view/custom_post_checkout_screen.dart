import 'dart:convert';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/checkout/repo/schedule_repo.dart';
import 'package:demandium/feature/checkout/view/payment_screen.dart';
import 'package:demandium/feature/checkout/widget/custom_post/cart_summary.dart';
import 'package:demandium/feature/checkout/widget/custom_post/custom_post_service_info.dart';
import 'package:demandium/feature/checkout/widget/custom_post/expansion_tile.dart';
import 'package:demandium/feature/checkout/widget/custom_post/payment_method.dart';
import 'package:demandium/feature/create_post/controller/create_post_controller.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

class CustomPostCheckoutScreen extends StatefulWidget {
  final String postId;
  final String providerId;
  final String amount;
  const CustomPostCheckoutScreen({Key? key, required this.postId, required this.providerId, required this.amount}) : super(key: key);

  @override
  State<CustomPostCheckoutScreen> createState() => _CustomPostCheckoutScreenState();
}

class _CustomPostCheckoutScreenState extends State<CustomPostCheckoutScreen> {

  final ConfigModel _configModel = Get.find<SplashController>().configModel;
  bool paymentMethodAvailable = true;

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => ScheduleController(scheduleRepo: ScheduleRepo(apiClient: Get.find())));
    Get.find<CheckOutController>().getPostDetails(widget.postId);
    Get.find<ScheduleController>().setPostId(widget.postId);
    Get.find<CheckOutController>().updateSelectedDigitalPaymentIndex(-1,shouldUpdate: false);
    Get.find<CheckOutController>().updateDigitalPaymentOption(PaymentMethodName.none,shouldUpdate: false);
    Get.find<AuthController>().cancelTermsAndCondition();

  }
  
  @override
  Widget build(BuildContext context) {

    if(_configModel.content?.walletStatus==0 && _configModel.content?.cashAfterService==0 && _configModel.content?.digitalPayment==0){
      paymentMethodAvailable = false;
    }
    return Scaffold(
      endDrawer:ResponsiveHelper.isDesktop(context) ? const MenuDrawer():null,
      appBar: CustomAppBar(title: 'checkout'.tr,

        onBackPressed: (){
            if(Navigator.canPop(context)){
              Get.back();
            }else{
              Get.toNamed(RouteHelper.getMainRoute("home"));
            }
        },
      ),
      body: GetBuilder<CheckOutController>(builder: (checkoutController){

        if(checkoutController.postDetails!=null){
          Get.find<ScheduleController>().updateSelectedDate(checkoutController.postDetails?.bookingSchedule);
          Get.find<LocationController>().updateSelectedAddress(checkoutController.postDetails?.serviceAddress);
          Get.find<CheckOutController>().calculateTotalAmount(double.tryParse(widget.amount.toString())??0);
          return FooterBaseView(
            isCenter: true,
            child: WebShadowWrap(
              child: Column(children:  [

                CustomPostServiceInfo(postDetails: checkoutController.postDetails!,),
                DescriptionExpansionTile(
                  title: "description",
                  subTitle: checkoutController.postDetails!.serviceDescription??"",
                ),
                if(checkoutController.postDetails!.additionInstructions!.isNotEmpty)
                  DescriptionExpansionTile(
                    title: "additional_instruction",
                    additionalInstruction: checkoutController.postDetails!.additionInstructions,
                  ),
                const ServiceSchedule(),
                const ServiceInformation(),

                CartSummary(postDetails: checkoutController.postDetails!,amount: widget.amount,),
                (paymentMethodAvailable)?
                PaymentMethod(postId: widget.postId,providerId: widget.providerId,)
                : Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
                 child: Text("no_payment_method_available".tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).colorScheme.error),),
               ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: ResponsiveHelper.isDesktop(context)?15:0),
                  child: const ConditionCheckBox(),
                ),
                if(ResponsiveHelper.isDesktop(context))
                GetBuilder<CheckOutController>(builder: (checkoutController){
                  return SizedBox(height: 90,
                    child: Column(
                      children: [
                        Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[
                            Text('${"total_price".tr} ',
                              style: ubuntuRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color: Theme.of(context).textTheme.bodyLarge!.color,
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(PriceConverter.convertPrice(checkoutController.totalAmount),
                                style: ubuntuBold.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                            )]),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              _makePayment(checkoutController);
                            },
                            child: Container(
                              color: Theme.of(context).colorScheme.primary,
                              child: Center(
                                child: Text(
                                  'proceed_to_checkout'.tr,
                                  style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: ResponsiveHelper.isDesktop(context)? 70: 110,)
              ],),
            )
          );
        }else{
          return const FooterBaseView(
            isCenter: true,
              child: Center(child: CircularProgressIndicator())
          );
        }
      }),

      bottomSheet: GetBuilder<CheckOutController>(builder: (checkoutController){
        return !ResponsiveHelper.isDesktop(context) && checkoutController.postDetails!=null?
        GetBuilder<CheckOutController>(builder: (checkoutController){
          return SizedBox(height: 90,
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,children:[
                    Text('${"total_price".tr} ',
                      style: ubuntuRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(PriceConverter.convertPrice(checkoutController.totalAmount),
                        style: ubuntuBold.copyWith(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                      ),
                    )]),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      _makePayment(checkoutController);
                    },
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                      child: Center(
                        child: Text(
                          'proceed_to_checkout'.tr,
                          style: ubuntuMedium.copyWith(color: Theme.of(context).primaryColorLight),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }): const SizedBox();
      }),
    );
  }

  void _makePayment(CheckOutController checkOutController) async {
    if(Get.find<AuthController>().acceptTerms){
      if(checkOutController.selectedPaymentMethod == PaymentMethodName.cos) {

        Get.dialog(const CustomLoader(), barrierDismissible: false,);
        Response response = await Get.find<CreatePostController>().updatePostStatus(widget.postId,widget.providerId, 'accept');
        Get.back();
        if(response.statusCode == 200 && response.body['response_code']=="default_update_200") {
          Get.offNamed(RouteHelper.getOrderSuccessRoute('success'));
        }else{
          Get.offNamed(RouteHelper.getOrderSuccessRoute('failed'));
        }
      }else if(checkOutController.selectedPaymentMethod == PaymentMethodName.walletMoney){

        Get.dialog(const CustomLoader(), barrierDismissible: false,);
        Response response = await Get.find<CreatePostController>().makePaymentWithWalletMoney(widget.postId,widget.providerId, "wallet_payment");
        Get.back();

        if(response.statusCode == 200 && response.body['response_code']=="default_200") {
          Get.offNamed(RouteHelper.getOrderSuccessRoute('success'));
        }else if(response.statusCode==400 && response.body["response_code"]=="insufficient_wallet_balance_400"){
          customSnackBar(response.body['message']??response.statusText);
        }
        else{
          customSnackBar(response.body['message'].toString().capitalizeFirst??response.statusText);
          Get.offNamed(RouteHelper.getOrderSuccessRoute('failed'));
        }

      } else {
        if(checkOutController.selectedDigitalPayment==-1){
          customSnackBar('select_any_payment_method'.tr);
        } else{
          AddressModel? addressModel = Get.find<LocationController>().selectedAddress;
          List<String>? paymentGateways = Get.find<SplashController>().configModel.content?.paymentGateways!;

          String? addressID = addressModel != null ?  addressModel.id.toString() :
          checkOutController.postDetails?.serviceAddress?.id.toString()??"";

          if(addressID != ''){
            String url = '';
            String schedule = DateConverter.dateToDateOnly(Get.find<ScheduleController>().selectedData);
            String userId = Get.find<UserController>().userInfoModel.id!;
            String hostname = html.window.location.hostname!;
            String protocol = html.window.location.protocol;
            String port = html.window.location.port;

            url = '${AppConstants.baseUrl}/payment/${paymentGateways![checkOutController.selectedDigitalPayment]
                .replaceAll('_', '-')}/pay?access_token=${base64Url.encode(utf8.encode(userId))}'
                '&&post_id=${widget.postId}&&provider_id=${widget.providerId}'
                '&&zone_id=${Get.find<LocationController>().getUserAddress()!.zoneId}'
                '&&service_schedule=$schedule&&service_address_id=$addressID';

            if (GetPlatform.isWeb) {
              url = '$url&&callback=$protocol//$hostname:$port${RouteHelper.orderSuccess}';

              printLog("url_with_digital_payment:$url");
              html.window.open(url, "_self");
            } else {
              url = '$url&&callback=${AppConstants.baseUrl}';
              printLog("url_with_digital_payment_mobile:$url");
              Get.to(()=> PaymentScreen(url:url,fromCustomPost: true,));
            }
          }
        }
      }
    }else{
      customSnackBar('please_agree_with_terms_conditions'.tr);
    }
  }
}
