import 'package:get/get.dart';

import '../controllers/sesion_controller.dart';

class SesionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SesionController>(SesionController());
  }
}