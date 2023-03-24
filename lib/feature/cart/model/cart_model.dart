import 'package:demandium/feature/service/model/service_model.dart';

class CartModel {
  String? _id;
  String? _serviceId;
  String? _categoryId;
  String? _subCategoryId;
  String? _variantKey;
  num? _serviceCost;
  int? _quantity;
  num? _discountAmount;
  num? _campaignDiscountAmount;
  num? _couponDiscountAmount;
  num? _taxAmount;
  num? _totalCost;
  Service? _service;

  CartModel(
      String id,
      String serviceId,
      String categoryId,
      String subCategoryId,
      String variantKey,
      num serviceCost,
      int quantity,
      num discountAmount,
      num campaignDiscountAmount,
      num couponDiscountAmount,
      num taxAmount,
      num totalCost,
      Service service,
      )
  {
  this._id = id;
  this._serviceId = serviceId;
  this._categoryId = categoryId;
  this._subCategoryId = subCategoryId;
  this._variantKey = variantKey;
  this._serviceCost = serviceCost;
  this._quantity = quantity;
  this._discountAmount = discountAmount;
  this._campaignDiscountAmount = campaignDiscountAmount;
  this._couponDiscountAmount = couponDiscountAmount;
  this._taxAmount = taxAmount;
  this._totalCost = totalCost;
  this._service = service;
  }

  String get id => _id!;
  Service? get service => _service;

  String get serviceId => _serviceId!;
  String get categoryId => _categoryId!;
  String get variantKey => _variantKey!;
  String get subCategoryId => _subCategoryId!;

  num get price => _serviceCost!;
  num get discountedPrice => _discountAmount!;
  num get campaignDiscountPrice => _campaignDiscountAmount!;
  num get couponDiscountPrice => _couponDiscountAmount!;
  num get taxAmount => _taxAmount!;
  num get totalCost => _totalCost!;
  num get serviceCost => _serviceCost!;
  // ignore: unnecessary_getters_setters
  int get quantity => _quantity!;
  // ignore: unnecessary_getters_setters
  set quantity(int qty) => _quantity = qty;

  CartModel copyWith({String? id, int? quantity}) {
    if(id != null) {
      _id = id;
    }

    if(quantity != null) {
      _quantity = quantity;
    }
    return this;
}

  CartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _serviceId = json['service_id'];
    _categoryId = json['category_id'];
    _subCategoryId = json['sub_category_id'];
    _variantKey = json['variant_key'];
    _serviceCost = json['service_cost'];
    _quantity = json['quantity'];
    _discountAmount = json['discount_amount'];
    _campaignDiscountAmount = json['campaign_discount'];
    _couponDiscountAmount = json['coupon_discount'];
    _taxAmount = json['tax_amount'];
    _totalCost = json['total_cost'];
    _service = json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['service_id'] = this._serviceId;
    data['category_id'] = this._categoryId;
    data['sub_category_id'] = this._subCategoryId;
    data['variant_key'] = this._variantKey;
    data['service_cost'] = this._serviceCost;
    data['quantity'] = this._quantity;
    data['discount_amount'] = this._discountAmount;
    data['campaign_discount'] = this._campaignDiscountAmount;
    data['coupon_discount'] = this._couponDiscountAmount;
    data['tax_amount'] = this._taxAmount;
    data['total_cost'] = this._totalCost;
    data['service'] = this._service;
    data['service'] = this.service?.toJson();
    return data;
  }
}
