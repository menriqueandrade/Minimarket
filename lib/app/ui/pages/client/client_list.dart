import 'package:deudas_minimarket/app/core/controllers/client/client_controller.dart';
import 'package:deudas_minimarket/app/data/models/cliente.dart';
import 'package:deudas_minimarket/app/ui/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/error_pantalla.dart';
import 'client_deudas_details.dart';
import 'package:intl/intl.dart';

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
        var valor = clientController.clienteObservable.length;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                Text(
                  "Total de Clientes: $valor",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          body: clientController.clienteObservable.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Rows(),
        );
      },
    );
  }
}

class Rows extends GetView {
  var formatter =
      NumberFormat.currency(locale: 'es_CO', symbol: 'COP', decimalDigits: 0);
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
                  // Text('Ultima deuda del pedido: ${formatter.format(saldoDeuda ?? 0) }',
                  trailing: Text(
                      "Total Deuda: ${formatter.format(clientController.clienteObservable[index]!.totalDeuda)}"),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
