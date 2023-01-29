import 'package:deudas_minimarket/app/core/bindings/login_binding.dart';
import 'package:deudas_minimarket/app/ui/pages/home/register.dart';
import 'package:get/get.dart';

import '../core/bindings/client/register_binding.dart';
import '../core/bindings/home_binding.dart';
import '../core/bindings/users/users_binding.dart';
import '../ui/pages/client/client_create.dart';
import '../ui/pages/client/client_list.dart';
import '../ui/pages/home/home.dart';
import '../ui/pages/home/login.dart';

part './app_routes.dart';

class AppPages {
  static List<GetPage> pages = <GetPage>[
    GetPage(
        name: Routes.LOGIN,
        page: () => LoginScreen(),
        transition: Transition.downToUp,
        binding: LoginBinding()),
    GetPage(
        name: Routes.HOME,
        page: () => const HomeScreen(),
        transition: Transition.fadeIn,
        binding: HomeBinding()),
    GetPage(
        name: Routes.REGISTRO,
        page: () => const RegisterScreen(),
        transition: Transition.fadeIn,
        binding: UserBinding()),
        
    GetPage(
      name: Routes.CREARCLIENTE,
      page: () => CrearClienteScreen(),
      transition: Transition.downToUp,
      binding: RegisterClientBinding(),
    ),
    GetPage(
      name: Routes.LISTACLIENTE,
      page: () => ListaClienteScreen(),
      transition: Transition.downToUp,
      binding: RegisterClientBinding(),
    ),
  ];
}
