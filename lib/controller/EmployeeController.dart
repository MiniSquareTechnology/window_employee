import 'package:employee/api/api_urls.dart';
import 'package:employee/api/http_service.dart';
import 'package:employee/local_storage/local_storage.dart';
import 'package:employee/model/employee_history_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {

  EmployeeHistoryModel? employeeHistoryModel;
  ScrollController scrollController = ScrollController();


  @override
  void onInit() {
    getHistory();
    // TODO: implement onInit
    super.onInit();
  }
  
  getHistory()async{
    employeeHistoryModel = null;
    var response = await HttpService().post(url: ApiBaseUrl.historyList, body: {
      "user_id":LocalStorage().readUserModel().data!.id.toString()
    },hideLoader: true);
    employeeHistoryModel = EmployeeHistoryModel.fromJson(response);
    update();
  }

}