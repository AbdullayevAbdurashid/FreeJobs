import 'package:file_picker/file_picker.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:demandium/core/core_export.dart';

class ConversationRepo {

  final ApiClient apiClient;
  ConversationRepo({required this.apiClient});

  Future<Response> createChannel(String userID,String referenceID) async {
    return await apiClient.postData(AppConstants.CREATE_CHANNEL, {"to_user": userID,"reference_id":referenceID, "reference_type":"booking_id"});
  }

  Future<Response> getChannelList(int offset) async {
    return await apiClient.getData('${AppConstants.GET_CHANNEL_LIST}offset=$offset');
  }

  Future<Response> getChannelListBasedOnReferenceId(int offset,String referenceID) async {
    return await apiClient.getData('${AppConstants.GET_CHANNEL_LIST}offset=$offset&reference_id=$referenceID&reference_type=booking_id');
  }

  Future<Response> getConversation(String channelID,int offset) async {
    return await apiClient.getData('${AppConstants.GET_CONVERSATION}?channel_id=$channelID&offset=$offset');
  }

  Future<Response> sendMessage(String? message,String channelID,  List<MultipartBody>? file, PlatformFile? platformFile) async {
    return await apiClient.postMultipartDataConversation(
        AppConstants.SEND_MESSAGE,
        {"message": message??"","channel_id" : channelID},
        file ,
        otherFile: platformFile
    );
  }
}