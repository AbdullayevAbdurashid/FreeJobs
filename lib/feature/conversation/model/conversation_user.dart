import 'package:demandium/core/common_model/provider_model.dart';

///conversation user for channel model and for conversation model
class ConversationUserModel {
  String? id;
  String? channelId;
  String? userId;
  var deletedAt;
  var createdAt;
  var updatedAt;
  int? isRead;
  ConversationUser? user;

  ConversationUserModel(
      {this.id,
        this.channelId,
        this.userId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.isRead
      });

  ConversationUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelId = json['channel_id'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new ConversationUser.fromJson(json['user']) : null;
    isRead= json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['channel_id'] = this.channelId;
    data['user_id'] = this.userId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class ConversationUser {
  String? id;
  var roleId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  var identificationNumber;
  String? identificationType;
  var dateOfBirth;
  String? gender;
  String? profileImage;
  String? fcmToken;
  int? isPhoneVerified;
  int? isEmailVerified;
  var phoneVerifiedAt;
  var emailVerifiedAt;
  int? isActive;
  String? userType;
  var rememberToken;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  ProviderModel? provider;


  ConversationUser(
      {this.id,
        this.roleId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.identificationNumber,
        this.identificationType,
        this.dateOfBirth,
        this.gender,
        this.profileImage,
        this.fcmToken,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.phoneVerifiedAt,
        this.emailVerifiedAt,
        this.isActive,
        this.userType,
        this.rememberToken,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.provider,
      });

  ConversationUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    identificationNumber = json['identification_number'];
    identificationType = json['identification_type'];

    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    profileImage = json['profile_image'];
    fcmToken = json['fcm_token'];
    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    phoneVerifiedAt = json['phone_verified_at'];
    emailVerifiedAt = json['email_verified_at'];
    isActive = json['is_active'];
    userType = json['user_type'];
    rememberToken = json['remember_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    provider = json['provider'] != null ? ProviderModel.fromJson(json['provider']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['identification_number'] = this.identificationNumber;
    data['identification_type'] = this.identificationType;

    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['profile_image'] = this.profileImage;
    data['fcm_token'] = this.fcmToken;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['is_email_verified'] = this.isEmailVerified;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['is_active'] = this.isActive;
    data['user_type'] = this.userType;
    data['remember_token'] = this.rememberToken;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}