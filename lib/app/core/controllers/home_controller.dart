import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:deudas_minimarket/app/ui/pages/client/client_create.dart';
import 'package:deudas_minimarket/app/ui/pages/home/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repository/token_repository.dart';
import '../../ui/pages/client/client_list.dart';

class HomeController extends GetxController {
  final vista = 0.obs;
  List vistas = [
    {
      'nombre': 'Inicio',
      'icono': BootstrapIcons.house,
      'vista': const Scaffold(
        body: Text(''),
      )
    },
    {
      'nombre': 'Registrar cliente',
      'icono': BootstrapIcons.check2_square,
      'vista': CrearClienteScreen()
    },
    {
      'nombre': 'Consultas de clientes',
      'icono': BootstrapIcons.check2_square,
      'vista': ListaClienteScreen()
    },
    {
      'nombre': 'Clientes con deudas',
      'icono': BootstrapIcons.filetype_pdf,
      'vista': const Scaffold(
        body: Text(''),
      )
    },
    {
      'nombre': 'Clientes paz y salvo',
      'icono': BootstrapIcons.person,
      'vista': const Scaffold(
        body: Text(''),
      )
    },
  ];
  // @override
  // void onInit() async {
  //   String? token = await TokenRepository().getToken();
  //   if (token == null) {
  //     cerrarSesion();
  //   }
  //   super.onInit();
  // }

  // Future<void> cerrarSesion() async {
  //   await TokenRepository().deletetoken();
  //   Get.offAllNamed('/');
  // }
}
