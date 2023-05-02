// ignore_for_file: invalid_use_of_protected_member

import 'package:deudas_minimarket/app/core/controllers/client/client_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PagoClienteScreen extends GetView<ClientController> {
  const PagoClienteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClientController clientController = Get.put(ClientController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "Pago total del cliente",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => clientController.filterClient(value),
              decoration: const InputDecoration(
                labelText: 'Buscar por cedula',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: clientController.clienteObservable.value.length,
                  itemBuilder: (context, index) => ListTile(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
