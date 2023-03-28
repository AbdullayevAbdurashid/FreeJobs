import 'package:demandium/feature/service/model/service_model.dart';

class FeatheredCategoryModel {
  String? responseCode;
  String? message;
  FeatheredCategoryContent? content;

  FeatheredCategoryModel({this.responseCode, this.message, this.content});

  FeatheredCategoryModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? new FeatheredCategoryContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class FeatheredCategoryContent {
  int? currentPage;
  List<CategoryData>? categoryList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? path;
  String? perPage;
  int? to;
  int? total;

  FeatheredCategoryContent(
      {this.currentPage,
        this.categoryList,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total});

  FeatheredCategoryContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      categoryList = <CategoryData>[];
      json['data'].forEach((v) {
        categoryList!.add(new CategoryData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.categoryList != null) {
      data['data'] = this.categoryList!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class CategoryData {
  String? id;
  String? parentId;
  String? name;
  String? image;
  int? position;
  String? description;
  int? isActive;
  int? isFeatured;
  String? createdAt;
  String? updatedAt;
  List<Service>? servicesByCategory;
  List<ServiceDiscount>? categoryDiscount;
  List<ServiceDiscount>? campaignDiscount;

  CategoryData(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.position,
        this.description,
        this.isActive,
        this.isFeatured,
        this.createdAt,
        this.updatedAt,
        this.servicesByCategory,
        this.categoryDiscount,
        this.campaignDiscount});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    position = json['position'];
    description = json['description'];
    isActive = json['is_active'];
    isFeatured = json['is_featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['services_by_category'] != null) {
      servicesByCategory = <Service>[];
      json['services_by_category'].forEach((v) {
        servicesByCategory!.add(new Service.fromJson(v));
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
    data['is_featured'] = this.isFeatured;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.servicesByCategory != null) {
      data['services_by_category'] =
          this.servicesByCategory!.map((v) => v.toJson()).toList();
    }

    if (this.categoryDiscount != null) {
      data['category_discount'] =
          this.categoryDiscount!.map((v) => v.toJson()).toList();
    }
    if (this.campaignDiscount != null) {
      data['campaign_discount'] =
          this.campaignDiscount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
