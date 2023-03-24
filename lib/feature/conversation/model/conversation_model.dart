import 'package:demandium/data/model/response/config_model.dart';
import 'conversation_user.dart';

class ConversationModel {
  String? responseCode;
  String? message;
  ConversationContent? content;

  ConversationModel({this.responseCode, this.message, this.content});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    content = json['content'] != null ? new ConversationContent.fromJson(json['content']) : null;
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

class ConversationContent {
  int? currentPage;
  List<ConversationData>? conversationList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  var nextPageUrl;
  String? path;
  int? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  ConversationContent(
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

  ConversationContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      conversationList = <ConversationData>[];
      json['data'].forEach((v) {
        conversationList!.add(new ConversationData.fromJson(v));
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

///list of message
class ConversationData {
  String? id;
  String? channelId;
  String? message;
  String? userId;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  ConversationUser? user;
  List<ConversationFile>? conversationFile;

  ConversationData(
      {this.id,
        this.channelId,
        this.message,
        this.userId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.conversationFile
      });

  ConversationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelId = json['channel_id'];
    message = json['message'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new ConversationUser.fromJson(json['user']) : null;

    if (json['conversation_files'] != null) {
      conversationFile = <ConversationFile>[];
      json['conversation_files'].forEach((v) {
        conversationFile!.add(new ConversationFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['channel_id'] = this.channelId;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }

    if (this.conversationFile != null) {
      data['conversation_files'] = this.conversationFile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConversationFile {
  String? id;
  String? conversationId;
  String? fileName;
  String? fileType;
  var deletedAt;
  String? createdAt;
  String? updatedAt;

  ConversationFile(
      {this.id,
        this.conversationId,
        this.fileName,
        this.fileType,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  ConversationFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    fileName = json['file_name'];
    fileType = json['file_type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['conversation_id'] = this.conversationId;
    data['file_name'] = this.fileName;
    data['file_type'] = this.fileType;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

