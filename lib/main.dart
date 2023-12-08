import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:employee/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  launchAtStartup.setup(
    appName: packageInfo.appName,
    appPath: Platform.resolvedExecutable,
  );


  await launchAtStartup.enable();
  if(kDebugMode){
   await launchAtStartup.disable();
  }

  bool isEnabled = await launchAtStartup.isEnabled();
  runApp(const MyApp());

  doWhenWindowReady(() {
    final win = appWindow;
    win.alignment = Alignment.bottomRight;
    win.title = "Employee";
    win.size = Size(600, 340);
    win.show();
  });
  // Disable the close button (X) in the application window
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return ScreenUtilInit(
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            title: 'Employee',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home:  LoginScreen(),
           // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

