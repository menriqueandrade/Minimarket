import 'package:deudas_minimarket/app/ui/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/models/cliente.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../ui/pages/client/client_deudas_details.dart';
import '../../services/client_service.dart';

class ClientController extends GetxController {
  TextEditingController abonoController = TextEditingController();
  // final List<Map<String, dynamic>> AllClients = <Cliente?>[].obs as List<Map<String, dynamic>>;
  final List<Map<String, dynamic>> allPlayers = [
    {"name": "Rohit Sharma", "country": "India"},
    {"name": "Virat Kohli ", "country": "India"},
    {"name": "Glenn Maxwell", "country": "Australia"},
    {"name": "Aaron Finch", "country": "Australia"},
    {"name": "Martin Guptill", "country": "New Zealand"},
    {"name": "Trent Boult", "country": "New Zealand"},
    {"name": "David Miller", "country": "South Africa"},
    {"name": "Kagiso Rabada", "country": "South Africa"},
    {"name": "Chris Gayle", "country": "West Indies"},
    {"name": "Jason Holder", "country": "West Indies"},
  ];
  Rx<List<Map<String, dynamic>>> foundPlayers =
      Rx<List<Map<String, dynamic>>>([]);

  Rx<List<Cliente>> clientes = Rx<List<Cliente>>([]);
  Rx<List<Map<String, dynamic>>> buscarCliente =
      Rx<List<Map<String, dynamic>>>([]);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final clienteObservable = <Cliente?>[].obs;
  final target = <Cliente?>[].obs;

  String? _saldoDeuda = "";

  String? get counter => _saldoDeuda;

//Agregar cliente a cloud firestore
  Future<void> agregarClientes(
      String? nombreCliente,
      String? cedulaCliente,
      String? telefonoCliente,
      String? direccionCliente,
      String? cargoCliente,
      String? correoCliente,
      {String? id}) async {
    //aca obtengo el usuario y toda su info
    final User? currentUser = await _auth.currentUser;
    final String? email = currentUser!.email;
    final String? uid = currentUser.uid;
    print(currentUser);
    print(email);
    //  final DocumentReference idDocumento = FirebaseFirestore.instance.collection("clientes").doc(cedulaCliente);
    CollectionReference clientes =
        FirebaseFirestore.instance.collection('clientes');

    // Call the user's CollectionReference to add a new user
    await clientes
        .add({
          'id': id,
          'nombreCliente': nombreCliente,
          'cedulaCliente': cedulaCliente,
          'telefonoCliente': telefonoCliente,
          'direccionCliente': direccionCliente, // John Doe
          'cargoCliente': cargoCliente,
          'correoCliente': correoCliente,
          //Valores cambiantes
          'saldoDeuda': 0,
          'totalDeuda': 0,
          "fechaCreacion": DateTime.now(),
          // Stokes and Sons
        })
        .then((value) => Get.snackbar("title", "Cliente Creado con exito"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> agregarSaldoDeuda(String saldoDeuda, String idDocumento) async {
    //aca obtengo el usuario y toda su info
    try {
      final User? currentUser = await _auth.currentUser;
      final String? email = currentUser!.email;
      print(currentUser);
      print(email);

      final DocumentReference documentReference =
          FirebaseFirestore.instance.collection("clientes").doc(idDocumento);
      // Call the user's CollectionReference to add a new user
      await documentReference.update({
        'saldoDeuda': saldoDeuda,
        // Stokes and Sons
      });
    } catch (e) {
      Get.snackbar("title", e.toString());
    }
    // .then((value) => Get.snackbar("title", "Deuda agregada con exito"))
    // .catchError((error) => print("Failed to add user: $error"));
  }

  //consultar cedula cliente
  // Future<void> consultarCedulaCliente(String cedulaCliente) async {
  //   CollectionReference clientes =
  //       FirebaseFirestore.instance.collection('clientes');
  //   clientes
  //       .where('cedulaCliente', isEqualTo: cedulaCliente)
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       print(doc.data());
  //       print(doc.id);
  //       print(doc.exists);
  //     });
  //   });
  // }

  //Obtener la coleccion clientes de cloud firestore
  Future<void> obtenerClientes() async {
    CollectionReference clientes =
        FirebaseFirestore.instance.collection('clientes');
    clientes.snapshots().listen((event) {
      clienteObservable.clear();
      event.docs.forEach((element) {
        //consultar cedulas
        //  print(element.data()['cedulaCliente']);

        clienteObservable
            .add(Cliente.fromJson(element.data() as Map<String, dynamic>));
      });
    });
  }

  Future<void> sumarValorTotal(
      double saldoDeuda, double totalDeuda, QuerySnapshot querySnapshot) async {
    totalDeuda = saldoDeuda + totalDeuda;
    print(totalDeuda);
    querySnapshot.docs.first.reference.update({'totalDeuda': totalDeuda});
    //  saldoDeuda = 0;
    //   querySnapshot.docs.first.reference.update({'saldoDeuda': saldoDeuda});
  }

  Future<void> agregarSaldo(
      double saldoDeuda, String idCedula, double totalDeuda) async {
    var updatedValue;
    FirebaseFirestore.instance
        .collection('clientes')
        .where('cedulaCliente', isEqualTo: idCedula)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.first.reference.update({'saldoDeuda': saldoDeuda});
        // el saldoDeuda agregarlo en el campo de totalDeuda

        querySnapshot.docs.first.reference
            .update({'fechaCreacion': DateTime.now()});

        sumarValorTotal(saldoDeuda, totalDeuda, querySnapshot);
        // Se ha encontrado un documento con el campo coincidente
        //updatedValue = querySnapshot.docs.first.data()[querySnapshot.docs.first.data().keys.firstWhere((element) => element == 'id')];
      } else if (querySnapshot.docs.isEmpty) {
        // No se ha encontrado ningún documento con el campo coincidente
        updatedValue = "null";
      }
    });
  }

