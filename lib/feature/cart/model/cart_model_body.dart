class CartModelBody {
  String? serviceId;
  String? categoryId;
  String? variantKey;
  String? quantity;
  String? subCategoryId;
  String? providerId;

  CartModelBody({this.serviceId, this.categoryId, this.variantKey, this.quantity, this.subCategoryId, this.providerId});

  CartModelBody.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    categoryId = json['category_id'];
    variantKey = json['variant_key'];
    quantity = json['quantity'];
    subCategoryId = json['sub_category_id'];
    providerId = json['provider_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['service_id'] = serviceId;
    data['category_id'] = categoryId;
    data['variant_key'] = variantKey;
    data['quantity'] = quantity;
    data['sub_category_id'] = subCategoryId;
    if(providerId!=null){
      data['provider_id'] = providerId;
    }
    return data;
  }
}
