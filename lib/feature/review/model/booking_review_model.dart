class BookingReviewModel {
  String? id;
  String? bookingId;
  String? serviceId;
  int? reviewRating;
  String? reviewComment;
  int? isActive;
  Booking? booking;
  Service? service;

  BookingReviewModel(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.reviewRating,
        this.reviewComment,
        this.isActive,
        this.booking,
        this.service});

  BookingReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    reviewRating = json['review_rating'];
    reviewComment = json['review_comment'];
    isActive = json['is_active'];
    booking =
    json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
    data['review_rating'] = this.reviewRating;
    data['review_comment'] = this.reviewComment;
    data['is_active'] = this.isActive;
    if (this.booking != null) {
      data['booking'] = this.booking!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Booking {
  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  List<Detail>? detail;

  Booking(
      {this.id,
        this.readableId,
        this.customerId,
        this.providerId,
        this.zoneId,
        this.bookingStatus,
        this.detail});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['readable_id'] = this.readableId;
    data['customer_id'] = this.customerId;
    data['provider_id'] = this.providerId;
    data['zone_id'] = this.zoneId;
    data['booking_status'] = this.bookingStatus;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Detail {
  int? id;
  String? bookingId;
  String? serviceId;
  String? serviceName;
  String? variantKey;
  Variation? variation;

  Detail(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.serviceName,
        this.variantKey,
        this.variation});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    variantKey = json['variant_key'];
    variation = json['variation'] != null
        ? new Variation.fromJson(json['variation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['variant_key'] = this.variantKey;
    if (this.variation != null) {
      data['variation'] = this.variation!.toJson();
    }
    return data;
  }
}

class Variation {
  int? id;
  String? variant;
  String? variantKey;
  String? serviceId;

  Variation(
      {this.id,
        this.variant,
        this.variantKey,
        this.serviceId,
      });

  Variation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    variant = json['variant'];
    variantKey = json['variant_key'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['variant'] = this.variant;
    data['variant_key'] = this.variantKey;
    data['service_id'] = this.serviceId;
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
  Service(
      {this.id,
        this.name,
        this.shortDescription,
        this.description,
        this.coverImage,
        this.thumbnail,
       });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    coverImage = json['cover_image'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['cover_image'] = this.coverImage;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
