// ignore_for_file: invalid_use_of_protected_member

import 'package:deudas_minimarket/app/core/controllers/client/client_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AbonoClienteScreen extends GetView<ClientController> {
  const AbonoClienteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClientController clientController = Get.put(ClientController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text("Abonar"),
            TextField(
              onChanged: (value) => clientController.filterClientAbono(value),
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
                  itemBuilder: (context, index) => ListTile(

                      //  title: Text(
                      //    clientController.clienteObservable.value[index]?.nombreCliente ?? '',
                      //    style:
                      //        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      //  ),

                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
