import 'package:deudas_minimarket/app/core/bindings/login_binding.dart';
import 'package:deudas_minimarket/app/core/bindings/sesion_binding.dart';
import 'package:deudas_minimarket/app/routes/app_pages.dart';
import 'package:deudas_minimarket/app/ui/pages/home/home.dart';
import 'package:deudas_minimarket/app/ui/pages/home/home.dart';
import 'package:deudas_minimarket/app/ui/pages/home/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'core/bindings/home_binding.dart';
import 'core/controllers/home_controller.dart';

class MainConfigStateManagementApp extends StatelessWidget {
  const MainConfigStateManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      initialBinding: SesionBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppPages.pages,
    );
  }
}
