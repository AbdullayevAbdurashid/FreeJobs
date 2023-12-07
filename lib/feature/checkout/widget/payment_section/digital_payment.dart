import 'dart:convert';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/checkout/view/payment_screen.dart';
import 'package:universal_html/html.dart' as html;

class DigitalPayment extends StatelessWidget {
  final String paymentGateway;
  final String? addressId;

  final bool redirectDirectlyPaymentScreen;

  const DigitalPayment({Key? key, required this.paymentGateway,
    required this.addressId,
    this.redirectDirectlyPaymentScreen = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: redirectDirectlyPaymentScreen? () {
        if(Get.find<CartController>().cartList.isNotEmpty){
          AddressModel? addressModel = Get.find<LocationController>().selectedAddress;

          String? addressID = addressModel != null ?  addressModel.id.toString() : addressId!;

          if(addressID != ''){
            String url = '';
            String schedule = DateConverter.dateToDateOnly(Get.find<ScheduleController>().selectedData);
            String userId = Get.find<UserController>().userInfoModel.id!;
            String hostname = html.window.location.hostname!;
            String protocol = html.window.location.protocol;
            String port = html.window.location.port;

            url = '${AppConstants.baseUrl}/payment/${paymentGateway.replaceAll('_', '-')}/pay?access_token=${base64Url.encode(utf8.encode(userId))}&&zone_id=${Get.find<LocationController>().getUserAddress()!.zoneId}'
                  '&&service_schedule=$schedule&&service_address_id=$addressID';

            if (GetPlatform.isWeb) {
              url = '$url&&callback=$protocol//$hostname:$port${RouteHelper.checkout}';

              printLog("url_with_digital_payment:$url");
              html.window.open(url, "_self");
            } else {
              url = '$url&&callback=${AppConstants.baseUrl}';
              printLog("url_with_digital_payment_mobile:$url");
              Get.to(()=> PaymentScreen(url:url));
            }
          }
        }else{
          Get.offAllNamed(RouteHelper.getInitialRoute());
      }
      }: null,
      child: Card(
        color: Theme.of(context).primaryColorLight,
        margin: const EdgeInsets.symmetric(horizontal: 7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeSmall),
            child: Image.asset(paymentImage[paymentGateway],fit: BoxFit.cover,),
          ),
        ),
      ),
    );
  }


}
