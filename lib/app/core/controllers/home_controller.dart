import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:deudas_minimarket/app/ui/pages/client/client_create.dart';
import 'package:deudas_minimarket/app/ui/pages/client/client_pago.dart';
import 'package:deudas_minimarket/app/ui/pages/home/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repository/token_repository.dart';
import '../../ui/pages/client/client_abono.dart';
import '../../ui/pages/client/client_chart.dart';
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
      'icono': BootstrapIcons.person_plus_fill,
      'vista': CrearClienteScreen()
    },
    {
      'nombre': 'Pago total Cliente',
      'icono': BootstrapIcons.cash_stack,
      'vista': PagoClienteScreen()
    },
    {
      'nombre': 'Abono de cliente',
      'icono': BootstrapIcons.cash_stack,
      'vista': AbonoClienteScreen()
    },
    {
      'nombre': 'Consultas de clientes',
      'icono': BootstrapIcons.search,
      'vista': ListaClienteScreen()
    },
    {
      'nombre': 'Clientes con deudas',
      'icono': BootstrapIcons.cash_coin,
      'vista': ChartScreen()
    },
    {
      'nombre': 'Clientes paz y salvo',
      'icono': BootstrapIcons.cash,
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
