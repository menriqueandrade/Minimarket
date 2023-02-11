import 'package:deudas_minimarket/app/core/controllers/client/client_controller.dart';
import 'package:deudas_minimarket/app/data/models/cliente.dart';
import 'package:deudas_minimarket/app/ui/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/error_pantalla.dart';
import 'client_deudas_details.dart';

class ListaClienteScreen extends GetResponsiveView {
  @override
  Widget builder() {
    if (screen.isWatch) {
      return const Scaffold(body: ErrorPantalla());
    }
    if (Get.height < 400) {
      return const Scaffold(body: ErrorPantalla());
    }
    Get.put(ClientController());

    return GetX<ClientController>(
      init: ClientController(),
      builder: (clientController) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Column(
          //     children: [
          //       TextField(
          //         decoration: InputDecoration(hintText: "BUSCAR"),
          //       )
          //     ],
          //   ),
          //   centerTitle: true,
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          // ),
          body: clientController.clienteObservable.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Rows(),
        );
      },
    );
  }
}

class Rows extends GetView {
  ClientController clientController = Get.put(ClientController());
  Rows({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: clientController.clienteObservable.length,
      itemBuilder: (context, index) {
        //     clientController.obtenerClientes();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Get.find<ClientController>()
                        .setClient(clientController.clienteObservable[index]!);
                    Get.to(ClienteDetailScreen());
                    //Get.to(ClienteDetailScreen(), arguments: clientController.clienteObservable[index]);
                  },
                  title: Text(clientController
                          .clienteObservable[index]!.nombreCliente ??
                      'Esta vacio'),
                  subtitle: Text(clientController
                          .clienteObservable[index]!.cedulaCliente ??
                      'Esta vacio'),
                  trailing: Text(
                      "Total Deuda: ${clientController.clienteObservable[index]!.totalDeuda}"),
                ),
              ),
            ),
            //  Text(Get.find<ClientController>().docRef.id),
          ],
        );
      },
    );
  }
}
