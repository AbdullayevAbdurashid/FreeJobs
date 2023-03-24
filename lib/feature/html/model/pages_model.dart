import 'package:demandium/feature/location/model/place_details_model.dart';

class PagesModel {
  String? responseCode;
  String? message;
  PagesContent? content;
  List<Errors>? errors;

  PagesModel({this.responseCode, this.message, this.content, this.errors});

  PagesModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? new PagesContent.fromJson(json['content']) : null;
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

class PagesContent {
  AboutUs? aboutUs;
  AboutUs? termsAndConditions;
  AboutUs? privacyPolicy;
  AboutUs? refundPolicy;
  AboutUs? returnPolicy;
  AboutUs? cancellationPolicy;

  PagesContent(
      {this.aboutUs,
        this.termsAndConditions,
        this.privacyPolicy,
        this.refundPolicy,
        this.returnPolicy,
        this.cancellationPolicy});

  PagesContent.fromJson(Map<String, dynamic> json) {
    aboutUs = json['about_us'] != null
        ? new AboutUs.fromJson(json['about_us'])
        : null;
    termsAndConditions = json['terms_and_conditions'] != null
        ? new AboutUs.fromJson(json['terms_and_conditions'])
        : null;
    privacyPolicy = json['privacy_policy'] != null
        ? new AboutUs.fromJson(json['privacy_policy'])
        : null;
    refundPolicy = json['refund_policy'] != null
        ? new AboutUs.fromJson(json['refund_policy'])
        : null;
    returnPolicy = json['return_policy'];
    cancellationPolicy = json['cancellation_policy'] != null
        ? new AboutUs.fromJson(json['cancellation_policy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aboutUs != null) {
      data['about_us'] = this.aboutUs!.toJson();
    }
    if (this.termsAndConditions != null) {
      data['terms_and_conditions'] = this.termsAndConditions!.toJson();
    }
    if (this.privacyPolicy != null) {
      data['privacy_policy'] = this.privacyPolicy!.toJson();
    }
    if (this.refundPolicy != null) {
      data['refund_policy'] = this.refundPolicy!.toJson();
    }
    data['return_policy'] = this.returnPolicy;
    if (this.cancellationPolicy != null) {
      data['cancellation_policy'] = this.cancellationPolicy!.toJson();
    }
    return data;
  }
}

class AboutUs {
  String? id;
  String? keyName;
  String? liveValues;
  String? settingsType;
  String? mode;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  AboutUs(
      {this.id,
        this.keyName,
        this.liveValues,
        this.settingsType,
        this.mode,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  AboutUs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyName = json['key_name'];
    liveValues = json['live_values'];
    settingsType = json['settings_type'];
    mode = json['mode'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key_name'] = this.keyName;
    data['live_values'] = this.liveValues;
    data['settings_type'] = this.settingsType;
    data['mode'] = this.mode;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}