import 'package:get/get.dart';

import '../controllers/client/client_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ClientController>(ClientController());
  }
}
