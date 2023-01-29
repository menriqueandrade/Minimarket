
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../controllers/users/user_controller.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController());
  }
}