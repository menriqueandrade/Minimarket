import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deudas_minimarket/app/core/controllers/client/client_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/login_controller.dart';
import '../../../data/models/cliente.dart';
import '../../../routes/app_pages.dart';
import '../../theme/colores.dart';
import '../home/home.dart';
import 'client_list.dart';
import 'package:intl/intl.dart';

class ClienteDetailScreen extends GetView {
  var formatter =
      NumberFormat.currency(locale: 'es_CO', symbol: 'COP', decimalDigits: 0);
  LoginController sesionController = Get.find();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GetX<ClientController>(
        init: ClientController(),
        builder: (clientController) {
          return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colores.rojo,
                  centerTitle: true,
                  title: const Text("Minimarket",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  iconTheme: const IconThemeData(
                      color: Color.fromARGB(255, 255, 255, 255)),
                  actions: menuOpciones(sesionController),
                ),
              ),
              body: clientController.clienteObservable.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: GetBuilder<ClientController>(
                          builder: (clienteDetailController) {
                        Cliente clientedetail =
                            clienteDetailController.clientedetail;

                        return Column(
                          children: [
                            Positioned.fill(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.1,
                                    vertical: 10.0),
                                child: Column(
                                  children: [
                                    Card(
                                      child: ListTile(
                                          onTap: () {},
                                          title: Text(
                                              clientedetail.nombreCliente ??
                                                  'Esta vacio'),
                                          subtitle: Text(
                                              clientedetail.cedulaCliente ??
                                                  'Esta vacio'),
                                          trailing: Text(
                                              'Total de deuda ${formatter.format(clientedetail.totalDeuda ?? 0)}')),
                                    ),
                                    // Text(
                                    //     'Esta es el id de este  ${clientedetail.id} '),
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              _CardHeader(
                                                  clientedetail.saldoDeuda,
                                                  clientedetail.telefonoCliente,
                                                  clientedetail.correoCliente,
                                                  clientedetail
                                                      .direccionCliente,
                                                  formatDate(clientedetail
                                                      .fechaCreacion!),
                                                      formatDate(clientedetail.fechaAbono!),
                                                      ),
                                              _CardBody(
                                                  clientedetail.cedulaCliente),
                                            ],
                                          )),
                                    ),

                                    //card height
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ));
        });
  }
}

class _CardHeader extends GetView {
  var formatter =
      NumberFormat.currency(locale: 'es_CO', symbol: 'COP', decimalDigits: 0);
  final double? saldoDeuda;
  final String? telefono;
  final String? correo;
  final String? direccion;
  final String? fechaUltimoPago;
  final String? fechaAbono;

  _CardHeader(
    this.saldoDeuda,
    this.telefono,
    this.correo,
    this.direccion,
    this.fechaUltimoPago,
    this.fechaAbono,
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Correo: ${correo?.toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 15,
            ),
            Text('Telefono: ${telefono?.toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 15,
            ),
            Text('Direccion: ${direccion?.toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(
              height: 15,
            ),
            Text('Fecha ultimo pedido: ${fechaUltimoPago?.toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 15,
            ),
            Text('Fecha ultimo abono: ${fechaAbono?.toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 15,
            ),
            Text(
                'Ultima deuda del pedido: ${formatter.format(saldoDeuda ?? 0)}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 20,
            ),
          ],
        )
      ],
    );
  }
}

String formatDate(Timestamp timestamp) {
  DateTime date = timestamp.toDate();
  return "${date.day}/${date.month}/${date.year}/${date.hour}:${date.minute}";
}

class _CardBody extends GetView {
  final String? idCedula;
  _CardBody(
    this.idCedula,
  );
  @override
  Widget build(BuildContext context) {
    ClientController clientController = ClientController();

    TextEditingController saldoDeudaController = TextEditingController();
    TextEditingController totalDeudaController = TextEditingController();
    TextEditingController contenedortotalDeudaController =
        TextEditingController();

    // final Cliente cliente = Cliente(
    //   saldoDeuda: int.tryParse(deudaController.text),
    // );

    // clientController.actualizarClientes(
    //   cliente.saldoDeuda ?? 0, cliente.fechaPago ?? Timestamp(0, 0),"PRUEBA"
    // );
    //  print(clientController);
    return Column(children: [
      GetBuilder<ClientController>(builder: (clienteDetailController) {
        Cliente clientedetail = clienteDetailController.clientedetail;

        return Column(
          children: [
            TextFormField(
              controller: saldoDeudaController,
              decoration: InputDecoration(
                labelText: 'Ingrese el valor del pedido',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //si el id es igual
                // if (saldoDeudaController.text.isEmpty) {
                //   Get.snackbar("Error", "Ingrese un valor valido a pagar");
                // } else if (saldoDeudaController.text.isNotEmpty) {
                final saldoDeuda = double.tryParse(saldoDeudaController.text);

                final Cliente cliente = Cliente(
                  saldoDeuda: saldoDeuda,
                  totalDeuda: clientedetail.totalDeuda,
                );
                clientController.agregarSaldo(
                    cliente.saldoDeuda!, idCedula!, cliente.totalDeuda!,);

                Get.back();
                //   }
              },
              child: const Text("Agregar valor pedido"),
            ),
          ],
        );
      }),
    ]);
  }
}
