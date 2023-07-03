import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/checkout/widget/payment_method_button.dart';
import 'digital_payment.dart';

class PaymentPage extends StatefulWidget {
  final String addressId;

  const PaymentPage({Key? key, required this.addressId}) : super(key: key);
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}
class _PaymentPageState extends State<PaymentPage> {

  final ConfigModel _configModel = Get.find<SplashController>().configModel;
  bool paymentMethodAvailable = true;

  int crossAxisCount = 1;

  double padding = 0.00;



  List<PaymentMethodButton> listOfButton =[
    if(Get.find<SplashController>().configModel.content?.digitalPayment==1)
    PaymentMethodButton(title: "digital_payment".tr,paymentMethodName: PaymentMethodName.digitalPayment, assetName: Images.pay,),
    if(Get.find<SplashController>().configModel.content?.cashAfterService==1)
    PaymentMethodButton(title: "cash_after_service".tr,paymentMethodName: PaymentMethodName.cos,assetName: Images.cod,),
    if(Get.find<SplashController>().configModel.content?.walletStatus==1)
    PaymentMethodButton(title: "wallet_money".tr,paymentMethodName: PaymentMethodName.walletMoney,assetName: Images.walletMenu,),
  ];

  @override
  void initState() {
    super.initState();
    if(_configModel.content?.walletStatus==0 && _configModel.content?.cashAfterService==0 && _configModel.content?.digitalPayment==0){
      paymentMethodAvailable = false;
    }
  }

  @override
  Widget build(BuildContext context) {

    if(ResponsiveHelper.isMobile(context)){
      crossAxisCount = listOfButton.length<2 ? 1: 2;
      if(listOfButton.length==1){
        padding = 0.2;
      }else{
        padding = 0.00;
      }

    }else{
      if(listOfButton.length==1){
        crossAxisCount=1;
      }else if(listOfButton.length==2){
        crossAxisCount = 2;
      }else{
        crossAxisCount = 3;
      }

      if(listOfButton.length==1){
        padding = 0.27;
      }else if(listOfButton.length==2){
        padding = 0.17;
      }else{
        padding = 0.12;
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
           Text('payment_method'.tr, style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
          Gaps.verticalGapOf(20),

          (paymentMethodAvailable)?
          Padding(padding: EdgeInsets.symmetric(horizontal: Get.width* padding),
            child: GridView.builder(
              shrinkWrap: true,
              key: UniqueKey(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: Dimensions.paddingSizeSmall ,
                mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeSmall ,
                mainAxisExtent: ResponsiveHelper.isMobile(context)? 100: 120,
                crossAxisCount: crossAxisCount,
              ),
              physics:  const NeverScrollableScrollPhysics(),
              itemCount: listOfButton.length,
              padding: const EdgeInsets.only(top: 50 ,right: Dimensions.paddingSizeDefault,left: Dimensions.paddingSizeDefault,bottom: Dimensions.paddingSizeDefault),
              itemBuilder: (context, index) {
                return listOfButton.elementAt(index);
              },
            ),
          ):Padding(padding: const EdgeInsets.only( top : Dimensions.paddingSizeLarge*2),
            child: Text("no_payment_method_available".tr,style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).colorScheme.error),),
          ),

          Gaps.verticalGapOf(26),
          GetBuilder<CheckOutController>(builder: (controller){
            if(controller.selectedPaymentMethod ==  PaymentMethodName.digitalPayment){
              List<String>? paymentGateways = Get.find<SplashController>().configModel.content?.paymentGateways!;
              if( paymentGateways!.isNotEmpty) {
                return  GridView.builder(
                padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
                key: UniqueKey(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeDefault,
                  childAspectRatio: ResponsiveHelper.isMobile(context) ? 2.5  : 4,
                  crossAxisCount:  ResponsiveHelper.isDesktop(context) ? 4 : ResponsiveHelper.isTab(context) ? 3 : 2,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: paymentGateways.length,
                itemBuilder: (context, index)  {
                  return GetBuilder<CheckOutController>(builder: (controller){
                    return DigitalPayment(
                      paymentGateway: paymentGateways[index],
                      addressId: widget.addressId,
                    );
                  });
                },
              );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraMoreLarge,
                  vertical: Dimensions.paddingSizeExtraMoreLarge,),
                child: Text('online_payment_option_is_not_available'.tr,
                  textAlign:TextAlign.center,
                  style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeLarge,

                    color: Theme.of(context).colorScheme.error),),
              );
            }else{
              return const SizedBox();
            }
          }),
        ],
      ),
    );

  }
}