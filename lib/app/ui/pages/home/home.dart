import 'package:deudas_minimarket/app/core/controllers/sesion_controller.dart';
import 'package:deudas_minimarket/app/core/controllers/users/user_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/controllers/home_controller.dart';
import '../../../core/controllers/login_controller.dart';
import '../../../routes/app_pages.dart';
import '../../theme/colores.dart';
import '../../widgets/error_pantalla.dart';
import 'login.dart';
import 'menu_lateral.dart';

class HomeScreen extends GetView {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHome();
  }
}

class ResponsiveHome extends GetResponsiveView {
  final _isLoggedIn = Get.put(false);
  HomeController homeController = Get.find();
  LoginController sesionController = Get.find();
  ResponsiveHome({super.key});
  @override
  Widget builder() {
    if (screen.isWatch) {
      return const Scaffold(body: ErrorPantalla());
    }
    if (Get.height < 400) {
      return const Scaffold(body: ErrorPantalla());
    }
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colores.rojo,
              centerTitle: true,
              title: Text("Minimarket"),
              iconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 255, 255, 255)),
              actions: menuOpciones(sesionController),
            )),
        /**
       * muestra las opciones del menu
       * - inicio
       * - reserva o compra 
       * - usuarios (esta opcion la muestra cuando el tamaño de la pantalla no es escritorio)
       */
        drawer: MenuDrawer(),
        body: Row(
          children: [
            //muestra el menu lateral solo si es escritorio
            !screen.isDesktop ? Container() : MenuLateral(),

            //muestra el contrnido del item seleccionado
            //el contenido de la lista es cargado con los elementos de la lista definida en home controller vistas
            Expanded(
                child: Container(
              color: Colores.rojo,
              child: Obx(() =>
                  homeController.vistas[homeController.vista.value]['vista']),
            )),
          ],
        ));
  }
}

menuOpciones(LoginController loginController) {
 // LoginController loginController = Get.find();
  return [
    PopupMenuButton(
      tooltip: 'Opciones',
      initialValue: null,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
            onTap: () {}, child: const ListTile(title: Text('Perfil'))),
        PopupMenuItem(
            onTap: () {}, child: const ListTile(title: Text('Opciones'))),
        const PopupMenuItem(enabled: false, child: Divider()),
        PopupMenuItem(
            onTap: () async {
             await loginController.cerrarSesion();
            },
            child: const ListTile(title: Text('Cerrar sesion'))),
      ],
      child: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        backgroundImage: NetworkImage(
            'https://png.pngtree.com/thumb_back/fw800/background/20210222/pngtree-line-business-orange-background-image_564081.jpg'),
      ),
    ),
    const SizedBox(
      width: 10,
    )
  ];
}
