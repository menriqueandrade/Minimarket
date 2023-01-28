import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/controllers/home_controller.dart';
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
  HomeController homeController = Get.find();
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
              iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
              actions: menuOpciones(),
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
menuOpciones(){
   HomeController homeController = Get.find();
    return [
      PopupMenuButton(
        tooltip: 'Opciones',
        initialValue: null,
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            onTap: (){},
            child: const ListTile(title: Text('Perfil'))
          ),
          PopupMenuItem(
            onTap: (){},
            child: const ListTile(title: Text('Opciones'))
          ),
          const PopupMenuItem(
            enabled: false, 
            child: Divider()
          ),
          PopupMenuItem(
             onTap: ()async{
              await homeController.cerrarSesion();
            },
            child: const ListTile(title: Text('Cerrar sesion'))
          ),
        ],
        child: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          backgroundImage: NetworkImage('https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000'),
        ),
      ),
      const SizedBox(width: 10,)
    ];
  }
