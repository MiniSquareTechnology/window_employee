import 'dart:convert';
import 'dart:developer';


import 'package:employee/helping_widgets.dart';
import 'package:employee/local_storage/local_storage.dart';
import 'package:employee/login_screen.dart';
import 'package:employee/main.dart';
import 'package:employee/model/error_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'api_urls.dart';


class HttpService {
  Map<String, String> header = {
    "Accept": "application/json",
    "Authorization":
    "Bearer ${LocalStorage().readUserModel().data?.authToken ?? ""}"
  };

  HttpService() {
    log("Header :: $header");
  }

  var context = Get.context!;

  loader(hideLoader){
    if(hideLoader==null){
      showDialog(context: context, builder: (context)=> SpinKitCubeGrid(
        color: Theme.of(context).colorScheme.inversePrimary,
      ));
    }
  }

  Future get({
    required String url,
    Map<String, dynamic>? queryParam,
    bool? hideLoader,
    bool? alertError
  }) async {
    loader(hideLoader);
    print("GET :: " + url);
    print("PARAM :: " + queryParam.toString());
    http.Response response = await http.get(Uri.https(ApiBaseUrl.baseUrl.replaceAll("https://", ""),url.replaceAll(ApiBaseUrl.baseUrl, ""),queryParam??{}), headers: header);
    return responseParser(response,hideLoader: hideLoader,alertError: alertError);
  }

  Future post({required String url, required Map<String, dynamic> body,bool? hideLoader, bool? alertError}) async {
    loader(hideLoader);
    print("POST :: " + url);
    print("BODY :: " + body.toString());
    http.Response response =
    await http.post(Uri.parse(url), body: body, headers: header);
    return responseParser(response,hideLoader: hideLoader,alertError: alertError);
  }

  responseParser(http.Response response,{bool? hideLoader,bool? alertError}) {
    if(hideLoader==null){
      Get.back();
    }
    log("Response :: " + response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }else if(response.statusCode == 401){
      ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
      showError(errorModel.message,alert: alertError);
      Get.to(()=>LoginScreen());
      return null;
    } else {
      ErrorModel errorModel = ErrorModel.fromJson(jsonDecode(response.body));
      showError(errorModel.message,alert: alertError);
      return null;
    }
  }
}
