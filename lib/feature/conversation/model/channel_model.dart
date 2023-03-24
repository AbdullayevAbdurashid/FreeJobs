import 'package:demandium/data/model/response/config_model.dart';
import 'package:demandium/feature/conversation/model/conversation_user.dart';

class ChannelModel {
  String? responseCode;
  String? message;
  ChannelContent? conversationContent;

  ChannelModel({this.responseCode, this.message, this.conversationContent});

  ChannelModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    conversationContent = json['content'] != null ? new ChannelContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    if (this.conversationContent != null) {
      data['content'] = this.conversationContent!.toJson();
    }
    return data;
  }
}

class ChannelContent {
  int? currentPage;
  List<ChannelData>? conversationList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  var nextPageUrl;
  String? path;
  String? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  ChannelContent(
      {this.currentPage,
        this.conversationList,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  ChannelContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      conversationList = <ChannelData>[];
      json['data'].forEach((v) {
        conversationList!.add(new ChannelData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.conversationList != null) {
      data['data'] = this.conversationList!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class ChannelData {
  String? id;
  var referenceId;
  var referenceType;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  int? channelUsersCount;
  List<ConversationUserModel>? channelUsers;

  ChannelData(
      {this.id,
        this.referenceId,
        this.referenceType,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.channelUsersCount,
        this.channelUsers});

  ChannelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceId = json['reference_id'];
    referenceType = json['reference_type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    channelUsersCount = json['channel_users_count'];
    if (json['channel_users'] != null) {
      channelUsers = <ConversationUserModel>[];
      json['channel_users'].forEach((v) {
        channelUsers!.add(new ConversationUserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference_id'] = this.referenceId;
    data['reference_type'] = this.referenceType;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['channel_users_count'] = this.channelUsersCount;
    if (this.channelUsers != null) {
      data['channel_users'] =
          this.channelUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



