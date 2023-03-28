class SuggestedServiceModel {
  Content? content;
  SuggestedServiceModel({ this.content});
  SuggestedServiceModel.fromJson(Map<String, dynamic> json) {
    content = json['content'] != null ? new Content.fromJson(json['content']) : null;

  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class Content {
  int? currentPage;
  List<SuggestedService>? suggestedServiceList;
  int? lastPage;
  String? lastPageUrl;
  int? total;

  Content(
      {this.currentPage,
        this.suggestedServiceList,
        this.lastPage,
        this.lastPageUrl,
        this.total});

  Content.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      suggestedServiceList = <SuggestedService>[];
      json['data'].forEach((v) {
        suggestedServiceList!.add(new SuggestedService.fromJson(v));
      });
    }
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.suggestedServiceList != null) {
      data['data'] = this.suggestedServiceList!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['total'] = this.total;
    return data;
  }
}

class SuggestedService {
  String? id;
  String? categoryId;
  String? serviceName;
  String? serviceDescription;
  String? status;
  String? adminFeedback;
  String? userId;
  String? createdAt;
  String? updatedAt;
  Category? category;

  SuggestedService(
      {this.id,
        this.categoryId,
        this.serviceName,
        this.serviceDescription,
        this.status,
        this.adminFeedback,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.category});

  SuggestedService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    serviceName = json['service_name'];
    serviceDescription = json['service_description'];
    status = json['status'];
    adminFeedback = json['admin_feedback'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['service_name'] = this.serviceName;
    data['service_description'] = this.serviceDescription;
    data['status'] = this.status;
    data['admin_feedback'] = this.adminFeedback;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  String? id;
  String? parentId;
  String? name;
  String? image;


  Category(
      {this.id,
        this.parentId,
        this.name,
        this.image,
      });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['image'] = this.image;
 
    
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
