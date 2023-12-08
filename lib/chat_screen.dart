
import 'package:employee/controller/controller.dart';
import 'package:employee/controller/message_controller.dart';
import 'package:employee/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  String ticketId;
  String title;
  ChatScreen({super.key,required this.ticketId, required this.title});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder(
        init: MessageController(ticketId: widget.ticketId),
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                      width: 5,
                    ),
                    Text(
                      "Chat",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: (){
                          ctx.getMessages();
                        },
                        child: Icon(Icons.restart_alt,color: Colors.white,))
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  color: Colors.white.withOpacity(.2),
                  child: Row(
                    children: [
                      Text("Ticket ID : ${widget.ticketId}, Ticket : ${widget.title}",style: TextStyle(color: Colors.white),),
                      Spacer(),
                      MaterialButton(
                        onPressed: () {
                          Controller().changeTicketStatus(ticketId: ctx.ticketId).then((value){
                            Get.back();
                          });
                        },
                        child: Text("Marked Done"),
                        color:
                        Theme.of(context).colorScheme.inversePrimary,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child:ctx.chatModel==null?Center(
                    child: SpinKitSquareCircle(
                      color:Theme.of(context).colorScheme.inversePrimary ,
                    ),
                  ): RawScrollbar(
                    thumbColor: Colors.white,
                    thumbVisibility: true,
                    controller: ctx.scrollController,
                    child: ListView.separated(
                      controller: ctx.scrollController,
                      separatorBuilder: (context,i)=>SizedBox(height: 10,),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        itemCount: ctx.chatModel?.data?.data?.length??0,
                        reverse: true,
                        itemBuilder: (context, i) {
                          if (ctx.chatModel?.data?.data![i].fromId != LocalStorage().readUserModel().data!.id) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).colorScheme.inversePrimary.withOpacity(.4),
                                ),
                                child: Text(
                                  "${ctx.chatModel?.data?.data![i].message}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          } else {
                            return Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(.2),
                                ),
                                child: Text(
                                  "${ctx.chatModel?.data?.data![i].message}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ),
                TextFormField(
                  controller: ctx.msgController,
                  onEditingComplete: (){
                    ctx.sendMsg();

                  },
                  style: TextStyle(fontSize: 13, color: Colors.white),
                  decoration:  InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      suffixIcon: InkWell(
                          onTap: (){
                            ctx.sendMsg();
                          },
                          child: Icon(Icons.send)),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Message Type Here ..." ,
                      border: OutlineInputBorder()),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
