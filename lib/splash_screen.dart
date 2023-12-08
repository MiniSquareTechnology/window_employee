// import 'dart:async';
// import 'dart:developer';
//
// import 'package:bitsdojo_window/bitsdojo_window.dart';
// import 'package:desktop_window/desktop_window.dart';
// import 'package:employee/api/api_urls.dart';
// import 'package:employee/api/http_service.dart';
// import 'package:employee/login_screen.dart';
// import 'package:employee/main.dart';
// import 'package:employee/ticket_list_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:window_manager/window_manager.dart';
//
// class Splash extends StatefulWidget {
//   const Splash({super.key});
//
//   @override
//   State<Splash> createState() => _SplashState();
// }
//
// class _SplashState extends State<Splash> {
//   Timer? _timer;
//   int _start = 0;
//   String minute = "00";
//   String second = "00";
//   String hour = "00";
//   int breakCase = 0;
//
//   void startTimer() {
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(
//       oneSec,
//           (Timer timer) {
//         if (breakCase == 0) {
//           _start++;
//           formattedTime(timeInSecond: _start);
//         }
//       },
//     );
//   }
//
//   formattedTime({required int timeInSecond}) {
//     int sec = timeInSecond % 60;
//     int min = (timeInSecond / 60).floor();
//     int h = (timeInSecond / 360).floor();
//     minute = min.toString().length <= 1 ? "0$min" : "$min";
//     second = sec.toString().length <= 1 ? "0$sec" : "$sec";
//     hour = h.toString().length <= 1 ? "0$h" : "$h";
//     setState(() {});
//   }
//
//   final buttonColors = WindowButtonColors(
//       iconNormal: Colors.white,
//       mouseOver: Colors.deepPurple,
//       mouseDown: Colors.deepPurple.withOpacity(.2),
//       iconMouseOver: Colors.white,
//       iconMouseDown: Colors.deepPurple);
//
//   @override
//   void initState() {
//     startTimer();
//     DesktopWindow.toggleFullScreen();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _timer!.cancel();
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Align(
//               alignment: Alignment.centerRight,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   MinimizeWindowButton(colors: buttonColors),
//                   MaximizeWindowButton(colors: buttonColors,),
//                 ],
//               )),
//           Row(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(5.0),
//                 child: Text(
//                   "Ticket Title",
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white),
//                 ),
//               ),
//               Spacer(),
//               GestureDetector(
//                 onTap: () {
//                   _start = 0;
//                   setState(() {});
//                 },
//                 child: Icon(
//                   Icons.refresh,
//                   color: Colors.white,
//                   size: 17,
//                 ),
//               ),
//               SizedBox(
//                 width: 5,
//               ),
//               InkWell(
//                 onTap: () {
//                   Get.to(() => TicketListScreen());
//                 },
//                 child: Icon(
//                   Icons.airplane_ticket_sharp,
//                   color: Colors.white,
//                   size: 17,
//                 ),
//               ),
//               SizedBox(
//                 width: 5,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//               width: double.infinity,
//               alignment: Alignment.center,
//               margin: const EdgeInsets.symmetric(horizontal: 5),
//               padding: const EdgeInsets.all(2),
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white, width: 2)),
//               child: Text(
//                 "${hour}:${minute}:${second}",
//                 style: const TextStyle(
//                     fontSize: 40,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white),
//               )),
//           Spacer(),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: Row(
//               children: [
//                 Expanded(
//                     flex: 2,
//                     child: InkWell(
//                       onTap: (){
//                         breakCase = 0;
//                         setState(() {});
//                       },
//                       child: Container(
//                         height: 35,
//                         alignment: Alignment.center,
//                         color: Colors.white.withOpacity(.15),
//                         child: breakCase == 0
//                             ? Text(
//                           "Clock In",
//                           style:
//                           TextStyle(color: Colors.grey.withOpacity(.4)),
//                         )
//                             : Text(
//                           "I am back",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     )),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 Expanded(
//                     flex: 1,
//                     child: InkWell(
//                       onTap: ()async {
//                         if(breakCase!=0){
//                           return;
//                         }
//                         var response = await HttpService().get(url: ApiBaseUrl.logout);
//                         Get.offAll(() => LoginScreen());
//                       },
//                       child: Container(
//                         height: 35,
//                         alignment: Alignment.center,
//                         color: Colors.white.withOpacity(.15),
//                         child:  Text(
//                           "Clock Out",
//                           style: TextStyle(color:breakCase!=0?Colors.grey.withOpacity(.4): Colors.white),
//                         ),
//                       ),
//                     )),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Row(
//                     children: [
//                       Expanded(
//                           flex: 1,
//                           child: InkWell(
//                             onTap: () {
//                               breakCase = 1;
//                               setState(() {});
//                             },
//                             child: Container(
//                               height: 35,
//                               alignment: Alignment.center,
//                               color: Colors.white.withOpacity(.15),
//                               child: Text(
//                                 "Taking Break",
//                                 style: TextStyle(
//                                     color: (breakCase == 1 || breakCase!=0)
//                                         ? Colors.grey.withOpacity(.4)
//                                         : Colors.white),
//                               ),
//                             ),
//                           )),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Expanded(
//                           flex: 1,
//                           child: InkWell(
//                             onTap: () {
//                               breakCase = 2;
//                               setState(() {});
//                             },
//                             child: Container(
//                               height: 35,
//                               alignment: Alignment.center,
//                               color: Colors.white.withOpacity(.15),
//                               child: Text(
//                                 "Having Lunch",
//                                 style: TextStyle(
//                                     color: (breakCase == 2|| breakCase!=0)
//                                         ? Colors.grey.withOpacity(.4)
//                                         : Colors.white),
//                               ),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 Expanded(
//                     flex: 1,
//                     child: InkWell(
//                       onTap: () {
//                         breakCase = 3;
//                         setState(() {});
//                       },
//                       child: Container(
//                         height: 35,
//                         alignment: Alignment.center,
//                         color: Colors.white.withOpacity(.15),
//                         child: Text(
//                           "In Meeting",
//                           style: TextStyle(
//                               color: (breakCase == 3|| breakCase!=0)
//                                   ? Colors.grey.withOpacity(.4)
//                                   : Colors.white),
//                         ),
//                       ),
//                     )),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 4,
//           )
//         ],
//       ),
//     );
//   }
// }
