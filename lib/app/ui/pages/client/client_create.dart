import 'package:deudas_minimarket/app/core/controllers/client/client_controller.dart';
import 'package:deudas_minimarket/app/ui/theme/colores.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/cliente.dart';

class CrearClienteScreen extends GetView {
  ClientController clientController = ClientController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController cedulaController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController cargoController = TextEditingController();
  TextEditingController correoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.put(ClientController());
    final ClientController _clientController = Get.find<ClientController>();
    return GetBuilder<ClientController>(
      init: ClientController(),
      builder: ((controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                'Crear Cliente',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextField(
                                controller: nombreController,
                                decoration: const InputDecoration(
                                  labelText: "Nombre",
                                ),
                              ),
                              TextField(
                                controller: cedulaController,
                                decoration:
                                    const InputDecoration(labelText: "Cedula"),
                              ),
                              TextField(
                                controller: telefonoController,
                                decoration: const InputDecoration(
                                    labelText: "Telefono"),
                              ),
                              TextField(
                                controller: direccionController,
                                decoration: const InputDecoration(
                                    labelText: "Direccion"),
                              ),
                              TextField(
                                controller: cargoController,
                                decoration:
                                    const InputDecoration(labelText: "Cargo"),
                              ),
                              TextField(
                                controller: correoController,
                                decoration: const InputDecoration(
                                    labelText: "Correo Electronico"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colores.rojo),
                                ),
                                onPressed: () {
                                  //agregar un cliente

                                  final Cliente cliente = Cliente(
                                      nombreCliente: nombreController.text,
                                      cedulaCliente: cedulaController.text,
                                      telefonoCliente: telefonoController.text,
                                      direccionCliente:
                                          direccionController.text,
                                      cargoCliente: cargoController.text,
                                      correoCliente: correoController.text);

                                  clientController.agregarClientes(
                                    cliente.nombreCliente!,
                                    cliente.cedulaCliente!,
                                    cliente.telefonoCliente!,
                                    cliente.direccionCliente!,
                                    cliente.cargoCliente!,
                                    cliente.correoCliente!,
                                  );
                                },
                                child: const Text('Crear Cliente'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
