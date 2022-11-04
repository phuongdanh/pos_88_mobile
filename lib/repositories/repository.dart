import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Repository {

  ResponseData responseData = new ResponseData(0, null);


  Future makePost(String url, {dynamic inputData, bool requiredToken: true}) async {
    if (url.substring(url.length - 1) == '/') {
      url = url.substring(0, url.length - 1);
    }
    String postData = json.encode(inputData);
    print(postData);
    Map<String, String> headers = {"Content-type": "application/json", "Accept": "application/json"};
    if (requiredToken) {
      // String? accessToken = await this.getAccessToken();
      // headers['Authorization'] = 'Bearer $accessToken';
    }
    try {
      http.Response response = await http.post(Uri.parse(url), headers: headers, body: postData);
      this.setResponse(response);
    } on SocketException catch (ex) {
      print(ex.message);
    } catch (e) {
      print(e);
    }
  }

  Future makeGet({required String url, dynamic parames, bool requiredToken: true}) async {
    print('get $url');
    if (url.substring(url.length - 1) == '/') {
      url = url.substring(0, url.length - 1);
    }
    Map<String, String> headers = {"Content-type": "application/json", "Accept": "application/json"};
    if (requiredToken) {
      // String? accessToken = await this.getAccessToken();
      // headers['Authorization'] = 'Bearer $accessToken';
    }

    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      this.setResponse(response);
    } on SocketException catch (e) {
      // this.responseData = this.handleSocketException();
    } catch (e) {}
  }


  Future makePut({required String url, dynamic inputData, bool requiredToken: true}) async {
    if (url.substring(url.length - 1) == '/') {
      url = url.substring(0, url.length - 1);
    }
    String postData = json.encode(inputData);
    Map<String, String> headers = {"Content-type": "application/json", "Accept": "application/json"};
    if (requiredToken) {
      // String? accessToken = await this.getAccessToken();
      // headers['Authorization'] = 'Bearer $accessToken';
    }
    try {
      http.Response response = await http.put(Uri.parse(url), headers: headers, body: postData);
      this.setResponse(response);
    } on SocketException catch (ex) {
      // this.responseData = this.handleSocketException();
    } catch (e) {}
  }

  Future makeDelete({required String url, bool requiredToken: true}) async {
    if (url.substring(url.length - 1) == '/') {
      url = url.substring(0, url.length - 1);
    }
    Map<String, String> headers = {"Content-type": "application/json", "Accept": "application/json"};
    if (requiredToken) {
      // String? accessToken = await this.getAccessToken();
      // headers['Authorization'] = 'Bearer $accessToken';
    }
    try {
      http.Response response = await http.delete(Uri.parse(url), headers: headers);
      this.setResponse(response);
    } on SocketException catch (ex) {
      // this.responseData = this.handleSocketException();
    } catch (e) {}
  }

  Future makeUpload(
      {required String url,
      dynamic inputData,
      required Map<String, File> fileUploads,
      bool requiredToken: true}) async {
    if (url.isEmpty) return;
    if (url.substring(url.length - 1) == '/') {
      url = url.substring(0, url.length - 1);
    }
    var request = http.MultipartRequest('POST', Uri.parse(url));
    fileUploads.forEach((k, fileUpload) async {
      var stream = new http.ByteStream(Stream.castFrom(fileUpload.openRead()));
      var length = await fileUpload.length();
      var multipartFile = new http.MultipartFile(k, stream, length, filename: basename(fileUpload.path));
      request.files.add(multipartFile);
    });
    if (inputData != null) {
      inputData.forEach((k, v) {
        if (v != null) {
          request.fields[k] = v;
        }
      });
    }
    request.headers["Accept"] = "application/json";
    if (requiredToken) {
      // String? accessToken = await this.getAccessToken();
      // request.headers['Authorization'] = 'Bearer $accessToken';
    }
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      this.setResponse(response);
    } on SocketException catch (ex) {
      // this.responseData = this.handleSocketException();
    } catch (e) {
      print(e.toString());
    }
  }

  setResponse(http.Response response) {
    Map<String, dynamic> body = jsonDecode(response.body);
    this.responseData = new ResponseData(response.statusCode, body);
  }

  bool responseSuccess() {
    // if (this.getResponse()!.statusCode <= 299 &&
    //     this.getResponse()!.statusCode >= 200 &&
    //     this.getResponse()!.success == true) {
    //   return true;
    // }
    return false;
  }

  handleSocketException() {
    // return new ResponseData(
    //     520, false, "Fail: please update new version!", {"error": "Connection is failed or old version"});
  }
}


class ResponseData {
  final int statusCode;
  dynamic data;

  ResponseData(this.statusCode, this.data);
}
