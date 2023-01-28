import 'package:deudas_minimarket/app/core/bindings/login_binding.dart';
import 'package:get/get.dart';

import '../core/bindings/home_binding.dart';
import '../ui/pages/home/home.dart';
import '../ui/pages/home/login.dart';

part './app_routes.dart';

class AppPages {
  static List<GetPage> pages = <GetPage>[
    GetPage(
        name: Routes.LOGIN,
        page: () => const LoginScreen(),
        transition: Transition.downToUp,
        binding: LoginBinding()),
    GetPage(
        name: Routes.HOME,
        page: () => const HomeScreen(),
        transition: Transition.fadeIn,
        binding: HomeBinding()),

    // GetPage(
    //   name: Routes.REESTABLECER,
    //   page:() => ReestablecerClavePage(),
    //   transition: Transition.downToUp,
    //   binding: ReestablecerClaveBinding(),
    // ),
  ];
}
