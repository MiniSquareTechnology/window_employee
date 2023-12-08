import 'dart:developer';

import 'package:desktop_window/desktop_window.dart';
import 'package:employee/api/api_urls.dart';
import 'package:employee/api/http_service.dart';
import 'package:employee/helping_widgets.dart';
import 'package:employee/local_storage/local_storage.dart';
import 'package:employee/model/user_model.dart';
import 'package:employee/timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class LoginScreen extends StatefulWidget {
  bool? toggle;
   LoginScreen({super.key,this.toggle});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   bool obscure = true;

   final emailController = TextEditingController();

  final passwordController = TextEditingController();

  fullScreenCheck()async{
    Size fullScree  =await DesktopWindow.getWindowSize();
    log(fullScree.toString());
    // if(widget.toggle==true){
    //   DesktopWindow.toggleFullScreen();
    // }
  }



  @override
  void initState() {
    fullScreenCheck();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Employee Login",style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.w500),),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: .7.sw,
              height: 35,
              child: TextFormField(
                controller: emailController,
                style: TextStyle(fontSize: 13),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    prefixIcon: Icon(Icons.alternate_email),
                    label: Text("Email",  style: TextStyle(fontSize: 13),),
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: .7.sw,
              height: 35,
              child: TextFormField(
                controller: passwordController,
                style: TextStyle(fontSize: 13),
                obscureText: obscure,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),

                    prefixIcon: const InkWell(child: Icon(Icons.password)),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          obscure = !obscure;
                          setState(() {});
                        },
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: obscure
                              ? null
                              : Theme.of(context).colorScheme.inversePrimary,
                        )),
                    label: const Text("Password",  style: TextStyle(fontSize: 13),),
                    border: const OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () async{
                if(emailController.value.text.trim().isEmpty){
                  showError("Please Enter Email");
                  return;
                }
                if(passwordController.value.text.trim().isEmpty){
                  showError("Please Enter Password");
                  return;
                }
                var response = await HttpService().post(url: ApiBaseUrl.login, body: {
                  "email":emailController.value.text,
                  "password":passwordController.value.text,
                  "date_time":DateTime.now().toString()
                });
                UserModel userModel = UserModel.fromJson(response);
                LocalStorage().writeUserModel(userModel);
                if(response!=null){
                  Get.offAll(()=>const TimerScreen());
                }
              },
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
