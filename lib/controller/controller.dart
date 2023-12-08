import 'package:employee/api/api_urls.dart';
import 'package:employee/api/http_service.dart';
import 'package:employee/model/change_status_model.dart';
import 'package:employee/model/ticket_list_model.dart';
import 'package:employee/model/ticket_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  TicketListModel? ticketListModel;
  ScrollController scrollController = ScrollController();
  bool loading = false;

  Future<TicketResponseModel> createApiTicket(
      {required String title, required String description}) async {
    var response = await HttpService().post(
        url: ApiBaseUrl.createTicket,
        body: {"title": title, "description": description},
        alertError: true);
    ticketListModel = TicketListModel.fromJson(response);
    update();
    return TicketResponseModel.fromJson(response);
  }

  searchTicket(search) async {
    loading = false;
    var response = await HttpService().get(
        url: ApiBaseUrl.ticketList,
        hideLoader: true,
        queryParam: {"search": search});
    ticketListModel = TicketListModel.fromJson(response);
    update();
  }

  Future getTicketList() async {
    var response =
        await HttpService().get(url: ApiBaseUrl.ticketList, hideLoader: true);
    ticketListModel = TicketListModel.fromJson(response);
    update();
  }

  Future<TicketChangeStatusModel> changeTicketStatus({required String ticketId}) async {
    var response = await HttpService().post(
        url: ApiBaseUrl.changeTicketStatus, body: {"ticket_id": ticketId});
    TicketChangeStatusModel ticketChangeStatusModel = TicketChangeStatusModel.fromJson(response);
    ticketListModel = TicketListModel.fromJson(response);
    update();
    return ticketChangeStatusModel;
  }

  Future getMoreData()async{
    if (ticketListModel!.data!.currentPage! <
        ticketListModel!.data!.lastPage!) {
      loading = true;
      update();
      var response = await HttpService().get(
          url: ApiBaseUrl.ticketList,
          hideLoader: true,
          queryParam: {
            "page":
            (ticketListModel!.data!.currentPage! + 1).toString()
          });
      TicketListModel model =TicketListModel.fromJson(response);
      ticketListModel!.data!.data!.addAll(model.data!.data!);
      ticketListModel!.data!.currentPage = model.data!.currentPage;
      ticketListModel!.data!.lastPage = model.data!.lastPage;
      loading=false;
      update();
    }
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

  @override
  void onInit() {
    getTicketList();
    pagination();
    // TODO: implement onInit
    super.onInit();
  }
}