  //Metodo para filtrar cedula y mostrarlo en la vista

  // Future<void> filtroCedula(String value) async {
  //   if (value.isEmpty) {
  //   } else {
  //     FirebaseFirestore.instance
  //         .collection('clientes')
  //         .where('cedulaCliente', isEqualTo: value)
  //         .get()
  //         .then((querySnapshot) {

  //     });
  //   }
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //  clienteObservable;
    obtenerClientes();

    foundPlayers.value = allPlayers;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void filterPlayer(String playerName) {
    List<Map<String, dynamic>> results = [];
    if (playerName.isEmpty) {
      results = allPlayers;
    } else {
      results = allPlayers
          .where((element) => element["name"]
              .toString()
              .toLowerCase()
              .contains(playerName.toLowerCase()))
          .toList();
    }
    foundPlayers.value = results;
  }

  Future<void> filterClient(String cedula) async {
    if (cedula.isEmpty) {
      print("No pasa nada");
    } else {
      //recorrer clienteObservable

      for (int index = 0; index < clienteObservable.length; index++) {
        if (clienteObservable.value[index]?.cedulaCliente == cedula) {
          // encontrado = true; // actualizar la variable encontrado
          print("La cedula si se puede consultar");
          // Mostrar una alerta con el nombre del cliente encontrado
          // (esto es solo un ejemplo, puedes personalizarlo según tus necesidades)
          showDialog(
            context: Get.context!,
            builder: (_) => AlertDialog(
              title: Text("Cliente encontrado"),
              content: Column(
                children: [
                  Obx(
                    () => ListTile(
                      onTap: () {
                        Get.find<ClientController>()
                            .setClient(clienteObservable[index]!);
                        Get.to(ClienteDetailScreen());
                      },
                      title: Text(
                          "${clienteObservable.value[index]?.nombreCliente}"),
                      subtitle: Text(
                          "${clienteObservable.value[index]?.cedulaCliente}"),
                      trailing: Text("Total deuda "
                          "${clienteObservable.value[index]?.totalDeuda}"),
                    ),
                  ),
                  ElevatedButton(
                      //si doy tap mostrar warning

                      onPressed: () {
                        if (clienteObservable.value[index]?.saldoDeuda == 0 ||
                            clienteObservable.value[index]?.totalDeuda == 0) {
                          Get.snackbar(
                              "Error", "El cliente no tiene saldo deuda");
                        } else {
                          showDialog(
                            context: Get.context!,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('¿Está seguro?'),
                                content: Text(
                                    '¿Está seguro de realizar esta acción?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Realizar acción deseada aquí
                                      pagarTodo(
                                          clienteObservable
                                                  .value[index]?.saldoDeuda ??
                                              0,
                                          clienteObservable.value[index]
                                                  ?.cedulaCliente ??
                                              "",
                                          clienteObservable
                                                  .value[index]?.totalDeuda ??
                                              0);
                                      Get.back();
                                    },
                                    child: Text('Aceptar'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text("Pagar Todo"))
                ],
              ),
            ),
          );
        }
      }

      //mostrar resultado

      //si la clienteobservable cedula es igual a cedula
      //    FirebaseFirestore.instance
      //     .collection('clientes')
      //     .where('cedulaCliente', isEqualTo: cedula)
      //     .get()
      //     .then((querySnapshot) {
      //   if (querySnapshot.docs.isNotEmpty) {
      //  print("si existe");
      //   } else if (querySnapshot.docs.isEmpty) {
      //     // No se ha encontrado ningún documento con el campo coincidente
      //     print("no existe");
      //   }
      //   });
    }
  }
   Future<void> filterClientAbono(String cedula) async {
    if (cedula.isEmpty) {
      print("No pasa nada");
    } else {
      //recorrer clienteObservable

      for (int index = 0; index < clienteObservable.length; index++) {
        if (clienteObservable.value[index]?.cedulaCliente == cedula) {
          // encontrado = true; // actualizar la variable encontrado
          print("La cedula si se puede consultar");
          // Mostrar una alerta con el nombre del cliente encontrado
          // (esto es solo un ejemplo, puedes personalizarlo según tus necesidades)
          showDialog(
            context: Get.context!,
            builder: (_) => AlertDialog(
              title: Text("Cliente encontrado"),
              content: Column(
                children: [
                  Obx(
                    () => ListTile(
                      onTap: () {
                        Get.find<ClientController>()
                            .setClient(clienteObservable[index]!);
                        Get.to(ClienteDetailScreen());
                      },
                      title: Text(
                          "${clienteObservable.value[index]?.nombreCliente}"),
                      subtitle: Text(
                          "${clienteObservable.value[index]?.cedulaCliente}"),
                      trailing: Text("Total deuda "
                          "${clienteObservable.value[index]?.totalDeuda}"),
                    ),
                  ),
               TextFormField(
                    controller: abonoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Abono",
                      hintText: "Abono",
                      border: OutlineInputBorder(),
                    ),
                  ),
            
                  ElevatedButton(
                      //si doy tap mostrar warning

                      onPressed: () {
                        if (clienteObservable.value[index]?.saldoDeuda == 0 ||
                            clienteObservable.value[index]?.totalDeuda == 0) {
                          Get.snackbar(
                              "Error", "El cliente no tiene saldo deuda");
                        } else {
                          


                          showDialog(
                            context: Get.context!,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('¿Está seguro?'),
                                content: Text(
                                    '¿Está seguro de realizar esta acción?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Realizar acción deseada aquí
                                      abonoValorTotal(
                                          clienteObservable
                                                  .value[index]?.saldoDeuda ??
                                              0,
                                          (clienteObservable.value[index]
                                                  ?.cedulaCliente ??
                                              "") as double,
                                          (clienteObservable
                                                  .value[index]?.totalDeuda ??
                                              0) as QuerySnapshot<Object?>);
                                      Get.back();
                                    },
                                    child: Text('Aceptar'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text("Abonar"))
                ],
              ),
            ),
          );
        }
        
      }
      

      //mostrar resultado

      //si la clienteobservable cedula es igual a cedula
      //    FirebaseFirestore.instance
      //     .collection('clientes')
      //     .where('cedulaCliente', isEqualTo: cedula)
      //     .get()
      //     .then((querySnapshot) {
      //   if (querySnapshot.docs.isNotEmpty) {
      //  print("si existe");
      //   } else if (querySnapshot.docs.isEmpty) {
      //     // No se ha encontrado ningún documento con el campo coincidente
      //     print("no existe");
      //   }
      //   });
    }
  }
  Future<void> abonoValorTotal(
      double saldoDeuda, double totalDeuda, QuerySnapshot querySnapshot) async {
    totalDeuda = saldoDeuda - totalDeuda;
    print(totalDeuda);
    querySnapshot.docs.first.reference.update({'totalDeuda': totalDeuda});
    //  saldoDeuda = 0;
    //   querySnapshot.docs.first.reference.update({'saldoDeuda': saldoDeuda});
  }


  Future<void> pagarTodo(
      double saldoDeuda, String idCedula, double totalDeuda) async {
    var updatedValue;
    FirebaseFirestore.instance
        .collection('clientes')
        .where('cedulaCliente', isEqualTo: idCedula)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.first.reference.update({'saldoDeuda': saldoDeuda});
        querySnapshot.docs.first.reference.update({'totalDeuda': totalDeuda});
        print("COÑO SE PAGO TODO");
        // el saldoDeuda agregarlo en el campo de totalDeuda

        querySnapshot.docs.first.reference
            .update({'fechaCreacion': DateTime.now()});


        // Se ha encontrado un documento con el campo coincidente
        //updatedValue = querySnapshot.docs.first.data()[querySnapshot.docs.first.data().keys.firstWhere((element) => element == 'id')];
      } else if (querySnapshot.docs.isEmpty) {
        // No se ha encontrado ningún documento con el campo coincidente
        updatedValue = "null";
      }
    });
  }
  
  //Metodo para filtrar por cedula

  //filtrar por cedula
  //metodo para filtrar por cedula rx

  late Cliente clientedetail;
  setClient(Cliente clienteValue) {
    clientedetail = clienteValue;
  }
}
