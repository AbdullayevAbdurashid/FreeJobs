class BasicCampaignModel {
  int? id;
  String? title;
  var image;
  String? description;
  String? availableDateStarts;
  String? availableDateEnds;
  String? startTime;
  String? endTime;

  BasicCampaignModel(
      {this.id,
        this.title,
        this.image,
        this.description,
        this.availableDateStarts,
        this.availableDateEnds,
        this.startTime,
        this.endTime,});

  BasicCampaignModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['images'];
    description = json['description'];
    availableDateStarts = json['available_date_starts'];
    availableDateEnds = json['available_date_ends'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['images'] = this.image;
    data['description'] = this.description;
    data['available_date_starts'] = this.availableDateStarts;
    data['available_date_ends'] = this.availableDateEnds;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
