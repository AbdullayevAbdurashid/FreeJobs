import 'package:demandium/core/common_model/provider_model.dart';
import 'package:demandium/core/common_model/serviceman_model.dart';
import 'package:demandium/core/common_model/user_model.dart';
import 'package:demandium/core/core_export.dart';

class BookingDetailsModel {
  String? responseCode;
  String? message;
  BookingDetailsContent? content;

  BookingDetailsModel({this.responseCode, this.message, this.content});

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? new BookingDetailsContent.fromJson(json['content']) : null;
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

class BookingDetailsContent {
  String? id;
  int? readableId;
  String? customerId;
  String? providerId;
  String? zoneId;
  String? bookingStatus;
  int? isPaid;
  String? paymentMethod;
  String? transactionId;
  num? totalBookingAmount;
  num? totalTaxAmount;
  num? totalDiscountAmount;
  String? serviceSchedule;
  String? serviceAddressId;
  String? createdAt;
  String? updatedAt;
  String? categoryId;
  String? subCategoryId;
  List<BookingContentDetailsItem>? detail;
  List<ScheduleHistories>? scheduleHistories;
  List<StatusHistories>? statusHistories;
  ServiceAddress? serviceAddress;
  Customer? customer;
  ProviderModel? provider;
  Serviceman? serviceman;
  num ? totalCampaignDiscountAmount;
  num? totalCouponDiscountAmount;


  BookingDetailsContent(
      {this.id,
        this.readableId,
        this.customerId,
        this.providerId,
        this.zoneId,
        this.bookingStatus,
        this.isPaid,
        this.paymentMethod,
        this.transactionId,
        this.totalBookingAmount,
        this.totalTaxAmount,
        this.totalDiscountAmount,
        this.serviceSchedule,
        this.serviceAddressId,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.subCategoryId,
        this.detail,
        this.scheduleHistories,
        this.statusHistories,
        this.serviceAddress,
        this.customer,
        this.provider,
        this.serviceman,
        this.totalCampaignDiscountAmount,
        this.totalCouponDiscountAmount,

      });

  BookingDetailsContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readableId = json['readable_id'];
    customerId = json['customer_id'];
    providerId = json['provider_id'];
    zoneId = json['zone_id'];
    bookingStatus = json['booking_status'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    transactionId = json['transaction_id'];
    totalBookingAmount = json['total_booking_amount'];
    totalTaxAmount = json['total_tax_amount'];
    totalDiscountAmount = json['total_discount_amount'];
    serviceSchedule = json['service_schedule'];
    serviceAddressId = json['service_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    if (json['detail'] != null) {
      detail = <BookingContentDetailsItem>[];
      json['detail'].forEach((v) {
        detail!.add(new BookingContentDetailsItem.fromJson(v));
      });
    }
    if (json['schedule_histories'] != null) {
      scheduleHistories = <ScheduleHistories>[];
      json['schedule_histories'].forEach((v) {
        scheduleHistories!.add(new ScheduleHistories.fromJson(v));
      });
    }
    if (json['status_histories'] != null) {
      statusHistories = <StatusHistories>[];
      json['status_histories'].forEach((v) {

        statusHistories!.add(new StatusHistories.fromJson(v));
      });
    }

    serviceAddress = json['service_address'] != null
        ? new ServiceAddress.fromJson(json['service_address'])
        : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    provider = json['provider'] != null
        ? new ProviderModel.fromJson(json['provider'])
        : null;
    serviceman = json['serviceman'] != null
        ? new Serviceman.fromJson(json['serviceman'])
        : null;
    totalCampaignDiscountAmount = json['total_campaign_discount_amount'];
    totalCouponDiscountAmount =json['total_coupon_discount_amount'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['readable_id'] = this.readableId;
    data['customer_id'] = this.customerId;
    data['provider_id'] = this.providerId;
    data['zone_id'] = this.zoneId;
    data['booking_status'] = this.bookingStatus;
    data['is_paid'] = this.isPaid;
    data['payment_method'] = this.paymentMethod;
    data['transaction_id'] = this.transactionId;
    data['total_booking_amount'] = this.totalBookingAmount;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['total_discount_amount'] = this.totalDiscountAmount;
    data['service_schedule'] = this.serviceSchedule;
    data['service_address_id'] = this.serviceAddressId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    if (this.scheduleHistories != null) {
      data['schedule_histories'] =
          this.scheduleHistories!.map((v) => v.toJson()).toList();
    }
    if (this.statusHistories != null) {
      data['status_histories'] =
          this.statusHistories!.map((v) => v.toJson()).toList();
    }
    if (this.serviceAddress != null) {
      data['service_address'] = this.serviceAddress!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    if (this.serviceman != null) {
      data['serviceman'] = this.serviceman!.toJson();
    }
    return data;
  }
}

class BookingContentDetailsItem {
  int? id;
  String? bookingId;
  String? serviceId;
  String? variantKey;
  num? serviceCost;
  int? quantity;
  num? discountAmount;
  num? taxAmount;
  num? totalCost;
  String? createdAt;
  String? updatedAt;
  Service? service;
  num? campaignDiscountAmount;
  num? overallCouponDiscountAmount;
  String? serviceName;


  BookingContentDetailsItem(
      {this.id,
        this.bookingId,
        this.serviceId,
        this.variantKey,
        this.serviceCost,
        this.quantity,
        this.discountAmount,
        this.taxAmount,
        this.totalCost,
        this.createdAt,
        this.updatedAt,
        this.service,
        this.campaignDiscountAmount,
        this.overallCouponDiscountAmount,
        this.serviceName,
      });

  BookingContentDetailsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    serviceId = json['service_id'];
    variantKey = json['variant_key'];
    serviceCost = json['service_cost'];
    quantity = json['quantity'];
    discountAmount = json['discount_amount'];
    taxAmount = json['tax_amount'];
    totalCost = json['total_cost'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service = json['service'] != null ? new Service.fromJson(json['service']) : null;
    campaignDiscountAmount = json['campaign_discount_amount'];
    overallCouponDiscountAmount =json['overall_coupon_discount_amount'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['service_id'] = this.serviceId;
    data['variant_key'] = this.variantKey;
    data['service_cost'] = this.serviceCost;
    data['quantity'] = this.quantity;
    data['discount_amount'] = this.discountAmount;
    data['tax_amount'] = this.taxAmount;
    data['total_cost'] = this.totalCost;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }

    data['service_name'] = this.serviceName;
    return data;
  }
}

class ScheduleHistories {
  int? id;
  String? bookingId;
  String? changedBy;
  String? schedule;
  String? createdAt;
  String? updatedAt;
  User? user;

  ScheduleHistories(
      {this.id,
        this.bookingId,
        this.changedBy,
        this.schedule,
        this.createdAt,
        this.updatedAt,
        this.user});

  ScheduleHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    changedBy = json['changed_by'];
    schedule = json['schedule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['changed_by'] = this.changedBy;
    data['schedule'] = this.schedule;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class StatusHistories {
  int? id;
  String? bookingId;
  String? changedBy;
  var bookingStatus;
  var schedule;
  String? createdAt;
  String? updatedAt;
  User? user;

  StatusHistories(
      {this.id,
        this.bookingId,
        this.changedBy,
        this.bookingStatus,
        this.schedule,
        this.createdAt,
        this.updatedAt,
        this.user});

  StatusHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['booking_id'];
    changedBy = json['changed_by'];
    bookingStatus = json['booking_status'];
    schedule = json['schedule'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.bookingId;
    data['changed_by'] = this.changedBy;
    data['booking_status'] = this.bookingStatus;
    data['schedule'] = this.schedule;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}



class ServiceAddress {
  int? id;
  String? userId;
  String? lat;
  String? lon;
  String? city;
  String? street;
  String? zipCode;
  String? country;
  String? address;
  String? createdAt;
  String? updatedAt;
  String? addressType;
  String? contactPersonName;
  String? contactPersonNumber;
  String? addressLabel;

  ServiceAddress(
      {this.id,
        this.userId,
        this.lat,
        this.lon,
        this.city,
        this.street,
        this.zipCode,
        this.country,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.addressType,
        this.contactPersonName,
        this.contactPersonNumber,
        this.addressLabel});

  ServiceAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lat = json['lat'];
    lon = json['lon'];
    city = json['city'];
    street = json['street'];
    zipCode = json['zip_code'];
    country = json['country'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    addressType = json['address_type'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    addressLabel = json['address_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['city'] = this.city;
    data['street'] = this.street;
    data['zip_code'] = this.zipCode;
    data['country'] = this.country;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['address_type'] = this.addressType;
    data['contact_person_name'] = this.contactPersonName;
    data['contact_person_number'] = this.contactPersonNumber;
    data['address_label'] = this.addressLabel;
    return data;
  }
}
