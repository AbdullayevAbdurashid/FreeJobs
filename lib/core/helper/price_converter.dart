import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class PriceConverter {

  static String getCurrency() {
    String currencySymbol ='';
    Get.find<SplashController>().configModel.content?.currencies?.forEach((cc) {
      if(cc.code == Get.find<SplashController>().configModel.content?.currencyCode){
        currencySymbol = cc.symbol!;
      }
    });
   return currencySymbol;
  }

  static String convertPrice(double? price, {double? discount, String? discountType, bool isShowLongPrice = false}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    bool _isRightSide = Get.find<SplashController>().configModel.content?.currencySymbolPosition == 'right' && Get.find<LocalizationController>().isLtr == true;
    return isShowLongPrice == true ?
    '${_isRightSide ? '' : getCurrency()}'
        '${(price!).toStringAsFixed(int.parse(Get.find<SplashController>().configModel.content!.currencyDecimalPoint!))
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${_isRightSide ? getCurrency() : ''}':

    longToShortPrice('${_isRightSide ? '' : getCurrency()}'
        '${(price!).toStringAsFixed(int.parse(Get.find<SplashController>().configModel.content!.currencyDecimalPoint!))
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${_isRightSide ? getCurrency() : ''}');

  }

  static double convertWithDiscount(double price, double discount, String discountType) {
    if(discountType == 'amount' || discountType == 'mixed') {
      price = price - discount;
    }else if(discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }


  static double calculation(double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : getCurrency()} ${'off'.tr}';
  }
  static String percentageOrAmount(String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : getCurrency()} ${'off'.tr}';  }


  static Discount _getDiscount(List<ServiceDiscount>? serviceDiscountList, num? _discountAmount, String? _discountAmountType) {
    ServiceDiscount? serviceDiscount = (serviceDiscountList != null && serviceDiscountList.length > 0) ?serviceDiscountList.first : null;
    if(serviceDiscount != null){
      num? _getDiscount = serviceDiscount.discount?.discountAmount;
      if(_getDiscount! > serviceDiscount.discount!.maxDiscountAmount! && serviceDiscount.discount!.discountType == 'percent') {
        _getDiscount = serviceDiscount.discount!.maxDiscountAmount!;
      }
      _discountAmount = (_discountAmount! + _getDiscount);
      _discountAmountType = serviceDiscount.discount!.discountAmountType!;
    }
    return Discount(discountAmount: _discountAmount, discountAmountType: _discountAmountType);
  }

 static Discount discountCalculation(Service service, {bool addCampaign = false}) {
    num? _discountAmount = 0;
    String? _discountAmountType;

    if(service.serviceDiscount != null && service.serviceDiscount!.isNotEmpty) {

      Discount _discount =  _getDiscount(service.serviceDiscount, _discountAmount, _discountAmountType);
      _discountAmount = _discount.discountAmount;

      _discountAmountType = _discount.discountAmountType;


    }else if(service.campaignDiscount != null && service.campaignDiscount!.isNotEmpty && addCampaign) {

      Discount _discount =  _getDiscount(service.campaignDiscount, _discountAmount, _discountAmountType);
      _discountAmount = _discount.discountAmount;
      _discountAmountType = _discount.discountAmountType;
    } else{
      if(service.category?.categoryDiscount != null && service.category!.categoryDiscount!.isNotEmpty) {
        Discount _discount =  _getDiscount(service.category?.categoryDiscount, _discountAmount, _discountAmountType);
        _discountAmount = _discount.discountAmount;
        _discountAmountType = _discount.discountAmountType;

      }else if(service.category?.campaignDiscount != null && service.category!.campaignDiscount!.isNotEmpty && addCampaign){

        Discount _discount =  _getDiscount(service.category?.campaignDiscount, _discountAmount, _discountAmountType);
        _discountAmount = _discount.discountAmount;
        _discountAmountType = _discount.discountAmountType;

      }
    }

    return Discount(discountAmount: _discountAmount, discountAmountType: _discountAmountType);
  }

  static double getDiscountToAmount(Discount discount, double amount) {

    double _amount = 0;
    if(discount.discountAmountType == 'percent') {
     _amount = (amount * discount.discountAmount!.toDouble()) / 100.0 ;

     if(_amount > discount.maxDiscountAmount!.toDouble()) {
       _amount = discount.maxDiscountAmount!.toDouble();
     }
    }else{
      _amount = discount.discountAmount!.toDouble();
    }
    return _amount;

  }

  static String longToShortPrice(String price){
    return price.length > 15 ?
    "${price.substring(0, 12)}.......${price.substring(price.length - 1,price.length)}":
    price;
  }
}