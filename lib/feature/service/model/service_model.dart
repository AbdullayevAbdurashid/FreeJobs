import '../../../core/core_export.dart';

class ServiceModel {
  String? responseCode;
  String? message;
  ServiceContent? content;
  List<Errors>? errors;

  ServiceModel({this.responseCode, this.message, this.content, this.errors});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? new ServiceContent.fromJson(json['content']) : null;
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(new Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceContent {
  int? currentPage;
  List<Service>? serviceList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  var nextPageUrl;
  String? path;
  String? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  ServiceContent(
      {this.currentPage,
        this.serviceList,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  ServiceContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      serviceList = <Service>[];
      json['data'].forEach((v) {
        serviceList!.add(new Service.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.serviceList != null) {
      data['data'] = this.serviceList!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Service {
  String? id;
  String? name;
  String? shortDescription;
  String? description;
  String? coverImage;
  String? thumbnail;
  String? categoryId;
  String? subCategoryId;
  var tax;
  int? orderCount;
  int? isActive;
  int? ratingCount;
  double? avgRating;
  String? createdAt;
  String? updatedAt;
  ServiceCategory? category;
  VariationsAppFormat? variationsAppFormat;
  List<Variations>? variations;
  List<Faqs>? faqs;
  List<ServiceDiscount>? serviceDiscount;
  List<ServiceDiscount>? campaignDiscount;

  Service(
      {this.id,
        this.name,
        this.shortDescription,
        this.description,
        this.coverImage,
        this.thumbnail,
        this.categoryId,
        this.subCategoryId,
        this.tax,
        this.orderCount,
        this.isActive,
        this.ratingCount,
        this.avgRating,
        this.createdAt,
        this.updatedAt,
        this.category,
        this.variationsAppFormat,
        this.variations,
        this.faqs,
        this.serviceDiscount,
        this.campaignDiscount,
      });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    coverImage = json['cover_image'];
    thumbnail = json['thumbnail'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    tax = json['tax'];
    orderCount = json['order_count'];
    isActive = json['is_active'];
    ratingCount = json['rating_count'];
    avgRating = json['avg_rating'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    variationsAppFormat = json['variations_app_format'] != null
        ? new VariationsAppFormat.fromJson(json['variations_app_format'])
        : null;

    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(new Variations.fromJson(v));
      });
    }

    category = json['category'] != null
        ? new ServiceCategory.fromJson(json['category'])
        : null;
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(new Faqs.fromJson(v));
      });
    }
    if (json['service_discount'] != null) {
      serviceDiscount = <ServiceDiscount>[];
      json['service_discount'].forEach((v) {
        serviceDiscount!.add(new ServiceDiscount.fromJson(v));
      });
    }
    if (json['campaign_discount'] != null) {
      campaignDiscount = <ServiceDiscount>[];
      json['campaign_discount'].forEach((v) {
        campaignDiscount!.add(new ServiceDiscount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['cover_image'] = this.coverImage;
    data['thumbnail'] = this.thumbnail;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['tax'] = this.tax;
    data['order_count'] = this.orderCount;
    data['is_active'] = this.isActive;
    data['rating_count'] = this.ratingCount;
    data['avg_rating'] = this.avgRating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.variationsAppFormat != null) {
      data['variations_app_format'] = this.variationsAppFormat!.toJson();
    }

    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }

    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.faqs != null) {
      data['faqs'] = this.faqs!.map((v) => v.toJson()).toList();
    }
    if (this.serviceDiscount != null) {
      data['service_discount'] = this.serviceDiscount!.map((v) => v.toJson()).toList();
    }
    if (this.campaignDiscount != null) {
      data['campaign_discount'] = this.campaignDiscount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariationsAppFormat {
  String? zoneId;
  double? defaultPrice;
  List<ZoneWiseVariations>? zoneWiseVariations;

  VariationsAppFormat(
      {this.zoneId, this.defaultPrice, this.zoneWiseVariations});

  VariationsAppFormat.fromJson(Map<String, dynamic> json) {
    zoneId = json['zone_id'];
    defaultPrice = json['default_price'].toDouble();
    if (json['zone_wise_variations'] != null) {
      zoneWiseVariations = <ZoneWiseVariations>[];
      json['zone_wise_variations'].forEach((v) {
        zoneWiseVariations!.add(new ZoneWiseVariations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zone_id'] = this.zoneId;
    data['default_price'] = this.defaultPrice;
    if (this.zoneWiseVariations != null) {
      data['zone_wise_variations'] =
          this.zoneWiseVariations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variations {
  int? id;
  String? variant;
  String? variantKey;
  String? serviceId;
  String? zoneId;
  num? price;
  String? createdAt;
  String? updatedAt;
  Zone? zone;

  Variations(
      {this.id,
        this.variant,
        this.variantKey,
        this.serviceId,
        this.zoneId,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.zone});

  Variations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    variant = json['variant'];
    variantKey = json['variant_key'];
    serviceId = json['service_id'];
    zoneId = json['zone_id'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['variant'] = this.variant;
    data['variant_key'] = this.variantKey;
    data['service_id'] = this.serviceId;
    data['zone_id'] = this.zoneId;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ZoneWiseVariations {
  String? variantKey;
  String? variantName;
  num? price;

  ZoneWiseVariations({this.variantKey, this.variantName, this.price,});

  ZoneWiseVariations.fromJson(Map<String, dynamic> json) {
    variantKey = json['variant_key'];
    variantName = json['variant_name'];
    price = json['price'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_key'] = this.variantKey;
    data['variant_name'] = this.variantName;
    data['price'] = this.price;
    return data;
  }
}
class ServiceCategory {
  String? id;
  String? parentId;
  String? name;
  String? image;
  int? position;
  var description;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  List<ZonesBasicInfo>? zonesBasicInfo;
  List<ServiceDiscount>? categoryDiscount;
  List<ServiceDiscount>? campaignDiscount;


  ServiceCategory(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.position,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.zonesBasicInfo,
        this.categoryDiscount,
        this.campaignDiscount,
      });

  ServiceCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    position = json['position'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['zones_basic_info'] != null) {
      zonesBasicInfo = <ZonesBasicInfo>[];
      json['zones_basic_info'].forEach((v) {
        zonesBasicInfo!.add(new ZonesBasicInfo.fromJson(v));
      });
    }
    if (json['category_discount'] != null) {
      categoryDiscount = <ServiceDiscount>[];
      json['category_discount'].forEach((v) {
        categoryDiscount!.add(new ServiceDiscount.fromJson(v));
      });
    }
    if (json['campaign_discount'] != null) {
      campaignDiscount = <ServiceDiscount>[];
      json['campaign_discount'].forEach((v) {
        campaignDiscount!.add(new ServiceDiscount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['position'] = this.position;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.zonesBasicInfo != null) {
      data['zones_basic_info'] = this.zonesBasicInfo!.map((v) => v.toJson()).toList();
    }
    if (this.categoryDiscount != null) {
      data['category_discount'] = this.categoryDiscount!.map((v) => v.toJson()).toList();
    }
    if (this.campaignDiscount != null) {
      data['campaign_discount'] = this.campaignDiscount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ZonesBasicInfo {
  String? id;
  String? name;
  List<Coordinates>? coordinates;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  ZonesBasicInfo(
      {this.id,
        this.name,
        this.coordinates,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  ZonesBasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['coordinates'] != null) {
      coordinates = <Coordinates>[];
      json['coordinates'].forEach((v) {
        coordinates!.add(new Coordinates.fromJson(v));
      });
    }
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.map((v) => v.toJson()).toList();
    }
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}
class Faqs {
  String? id;
  String? question;
  String? answer;
  String? serviceId;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Faqs(
      {this.id,
        this.question,
        this.answer,
        this.serviceId,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Faqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    serviceId = json['service_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['service_id'] = this.serviceId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class ServiceDiscount {
  int? id;
  String? discountId;
  String? discountType;
  String? typeWiseId;
  String? createdAt;
  String? updatedAt;
  Discount? discount;

  ServiceDiscount(
      {this.id,
        this.discountId,
        this.discountType,
        this.typeWiseId,
        this.createdAt,
        this.updatedAt,
        this.discount});

  ServiceDiscount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountId = json['discount_id'];
    discountType = json['discount_type'];
    typeWiseId = json['type_wise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discount = json['discount'] != null
        ? new Discount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount_id'] = this.discountId;
    data['discount_type'] = this.discountType;
    data['type_wise_id'] = this.typeWiseId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.discount != null) {
      data['discount'] = this.discount!.toJson();
    }
    return data;
  }
}
