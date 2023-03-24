import 'dart:convert';

class ConfigModel {
  String? responseCode;
  String? message;
  Content? content;

  ConfigModel({this.responseCode, this.message, this.content});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
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

class Content {
  String? businessName;
  String? logo;
  String? providerSelfRegistration;
  String? countryCode;
  String? businessAddress;
  String? businessPhone;
  String? businessEmail;
  String? baseUrl;
  String? currencyDecimalPoint;
  String? currencySymbolPosition;
  String? currencyCode;
  String? privacyPolicy;
  String? termsAndConditions;
  String? cancellationPolicy;
  String? refundPolicy;
  String? aboutUs;
  String? country;
  DefaultLocation? defaultLocation;
  String? appUrlAndroid;
  String? appUrlIos;
  int? smsVerification;
  MapApiKey? mapApiKey;
  String? imageBaseUrl;
  int? paginationLimit;
  List<Languages>? languages;
  List<Currencies>? currencies;
  List<Countries>? countries;
  List<String>? timeZones;
  UserLocationInfo? userLocationInfo;
  List<String>? paymentGateways;
  AdminDetails? adminDetails;
  MinimumVersion? minimumVersion;
  String? footerText;
  int? googleSocialLogin;
  int? facebookSocialLogin;


  Content(
      {this.businessName,
        this.logo,
        this.providerSelfRegistration,
        this.countryCode,
        this.businessAddress,
        this.businessPhone,
        this.businessEmail,
        this.baseUrl,
        this.currencyDecimalPoint,
        this.currencySymbolPosition,
        this.currencyCode,
        this.privacyPolicy,
        this.cancellationPolicy,
        this.refundPolicy,
        this.aboutUs,
        this.country,
        this.defaultLocation,
        this.appUrlAndroid,
        this.appUrlIos,
        this.smsVerification,
        this.mapApiKey,
        this.imageBaseUrl,
        this.paginationLimit,
        this.languages,
        this.currencies,
        this.countries,
        this.timeZones,
        this.userLocationInfo,
        this.paymentGateways,
        this.minimumVersion,
        this.footerText,
        this.googleSocialLogin,
      });

