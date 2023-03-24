class WebLandingContentModel {
  String? responseCode;
  String? message;
  WebLandingContent? content;

  WebLandingContentModel(
      {this.responseCode, this.message, this.content});

  WebLandingContentModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content =
    json['content'] != null ? new WebLandingContent.fromJson(json['content']) : null;

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

class WebLandingContent {
  List<BannerImage>? bannerImage;
  List<TextContent>? textContent;
  List<ImageContent>? imageContent;
  List<Testimonial>? testimonial;
  List<SocialMedia>? socialMedia;

  WebLandingContent(
      {this.bannerImage,
        this.textContent,
        this.imageContent,
        this.testimonial});

  WebLandingContent.fromJson(Map<String, dynamic> json) {
    if (json['banner_images'] != null) {
      bannerImage = <BannerImage>[];
      json['banner_images'].forEach((v) {
        bannerImage!.add(new BannerImage.fromJson(v));
      });
    }
    if (json['text_content'] != null) {
      textContent = <TextContent>[];
      json['text_content'].forEach((v) {
        textContent!.add(new TextContent.fromJson(v));
      });
    }
    if (json['image_content'] != null) {
      imageContent = <ImageContent>[];
      json['image_content'].forEach((v) {
        imageContent!.add(new ImageContent.fromJson(v));
      });
    }
    if (json['testimonial'] != null) {
      testimonial = <Testimonial>[];
      json['testimonial'].forEach((v) {
        testimonial!.add(new Testimonial.fromJson(v));
      });
    }

    if (json['social_media'] != null) {
      socialMedia = <SocialMedia>[];
      json['social_media'].forEach((v) {
        socialMedia!.add(new SocialMedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerImage != null) {
      data['banner_images'] = this.bannerImage!.map((v) => v.toJson()).toList();
    }
    if (this.textContent != null) {
      data['text_content'] = this.textContent!.map((v) => v.toJson()).toList();
    }
    if (this.imageContent != null) {
      data['image_content'] =
          this.imageContent!.map((v) => v.toJson()).toList();
    }
    if (this.testimonial != null) {
      data['testimonial'] = this.testimonial!.map((v) => v.toJson()).toList();
    }

    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerImage {
  String? keyName;
  String? liveValues;

  BannerImage({this.keyName, this.liveValues});

  BannerImage.fromJson(Map<String, dynamic> json) {
    keyName = json['key_name'];
    liveValues = json['live_values'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key_name'] = this.keyName;
    data['live_values'] = this.liveValues;
    return data;
  }
}

class TextContent {
  String? keyName;
  String? liveValues;

  TextContent({this.keyName, this.liveValues});

  TextContent.fromJson(Map<String, dynamic> json) {
    keyName = json['key_name'];
    liveValues = json['live_values'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key_name'] = this.keyName;
    data['live_values'] = this.liveValues;
    return data;
  }
}
class ImageContent {
  String? keyName;
  String? liveValues;

  ImageContent({this.keyName, this.liveValues});

  ImageContent.fromJson(Map<String, dynamic> json) {
    keyName = json['key_name'];
    liveValues = json['live_values'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key_name'] = this.keyName;
    data['live_values'] = this.liveValues;
    return data;
  }
}

class Testimonial {
  String? id;
  String? name;
  String? designation;
  String? review;
  String? image;

  Testimonial({this.id, this.name, this.designation, this.review, this.image});

  Testimonial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    designation = json['designation'];
    review = json['review'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['review'] = this.review;
    data['image'] = this.image;
    return data;
  }
}

class SocialMedia {
  String? id;
  String? media;
  String? link;

  SocialMedia({this.id, this.media, this.link});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    media = json['media'];
    link = json['link'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['media'] = this.media;
    data['link'] = this.link;
    return data;
  }
}
class FeaturesImages {
  String? id;
  String? title;
  String? subTitle;
  String? image1;
  String? image2;

  FeaturesImages(
      {this.id, this.title, this.subTitle, this.image1, this.image2});

  FeaturesImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    image1 = json['image_1'];
    image2 = json['image_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['image_1'] = this.image1;
    data['image_2'] = this.image2;
    return data;
  }
}
