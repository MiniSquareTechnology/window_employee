import 'package:employee/controller/EmployeeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeDetailScreen extends StatefulWidget {
  EmployeeDetailScreen({super.key});

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // if (toDate.isBefore(fromDate)) {
    //   toDate = fromDate;
    //   Future.delayed(Duration(seconds: 1)).then((value){
    //     ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text("Please select 'From' and 'To' date carefully")));
    //   }
    //   );
    //
    // }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder(
            init: EmployeeController(),
            builder: (ctx) {
              return Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 15,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Total Working Hour",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      Spacer(),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "From : ",
                      //       style: TextStyle(fontSize: 15, color: Colors.white),
                      //     ),
                      //     InkWell(
                      //       onTap: () async {
                      //         fromDate = (await showDatePicker(
                      //             context: context,
                      //             initialDate: fromDate,
                      //             firstDate:
                      //             DateTime.now().subtract(Duration(days: 365)),
                      //             lastDate: DateTime.now())) ?? fromDate;
                      //         setState(() {});
                      //       },
                      //       child: Container(
                      //         alignment: Alignment.center,
                      //         padding: EdgeInsets.only(
                      //             top: 3, bottom: 7, left: 10, right: 10),
                      //         decoration: BoxDecoration(
                      //             border:
                      //             Border.all(color: Colors.grey.withOpacity(.2))),
                      //         child: Text(
                      //           DateFormat("MMMM - dd - yyyy").format(fromDate),
                      //           style: TextStyle(fontSize: 12, color: Colors.white),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // SizedBox(width: 10,),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "To : ",
                      //       style: TextStyle(fontSize: 15, color: Colors.white),
                      //     ),
                      //     InkWell(
                      //       onTap: () async {
                      //         toDate = (await showDatePicker(
                      //             context: context,
                      //             initialDate: toDate,
                      //             firstDate:
                      //             fromDate,
                      //             lastDate: DateTime.now())) ?? toDate;
                      //         setState(() {});
                      //       },
                      //       child: Container(
                      //         alignment: Alignment.center,
                      //         padding: EdgeInsets.only(
                      //             top: 3, bottom: 7, left: 10, right: 10),
                      //         decoration: BoxDecoration(
                      //             border:
                      //             Border.all(color: Colors.grey.withOpacity(.2))),
                      //         child: Text(
                      //           DateFormat("MMMM - dd - yyyy").format(toDate),
                      //           style: TextStyle(fontSize: 12, color: Colors.white),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // Spacer(),
                      // MaterialButton(
                      //   color: Theme
                      //       .of(context)
                      //       .colorScheme
                      //       .inversePrimary,
                      //   onPressed: () {},
                      //   child: Text(
                      //     "Submit",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 26,
                      ),
                      Text(
                        '00h : 00m     ',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        "Time",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      )),
                      Expanded(
                          child: Text("Duration",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13))),
                      Expanded(
                          child: Text("Type",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13))),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: ctx.employeeHistoryModel == null
                          ? Center(
                              child: SpinKitSquareCircle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            )
                          : RawScrollbar(
                        thumbColor: Colors.white,
                        thumbVisibility: true,
                        controller: ctx.scrollController,
                            child: ListView.separated(
                              controller:  ctx.scrollController,
                                itemCount:
                                    ctx.employeeHistoryModel?.data?.length ?? 0,
                                separatorBuilder: (context, i) => Container(
                                      height: 1,
                                      color: Colors.grey.withOpacity(.2),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                    ),
                                itemBuilder: (context, i) {
                                  return Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        DateFormat("yyyy-MM-dd hh:mm:ss a").format(
                                            DateTime.parse(ctx
                                                        .employeeHistoryModel
                                                        ?.data?[i]
                                                        .dateTime ??
                                                    DateTime.now().toString())
                                        ),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 11),
                                      )),
                                      Expanded(
                                          child: Text(
                                              "${ctx.employeeHistoryModel?.data?[i].totalHours ?? "-"}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11))),
                                      Expanded(
                                          child: Text(
                                              "${statusConvert(int.parse(ctx.employeeHistoryModel?.data?[i].status??"0")) ?? "-"}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11))),
                                    ],
                                  );
                                }),
                          ))
                ],
              );
            }),
      ),
    );
  }

  static const clockIn = 1;
  static const clockOut = 2;
  static const lunchIn = 3;
  static const lunchOut = 4;
  static const meetingIn = 5;
  static const meetingOut = 6;
  static const breakIn = 7;
  static const breakOut = 8;

  String statusConvert(int statusGet) {
    String status = "";
    switch (statusGet) {
      case clockIn:
        status = "Clock In";
        break;
      case clockOut:
        status = "Clock Out";

        break;
      case lunchIn:
        status = "Lunch In";

        break;
      case lunchOut:
        status = "Lunch Out";

        break;
      case meetingIn:
        status = "Meeting In";

        break;
      case meetingOut:
        status = "Meeting Out";

        break;
      case breakIn:
        status = "Break In";

        break;
      case breakOut:
        status = "Break out";

        break;
    }
    return status;
  }
}
