
class NotificationBody {
  String? title;
  String? body;
  String? bookingId;
  String? type;
  String? image;

  NotificationBody(
      {this.title, this.body, this.bookingId, this.type, this.image});

  NotificationBody.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    bookingId = json['booking_id'];
    type = json['type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['booking_id'] = this.bookingId;
    data['type'] = this.type;
    data['image'] = this.image;
    return data;
  }
}