  Content.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    logo = json['logo'];
    countryCode = json['country_code'];
    providerSelfRegistration = json['provider_self_registration'];
    businessAddress = json['business_address'];
    businessPhone = json['business_phone'];
    businessEmail = json['business_email'];
    baseUrl = json['base_url'];
    currencyDecimalPoint = json['currency_decimal_point'];
    currencySymbolPosition = json['currency_symbol_position'];
    currencyCode = json['currency_code'];
    privacyPolicy = json['privacy_policy'];
    termsAndConditions = json['terms_and_conditions'];
    cancellationPolicy = json['cancellation_policy'];
    refundPolicy = json['refund_policy'];
    aboutUs = json['about_us'];
    country = json['country'];
    defaultLocation = json['default_location'] != null ? new DefaultLocation.fromJson(json['default_location']) : null;
    appUrlAndroid = json['app_url_playstore'];
    appUrlIos = json['app_url_appstore'];
    smsVerification = json['sms_verification'];
    mapApiKey = json['map_api_key'] != null
        ? new MapApiKey.fromJson(json['map_api_key'])
        : null;
    imageBaseUrl = json['image_base_url'];
    paginationLimit = json['pagination_limit'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
    if (json['currencies'] != null) {
      currencies = <Currencies>[];
      json['currencies'].forEach((v) {
        currencies!.add(new Currencies.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    timeZones = json['time_zones'].cast<String>();
    userLocationInfo = UserLocationInfo.fromJson(json['user_location_info']);

    paymentGateways = json['payment_gateways'].cast<String>();
    adminDetails = json['admin_details'] != null ? new AdminDetails.fromJson(json['admin_details']) : null;
    minimumVersion = json['min_versions'] != null ? new MinimumVersion.fromJson(json['min_versions']) : null;
    footerText = json['footer_text'] != null ? json['footer_text'] : null;
    googleSocialLogin = json['google_social_login'] != null ? json['google_social_login'] : null;
    facebookSocialLogin = json['facebook_social_login'] != null ? json['facebook_social_login'] : null;
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    data['logo'] = this.logo;
    data['provider_self_registration'] = this.providerSelfRegistration;
    data['country_code'] = this.countryCode;
    data['business_address'] = this.businessAddress;
    data['business_phone'] = this.businessPhone;
    data['business_email'] = this.businessEmail;
    data['base_url'] = this.baseUrl;
    data['currency_decimal_point'] = this.currencyDecimalPoint;
    data['currency_symbol_position'] = this.currencySymbolPosition;
    data['currency_code'] = this.currencyCode;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['privacy_policy'] = this.privacyPolicy;
    data['cancellation_policy'] = this.cancellationPolicy;
    data['refund_policy'] = this.refundPolicy;
    data['about_us'] = this.aboutUs;
    data['country'] = this.country;
    if (this.defaultLocation != null) {
      data['default_location'] = this.defaultLocation!.toJson();
    }
    data['app_url_playstore'] = this.appUrlAndroid;
    data['app_url_appstore'] = this.appUrlIos;
    data['sms_verification'] = this.smsVerification;
    if (this.mapApiKey != null) {
      data['map_api_key'] = this.mapApiKey!.toJson();
    }
    data['image_base_url'] = this.imageBaseUrl;
    data['pagination_limit'] = this.paginationLimit;
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    if (this.currencies != null) {
      data['currencies'] = this.currencies!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    data['time_zones'] = this.timeZones;

    data['payment_gateways'] = this.paymentGateways;
    if (this.adminDetails != null) {
      data['admin_details'] = this.adminDetails!.toJson();
    }
    if (this.minimumVersion != null) {
      data['min_versions'] = this.minimumVersion!.toJson();
    }
    data['footer_text'] = this.footerText;
    data['google_social_login'] = this.googleSocialLogin;
    data['facebook_social_login'] = this.facebookSocialLogin;

    return data;
  }
}

class DefaultLocation {
  Location? location;

  DefaultLocation({this.location});

  DefaultLocation.fromJson(Map<String, dynamic> json) {
    location = json['default'] != null ?
        new Location.fromJson(json['default'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null){
      data['default'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lon;

  Location({this.lat, this.lon});

  Location.fromJson(Map<String, dynamic> json) {
    lat = double.tryParse(json['lat']);
    lon = double.tryParse(json['lon']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class MinimumVersion {
  String? minVersionForAndroid;
  String? minVersionForIos;

  MinimumVersion({this.minVersionForAndroid, this.minVersionForIos});


  MinimumVersion.fromJson(Map<String, dynamic> json) {
    minVersionForAndroid = json['min_version_for_android'];
    minVersionForIos = json['min_version_for_ios'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_version_for_android'] = this.minVersionForAndroid;
    data['min_version_for_ios'] = this.minVersionForIos;
    return data;
  }
}

class MapApiKey {
  String? id;
  String? keyName;
  LiveValues? liveValues;
  LiveValues? testValues;
  String? settingsType;
  String? mode;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  MapApiKey(
      {this.id,
        this.keyName,
        this.liveValues,
        this.testValues,
        this.settingsType,
        this.mode,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  MapApiKey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyName = json['key_name'];
    liveValues = json['live_values'] != null
        ? new LiveValues.fromJson(json['live_values'])
        : null;
    testValues = json['test_values'] != null
        ? new LiveValues.fromJson(json['test_values'])
        : null;
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
    if (this.liveValues != null) {
      data['live_values'] = this.liveValues!.toJson();
    }
    if (this.testValues != null) {
      data['test_values'] = this.testValues!.toJson();
    }
    data['settings_type'] = this.settingsType;
    data['mode'] = this.mode;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class LiveValues {
  String? partyName;
  String? mapApiKeyClient;
  String? mapApiKeyServer;

  LiveValues({this.partyName, this.mapApiKeyClient, this.mapApiKeyServer});

  LiveValues.fromJson(Map<String, dynamic> json) {
    partyName = json['party_name'];
    mapApiKeyClient = json['map_api_key_client'];
    mapApiKeyServer = json['map_api_key_server'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['party_name'] = this.partyName;
    data['map_api_key_client'] = this.mapApiKeyClient;
    data['map_api_key_server'] = this.mapApiKeyServer;
    return data;
  }
}

class Languages {
  String? code;
  String? name;
  String? nativeName;

  Languages({this.code, this.name, this.nativeName});

  Languages.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    nativeName = json['nativeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['nativeName'] = this.nativeName;
    return data;
  }
}

class Currencies {
  String? code;
  String? symbol;
  String? name;

  Currencies({this.code, this.symbol, this.name});

  Currencies.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    symbol = json['symbol'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    return data;
  }
}

class Countries {
  String? name;
  String? code;

  Countries({this.name, this.code});

  Countries.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}


class Zones {
  String? id;
  String? name;
  List<Coordinates>? coordinates;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Zones(
      {this.id,
        this.name,
        this.coordinates,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Zones.fromJson(Map<String, dynamic> json) {
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

class Coordinates {
  double? lat;
  double? lng;

  Coordinates({this.lat, this.lng});

  Coordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Pivot {
  String? categoryId;
  String? zoneId;

  Pivot({this.categoryId, this.zoneId});

  Pivot.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    zoneId = json['zone_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['zone_id'] = this.zoneId;
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


String userLocationInfoToJson(UserLocationInfo data) => json.encode(data.toJson());

class UserLocationInfo {
  String? ip;
  String? countryName;
  String? countryCode;
  String? regionCode;
  String? regionName;
  String? cityName;
  String? zipCode;
  String? isoCode;
  String? postalCode;
  String? latitude;
  String? longitude;
  String? metroCode;
  String? areaCode;
  String? timezone;
  String? driver;

  UserLocationInfo(
      {this.ip,
        this.countryName,
        this.countryCode,
        this.regionCode,
        this.regionName,
        this.cityName,
        this.zipCode,
        this.isoCode,
        this.postalCode,
        this.latitude,
        this.longitude,
        this.metroCode,
        this.areaCode,
        this.timezone,
        this.driver});

  UserLocationInfo.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    regionCode = json['regionCode'];
    regionName = json['regionName'];
    cityName = json['cityName'];
    zipCode = json['zipCode'];
    isoCode = json['isoCode'];
    postalCode = json['postalCode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    metroCode = json['metroCode'];
    areaCode = json['areaCode'];
    timezone = json['timezone'];
    driver = json['driver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ip'] = this.ip;
    data['countryName'] = this.countryName;
    data['countryCode'] = this.countryCode;
    data['regionCode'] = this.regionCode;
    data['regionName'] = this.regionName;
    data['cityName'] = this.cityName;
    data['zipCode'] = this.zipCode;
    data['isoCode'] = this.isoCode;
    data['postalCode'] = this.postalCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['metroCode'] = this.metroCode;
    data['areaCode'] = this.areaCode;
    data['timezone'] = this.timezone;
    data['driver'] = this.driver;
    return data;
  }
}

class AdminDetails {
  String? id;
  String? firstName;
  String? lastName;
  String? profileImage;

  AdminDetails(
      {String? id, String? firstName, String? lastName, String? profileImage}) {
    if (id != null) {
      this.id = id;
    }
    if (firstName != null) {
      this.firstName = firstName;
    }
    if (lastName != null) {
      this.lastName = lastName;
    }
    if (profileImage != null) {
      this.profileImage = profileImage;
    }
  }


  AdminDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_image'] = this.profileImage;
    return data;
  }
}

