import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as Http;
import 'package:get/get.dart';
import 'package:demandium/core/common_model/errrors_model.dart';
import 'package:demandium/core/core_export.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' as Foundation;

class ApiClient extends GetxService {
  final String? appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String? noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN);
    printLog('Token: $token');
    AddressModel? _addressModel;
    try {
      _addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)!));
      printLog( _addressModel.toJson());
    }catch(e) {}

    ///pick zone id to update header
    updateHeader(
      token, _addressModel == null ? null : _addressModel.zoneId,
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
    );
  }
  void updateHeader(String? token, String? zoneIDs, String? languageCode) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.ZONE_ID: zoneIDs != null ? zoneIDs : '',
      AppConstants.LOCALIZATION_KEY: languageCode ?? AppConstants.languages[0].languageCode!,
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    printLog('====> API Call: $uri\nHeader: $_mainHeaders');
    try {
      printLog('====> API Call: $uri\nHeader: $_mainHeaders');
      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl!+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));

      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String? uri, dynamic body, {Map<String, String>? headers}) async {
    printLog('====> API Call: $uri\nHeader: $_mainHeaders');
    Http.Response _response = await Http.post(
      Uri.parse(appBaseUrl!+uri!),
      body: jsonEncode(body),
      headers: headers ?? _mainHeaders,
    ).timeout(Duration(seconds: timeoutInSeconds));
    try {
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartDataConversation(
      String? uri,
      Map<String, String> body,
      List<MultipartBody>? multipartBody,
      {Map<String, String>? headers,PlatformFile? otherFile}) async {

    Http.MultipartRequest _request = Http.MultipartRequest('POST', Uri.parse(appBaseUrl!+uri!));
    _request.headers.addAll(headers ?? _mainHeaders);

    if(otherFile != null) {
      _request.files.add(Http.MultipartFile('files[${multipartBody!.length}]', otherFile.readStream!, otherFile.size, filename: basename(otherFile.name)));
    }
    if(multipartBody!=null){
      for(MultipartBody multipart in multipartBody) {
        Uint8List _list = await multipart.file.readAsBytes();
        _request.files.add(Http.MultipartFile(
          multipart.key!, multipart.file.readAsBytes().asStream(), _list.length, filename:'${DateTime.now().toString()}.png',
        ));
      }
    }
    _request.fields.addAll(body);
    Http.Response _response = await Http.Response.fromStream(await _request.send());
    return handleResponse(_response, uri);
  }

  Future<Response> postMultipartData(String? uri, Map<String, String> body, List<MultipartBody>? multipartBody, {Map<String, String>? headers}) async {
    try {
      Http.MultipartRequest _request = Http.MultipartRequest('POST', Uri.parse(appBaseUrl!+uri!));
      _request.headers.addAll(headers ?? _mainHeaders);
      for(MultipartBody multipart in multipartBody!) {
        if(kIsWeb) {
          Uint8List _list = await multipart.file.readAsBytes();
          Http.MultipartFile _part = Http.MultipartFile(
            multipart.key!, multipart.file.readAsBytes().asStream(), _list.length,
            filename: basename(multipart.file.path), contentType: MediaType('images', 'jpg'),
          );
          _request.files.add(_part);
        }else {
          File _file = File(multipart.file.path);
          _request.files.add(Http.MultipartFile(
            multipart.key!, _file.readAsBytes().asStream(), _file.lengthSync(), filename: _file.path.split('/').last,
          ));
        }
      }
      _request.fields.addAll(body);
      Http.Response _response = await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String? uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl!+uri!),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String? uri, {Map<String, String>? headers}) async {
    try {
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl!+uri!),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String? uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    }catch(e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body, bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(_response.statusCode != 200 && _response.body != null && _response.body is !String) {
      if(_response.body.toString().startsWith('{response_code:')) {
        ErrorsModel _errorResponse = ErrorsModel.fromJson(_response.body);
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _errorResponse.responseCode);
      }else if(_response.body.toString().startsWith('{message')) {
        _response = Response(statusCode: _response.statusCode, body: _response.body, statusText: _response.body['message']);
      }
    }else if(_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if(Foundation.kDebugMode) {
       debugPrint('====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    }
    return _response;
  }
}

class MultipartBody {
  String? key;
  XFile file;

  MultipartBody(this.key, this.file);
}