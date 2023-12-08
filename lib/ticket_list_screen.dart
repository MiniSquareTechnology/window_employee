import 'package:employee/chat_screen.dart';
import 'package:employee/controller/controller.dart';
import 'package:employee/helping_widgets.dart';
import 'package:employee/model/change_status_model.dart';
import 'package:employee/model/ticket_list_model.dart';
import 'package:employee/model/ticket_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TicketListScreen extends StatelessWidget {
  const TicketListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder(
        init: Controller(),
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 15,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Ticket List",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 35,
                        child: TextFormField(
                          onChanged: (value){
                            ctx.searchTicket(value);
                          },
                          style: const TextStyle(fontSize: 13, color: Colors.white),
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              prefixIcon: Icon(Icons.person),
                              label: Text(
                                "Search ticket here...",
                                style: TextStyle(fontSize: 13),
                              ),
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                        onTap: () {
                          _addTicket(context,ctx);
                        },
                        child: const Icon(
                          Icons.add_circle_sharp,
                          color: Colors.white,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Expanded(
                        child: Text(
                      "ID",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                    Expanded(
                        child: Text(
                      "Created At",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                    Expanded(
                        child: Text(
                      "Title",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                    Expanded(
                        child: Text(
                      "Desciption",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                    Expanded(
                        child: Text(
                      "",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child:ctx.ticketListModel==null?Center(
                    child: SpinKitCubeGrid(
                      color: Theme.of(context)
                          .colorScheme
                          .inversePrimary,
                    ),
                  ): RawScrollbar(
                    thumbColor: Colors.white,
                    thumbVisibility: true,
                    trackVisibility: true,
                    controller: ctx.scrollController,
                    child: ListView.separated(
                      controller: ctx.scrollController,
                        itemCount: ctx.ticketListModel?.data?.data?.length??0,
                        separatorBuilder: (context, i) => Container(
                              height: 1,
                              color: Colors.grey.withOpacity(.2),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                            ),
                        itemBuilder: (context, i) {
                          TicketData data = ctx.ticketListModel?.data?.data?[i]??TicketData();
                          return InkWell(
                            onTap: () {
                              Get.to(() => ChatScreen(ticketId:data.id.toString(),title: data.title??"",))!.then((value) {
                                ctx.getTicketList();
                              });
                            },
                            child: Row(
                              children: [
                                 Expanded(
                                    child: Text(
                                  "${data.id}",
                                  style: const TextStyle(fontSize: 13, color: Colors.white),
                                )),
                                 Expanded(
                                    child: Text(
                                      "${DateFormat("dd-MMM-yyyy HH:mm").format(DateTime.parse(data.createdAt??"").toLocal())}",
                                  style: TextStyle(fontSize: 13, color: Colors.white),
                                )),
                                 Expanded(
                                    child: Text(
                                      "${data.title}",
                                  style: TextStyle(fontSize: 13, color: Colors.white),
                                )),
                                 Expanded(
                                    child: Text(
                                      "${data.description}",
                                  style: TextStyle(fontSize: 13, color: Colors.white),
                                )),
                                Expanded(
                                    child: Row(
                                  children: [
                                    MaterialButton(
                                      onPressed: ()async {
                                       TicketChangeStatusModel model = await ctx.changeTicketStatus(ticketId: data.id.toString());
                                       if(model.statusCode==200){
                                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                           content: Text(
                                             model.message ?? "",
                                             style: TextStyle(color: Colors.black),
                                           ),
                                           backgroundColor: Colors.white,
                                         ));
                                       }
                                      },
                                      child: const Text("Marked Done"),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  _addTicket(context,Controller controller) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, dialogSetState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              actions: [
                MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (titleController.value.text.trim().isEmpty) {
                      showError("Title is required", alert: true);
                      return;
                    }
                    if (descriptionController.value.text.trim().isEmpty) {
                      showError("Description is required", alert: true);
                      return;
                    }

                    TicketResponseModel model = await controller
                        .createApiTicket(
                            title: titleController.value.text,
                            description: descriptionController.value.text);
                    if (model.statusCode == 200) {
                      Get.back();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          model.message ?? "",
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.white,
                      ));
                    }
                  },
                  child: const Text("Add Ticket"),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ],
              title: Row(
                children: [
                  const Text(
                    "Add Ticket Details",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const Spacer(),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ))
                ],
              ),
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              content: SizedBox(
                height: 170,
                child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: titleController,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.white),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            label: Text(
                              "Title",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextFormField(
                        controller: descriptionController,
                        maxLines: 5,
                        minLines: 5,
                        keyboardType: TextInputType.multiline,
                        style:
                            const TextStyle(fontSize: 13, color: Colors.white),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            label: Text(
                              "Description",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
