class ReviewBody {
  String? _bookingID;
  String? _serviceID;
  String? _rating;
  String? _comment;

  ReviewBody(
      {
        required String bookingID,
        required String serviceID,
        required String rating,
        required String comment,
      }) {
    this._bookingID = bookingID;
    this._serviceID = serviceID;
    this._rating = rating;
    this._comment = comment;
  }

  ReviewBody.fromJson(Map<String, dynamic> json) {
    _bookingID = json['booking_id'];
    _serviceID = json['service_id'];
    _comment = json['review_comment'];
    _rating = json['review_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this._bookingID;
    data['service_id'] = this._serviceID;
    data['review_comment'] = this._comment;
    data['review_rating'] = this._rating;
    return data;
  }
}
