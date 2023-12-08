
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showError(msg, {bool? alert}) {
  if (alert == true) {
    showDialog(
      barrierDismissible: false,
        context: Get.context!,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.red,
              title: Text("Alert",style: TextStyle(color: Colors.white)),
              content: Text(msg,style: TextStyle(color: Colors.white),),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Okay",style: TextStyle(color: Colors.white)),
                )
              ],
            ));
  } else {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(
        msg ?? "",
        style: TextStyle(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    ));
  }
}
