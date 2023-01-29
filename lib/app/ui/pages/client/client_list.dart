import 'package:deudas_minimarket/app/core/controllers/client/client_controller.dart';
import 'package:deudas_minimarket/app/data/models/cliente.dart';
import 'package:deudas_minimarket/app/ui/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListaClienteScreen extends GetView {
  @override
  Widget build(BuildContext context) {
    Get.put(ClientController());

    return GetX<ClientController>(
      init: ClientController(),
      builder: (clientController) {
        return Scaffold(
          body: clientController.clienteObservable.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: clientController.clienteObservable.length,
                  itemBuilder: (context, index) {
               //     clientController.obtenerClientes();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(clientController
                                  .clienteObservable[index]!.nombreCliente ??
                              'Esta vacio'),
                          subtitle: Text(clientController
                                  .clienteObservable[index]!.cedulaCliente ??
                              'Esta vacio'),
                          trailing: Text(clientController
                                  .clienteObservable[index]!.saldoDeuda ??
                              'No tiene deudas pendientes'),
                        ),
                      ),
                    );
                  },
                ),
              
            );
       
      },
    );
  }
}
