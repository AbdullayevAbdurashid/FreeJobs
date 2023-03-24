import 'dart:convert';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/checkout/view/payment_screen.dart';
import 'package:universal_html/html.dart' as html;

class DigitalPayment extends StatelessWidget {
  final String paymentGateway;
  final String? addressId;

  DigitalPayment({Key? key, required this.paymentGateway, required this.addressId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(Get.find<CartController>().cartList.length > 0){
          AddressModel? _addressModel = Get.find<LocationController>().selectedAddress;
          print(_addressModel);

          String? addressID = _addressModel != null ?  _addressModel.id.toString() : addressId!;

          if(addressID != ''){
            String _url = '';
            String _schedule = DateConverter.dateToDateOnly(Get.find<ScheduleController>().selectedData);
            String _userId = Get.find<UserController>().userInfoModel.id!;
            String hostname = html.window.location.hostname!;
            String protocol = html.window.location.protocol;
            String port = html.window.location.port;
            _url = '${AppConstants.BASE_URL}/payment/${paymentGateway.replaceAll('_', '-')}/pay?access_token=${base64Url.encode(utf8.encode(_userId))}&&zone_id=${Get.find<LocationController>().getUserAddress()!.zoneId}'
                '&&service_schedule=$_schedule&&service_address_id=$addressID';

            if (GetPlatform.isWeb) {
              _url = '$_url&&callback=$protocol//$hostname:$port${RouteHelper.checkout}';

              printLog("url_with_digital_payment:$_url");
              html.window.open(_url, "_self");
            } else {
              _url = '$_url&&callback=${AppConstants.BASE_URL}';
              printLog("url_with_digital_payment_mobile:$_url");
              Get.to(()=> PaymentScreen(url:_url));
            }
          }
        }else{
          Get.offAllNamed(RouteHelper.getInitialRoute());
      }
      },
      child: Card(
        color: Theme.of(context).primaryColorLight,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: Image.asset(paymentImage[paymentGateway]),
        ),
      ),
    );
  }


}
