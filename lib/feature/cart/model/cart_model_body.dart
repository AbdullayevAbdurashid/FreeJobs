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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['category_id'] = this.categoryId;
    data['variant_key'] = this.variantKey;
    data['quantity'] = this.quantity;
    data['sub_category_id'] = this.subCategoryId;
    if(providerId!=null){
      data['provider_id'] = this.providerId;
    }
    return data;
  }
}
