class AddressModel {
  int? id;
  var addressLabel;
  var addressType;
  String? userId;
  String? address;
  String? latitude;
  String? longitude;
  var city;
  var zipCode;
  var country;
  var zoneId;
  String? method;
  var contactPersonName;
  var contactPersonNumber;
  var contactPersonLabel;
  var street;

  AddressModel(
      {this.id,
        this.addressType,
        this.addressLabel,
        this.userId,
        this.address,
        this.latitude,
        this.longitude,
        this.city,
        this.zipCode,
        this.country,
        this.zoneId,
        this.method,
        this.contactPersonName,
        this.contactPersonNumber,
        this.contactPersonLabel,
        this.street,
      });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    contactPersonNumber = json['contact_person_number'];
    address = json['address'];
    addressType = json['address_type'];
    addressLabel = json['address_label'];
    latitude = json['lat'];
    longitude = json['lon'];
    city = json['city'];
    zipCode = json['zip_code'];
    country = json['country'];
    zoneId = json['zone_id'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    contactPersonLabel = json['address_label'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address_type'] = this.addressType;
    data['address_label'] = this.addressLabel;
    data['contact_person_name'] = this.contactPersonName;
    data['contact_person_number'] = this.contactPersonNumber;
    data['address'] = this.address;
    data['lat'] = this.latitude;
    data['lon'] = this.longitude;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['country'] = this.country;
    data['zone_id'] = this.zoneId;
    data['address_label'] = this.addressLabel;
    data['contact_person_name'] = this.contactPersonName;
    data['_method'] = this.method;
    data['street'] = this.street;
    return data;
  }
}
