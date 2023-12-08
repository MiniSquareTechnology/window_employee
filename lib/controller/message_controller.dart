import 'dart:async';
import 'dart:developer';

import 'package:employee/api/api_urls.dart';
import 'package:employee/api/http_service.dart';
import 'package:employee/local_storage/local_storage.dart';
import 'package:employee/model/chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {

  String ticketId;
  MessageController({required this.ticketId});


  final msgController = TextEditingController();
  ScrollController scrollController = ScrollController();
  ChatModel? chatModel;
  bool loading = false;



  Future sendMsg() async {
     HttpService().post(
        url: ApiBaseUrl.sendMessage, hideLoader: true, body: {
      "ticket_id": ticketId,
      "message": msgController.value.text
    });
     chatModel!.data!.data!.insert(0,ChatData(
       fromId: int.parse(LocalStorage().readUserModel().data!.id.toString()),
       message: msgController.value.text
     ));
    msgController.clear();
    update();
  }

  Future getMessages() async {
    var response = await HttpService().get(url: ApiBaseUrl.getMessages,hideLoader: true,
        queryParam: {"ticket_id": ticketId, "page": "1"});
    chatModel = ChatModel.fromJson(response);
    update();
  }

  pagination() {
    scrollController.addListener(() {
      if ((scrollController.offset >
          scrollController.position.maxScrollExtent * .8) &&
          (loading == false)) {
        getMoreData();
      }
    });
  }

  Future getMoreData()async{
    if (chatModel!.data!.currentPage! <
        chatModel!.data!.lastPage!) {
      loading = true;
      update();
      var response = await HttpService().get(
          url: ApiBaseUrl.getMessages,
          hideLoader: true,
          queryParam: {
            "ticket_id": ticketId,
            "page":
            (chatModel!.data!.currentPage! + 1).toString()
          });
      ChatModel model =ChatModel.fromJson(response);
      chatModel!.data!.data!.addAll(model.data!.data!);
      chatModel!.data!.currentPage = model.data!.currentPage;
      chatModel!.data!.lastPage = model.data!.lastPage;
      loading=false;
      update();
    }
  }

  timer() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      if(Get.currentRoute!="/ChatScreen"){
        timer.cancel();
      }else{
        getMessages();
      }
    });
  }

  @override
  void onInit() {
    pagination();
    getMessages();
    timer();
    // TODO: implement onInit
    super.onInit();
  }

}