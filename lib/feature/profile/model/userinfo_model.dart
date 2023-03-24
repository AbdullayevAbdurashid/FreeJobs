class UserInfoModel {
  String? id;
  String? fName;
  String? lName;
  String? email;
  String? image;
  String? phone;
  String? password;
  String? confirmPassword;
  String? createdAt;
  num? bookingsCount;

  UserInfoModel(
      {this.id,
        this.fName,
        this.lName,
        this.email,
        this.image,
        this.phone,
        this.password,
        this.confirmPassword,
        this.createdAt,
        this.bookingsCount,
      });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['first_name'];
    lName = json['last_name'];
    email = json['email'];
    image = json['profile_image'];
    phone = json['phone'];
    createdAt = json['created_at'];
    bookingsCount = json['bookings_count'] != null ? int.parse(json['bookings_count'].toString()) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.fName;
    data['last_name'] = this.lName;
    data['email'] = this.email;
    data['profile_image'] = this.image;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}
