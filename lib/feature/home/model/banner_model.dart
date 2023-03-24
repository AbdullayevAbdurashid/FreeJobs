class BannerContentModel {
  int? _currentPage;
  List<BannerModel>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  String? _path;
  String? _perPage;
  int? _to;
  int? _total;

  BannerContentModel(
      {int? currentPage,
        List<BannerModel>? data,
        String? firstPageUrl,
        int? from,
        int? lastPage,
        String? lastPageUrl,
        List<Links>? links,
        String? path,
        String? perPage,
        int? to,
        int? total}) {
    if (currentPage != null) {
      this._currentPage = currentPage;
    }
    if (data != null) {
      this._data = data;
    }
    if (firstPageUrl != null) {
      this._firstPageUrl = firstPageUrl;
    }
    if (from != null) {
      this._from = from;
    }
    if (lastPage != null) {
      this._lastPage = lastPage;
    }
    if (lastPageUrl != null) {
      this._lastPageUrl = lastPageUrl;
    }
    if (links != null) {
      this._links = links;
    }

    if (path != null) {
      this._path = path;
    }
    if (perPage != null) {
      this._perPage = perPage;
    }

    if (to != null) {
      this._to = to;
    }
    if (total != null) {
      this._total = total;
    }
  }

  int? get currentPage => _currentPage;
  List<BannerModel>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  String? get path => _path;
  String? get perPage => _perPage;
  int? get to => _to;
  int? get total => _total;

  BannerContentModel.fromJson(Map<String, dynamic> json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = <BannerModel>[];
      json['data'].forEach((v) {
        _data!.add(new BannerModel.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = <Links>[];
      json['links'].forEach((v) {
        _links!.add(new Links.fromJson(v));
      });
    }
    _path = json['path'];
    _perPage = json['per_page'];
    _to = json['to'];
    _total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this._currentPage;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this._firstPageUrl;
    data['from'] = this._from;
    data['last_page'] = this._lastPage;
    data['last_page_url'] = this._lastPageUrl;
    if (this._links != null) {
      data['links'] = this._links!.map((v) => v.toJson()).toList();
    }
    data['path'] = this._path;
    data['per_page'] = this._perPage;
    data['to'] = this._to;
    data['total'] = this._total;
    return data;
  }
}

class BannerModel {
  String? _id;
  String? _bannerTitle;
  String? _resourceType;
  String? _resourceId;
  String? _redirectLink;
  String? _bannerImage;
  int? _isActive;
  String? _createdAt;
  String? _updatedAt;
  Service? _service;
  Category? _category;

  BannerModel(
      {String? id,
        String? bannerTitle,
        String? resourceType,
        String? resourceId,
        String? redirectLink,
        String? bannerImage,
        int? isActive,
        String? createdAt,
        String? updatedAt,
        Service? service,
        Category? category}) {
    if (id != null) {
      this._id = id;
    }
    if (bannerTitle != null) {
      this._bannerTitle = bannerTitle;
    }
    if (resourceType != null) {
      this._resourceType = resourceType;
    }
    if (resourceId != null) {
      this._resourceId = resourceId;
    }
    if (redirectLink != null) {
      this._redirectLink = redirectLink;
    }
    if (bannerImage != null) {
      this._bannerImage = bannerImage;
    }
    if (isActive != null) {
      this._isActive = isActive;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (service != null) {
      this._service = service;
    }
    if (category != null) {
      this._category = category;
    }
  }

  String? get id => _id;
  String? get bannerTitle => _bannerTitle;
  String? get resourceType => _resourceType;
  String? get resourceId => _resourceId;
  String? get redirectLink => _redirectLink;
  String? get bannerImage => _bannerImage;
  int? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Service? get service => _service;
  Category? get category => _category;


  BannerModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _bannerTitle = json['banner_title'];
    _resourceType = json['resource_type'];
    _resourceId = json['resource_id'];
    _redirectLink = json['redirect_link'];
    _bannerImage = json['banner_image'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    _category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['banner_title'] = this._bannerTitle;
    data['resource_type'] = this._resourceType;
    data['resource_id'] = this._resourceId;
    data['redirect_link'] = this._redirectLink;
    data['banner_image'] = this._bannerImage;
    data['is_active'] = this._isActive;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    if (this._service != null) {
      data['service'] = this._service!.toJson();
    }
    if (this._category != null) {
      data['category'] = this._category!.toJson();
    }
    return data;
  }
}

class Service {
  String? _id;
  String? _name;
  String? _shortDescription;
  String? _description;
  String? _coverImage;
  String? _thumbnail;
  String? _categoryId;
  String? _subCategoryId;
  int? _tax;
  int? _orderCount;
  int? _isActive;
  int? _ratingCount;
  var _avgRating;


  Service(
      {String? id,
        String? name,
        String? shortDescription,
        String? description,
        String? coverImage,
        String? thumbnail,
        String? categoryId,
        String? subCategoryId,
        int? tax,
        int? orderCount,
        int? isActive,
        int? ratingCount,
        int? avgRating,
        String? createdAt,
        String? updatedAt,
        List<Null>? serviceDiscount,
        List<Null>? campaignDiscount}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (shortDescription != null) {
      this._shortDescription = shortDescription;
    }
    if (description != null) {
      this._description = description;
    }
    if (coverImage != null) {
      this._coverImage = coverImage;
    }
    if (thumbnail != null) {
      this._thumbnail = thumbnail;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (subCategoryId != null) {
      this._subCategoryId = subCategoryId;
    }
    if (tax != null) {
      this._tax = tax;
    }
    if (orderCount != null) {
      this._orderCount = orderCount;
    }
    if (isActive != null) {
      this._isActive = isActive;
    }
    if (ratingCount != null) {
      this._ratingCount = ratingCount;
    }
    if (avgRating != null) {
      this._avgRating = avgRating;
    }
  }

  String? get id => _id;
  String? get name => _name;
  String? get shortDescription => _shortDescription;
  String? get description => _description;
  String? get coverImage => _coverImage;
  String? get thumbnail => _thumbnail;
  String? get categoryId => _categoryId;
  String? get subCategoryId => _subCategoryId;
  int? get tax => _tax;
  int? get orderCount => _orderCount;
  int? get isActive => _isActive;
  int? get ratingCount => _ratingCount;
  int? get avgRating => _avgRating;


  Service.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _shortDescription = json['short_description'];
    _description = json['description'];
    _coverImage = json['cover_image'];
    _thumbnail = json['thumbnail'];
    _categoryId = json['category_id'];
    _subCategoryId = json['sub_category_id'];
    _tax = json['tax'];
    _orderCount = json['order_count'];
    _isActive = json['is_active'];
    _ratingCount = json['rating_count'];
    _avgRating = json['avg_rating'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['short_description'] = this._shortDescription;
    data['description'] = this._description;
    data['cover_image'] = this._coverImage;
    data['thumbnail'] = this._thumbnail;
    data['category_id'] = this._categoryId;
    data['sub_category_id'] = this._subCategoryId;
    data['tax'] = this._tax;
    data['order_count'] = this._orderCount;
    data['is_active'] = this._isActive;
    data['rating_count'] = this._ratingCount;
    data['avg_rating'] = this._avgRating;
    return data;
  }
}

class Category {
  String? _id;
  String? _parentId;
  String? _name;
  String? _image;
  int? _position;
  int? _isActive;

  Category(
      {String? id,
        String? parentId,
        String? name,
        String? image,
        int? position,
        int? isActive,
       }) {
    if (id != null) {
      this._id = id;
    }
    if (parentId != null) {
      this._parentId = parentId;
    }
    if (name != null) {
      this._name = name;
    }
    if (image != null) {
      this._image = image;
    }
    if (position != null) {
      this._position = position;
    }

    if (isActive != null) {
      this._isActive = isActive;
    }

  }

  String? get id => _id;
  String? get parentId => _parentId;
  String? get name => _name;
  String? get image => _image;
  int? get position => _position;
  int? get isActive => _isActive;


  Category.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _image = json['image'];
    _position = json['position'];
    _isActive = json['is_active'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['parent_id'] = this._parentId;
    data['name'] = this._name;
    data['image'] = this._image;
    data['position'] = this._position;
    data['is_active'] = this._isActive;
    return data;
  }
}


class Links {
  String? _url;
  String? _label;
  bool? _active;

  Links({String? url, String? label, bool? active}) {
    if (url != null) {
      this._url = url;
    }
    if (label != null) {
      this._label = label;
    }
    if (active != null) {
      this._active = active;
    }
  }

  String? get url => _url;
  String? get label => _label;
  bool? get active => _active;


  Links.fromJson(Map<String, dynamic> json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this._url;
    data['label'] = this._label;
    data['active'] = this._active;
    return data;
  }
}
