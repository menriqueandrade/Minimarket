import 'dart:ffi';

import 'package:deudas_minimarket/app/ui/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/models/cliente.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../ui/pages/client/client_deudas_details.dart';
import '../../services/client_service.dart';
import 'package:intl/intl.dart';

class ClientController extends GetxController {
  var formatter =
      NumberFormat.currency(locale: 'es_CO', symbol: 'COP', decimalDigits: 0);
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
  
    CollectionReference clientes =
        FirebaseFirestore.instance.collection('clientes');

   
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
    
    try {
      final User? currentUser = await _auth.currentUser;
      final String? email = currentUser!.email;
      print(currentUser);
      print(email);

      final DocumentReference documentReference =
          FirebaseFirestore.instance.collection("clientes").doc(idDocumento);
     
      await documentReference.update({
        'saldoDeuda': saldoDeuda,
  
      });
    } catch (e) {
      Get.snackbar("title", e.toString());
    }
  
  }

 

 
  Future<void> obtenerClientes() async {
    CollectionReference clientes =
        FirebaseFirestore.instance.collection('clientes');
    clientes.snapshots().listen((event) {
      clienteObservable.clear();
      event.docs.forEach((element) {
       

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
       
        querySnapshot.docs.first.reference
            .update({'fechaCreacion': DateTime.now()});

    
        FirebaseFirestore.instance
            .collection('fechas')
            .doc('OHuO3FTWJfKdcmELZXae')
            .get()
            .then((DocumentSnapshot documentSnapshot) async {
          if (documentSnapshot.exists) {
            Map<String, dynamic> data =
                documentSnapshot.data() as Map<String, dynamic>;
            Map<String, dynamic> mesMap = data['mes'];

            var mes = DateTime.now().month.toString();
            if (mesMap['5']['nombremes'] == mes) {
             
            
                   sumarValorTotal(saldoDeuda, totalDeuda, querySnapshot);
              double totalVentasMes = await consultarTotalMes();
            
              mesMap['5']['totalmes'] = totalVentasMes;
              documentSnapshot.reference.update({'mes': mesMap});

           
            }

          
          } else {
            print('El documento no existe');
          }
        });

      } else if (querySnapshot.docs.isEmpty) {
        // No se ha encontrado ningún documento con el campo coincidente
        updatedValue = "null";
      }
    });
  }

  Future<double> consultarTotalMes() async {
  double total = 0;
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('clientes')
      .get();

  querySnapshot.docs.forEach((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    if (data.containsKey('totalDeuda')) {
      double totalDeuda = data['totalDeuda'] as double;
      total += totalDeuda;
    }
  });

  print('El total de deuda es: $total');
  return total;
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
              content: Container(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => ListTile(
                        onTap: () {
                          Get.find<ClientController>()
                              .setClient(clienteObservable[index]!);
                          Get.to(ClienteDetailScreen());
                        },
                        title: Container(
                          width: double.infinity,
                          child: Text(
                              "${clienteObservable.value[index]?.nombreCliente}",
                              softWrap: false),
                        ),
                        subtitle: Text(
                            "${clienteObservable.value[index]?.cedulaCliente}"),
                        trailing: Text("Deuda: "
                            "${formatter.format(clienteObservable.value[index]?.totalDeuda)}"),
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
            ),
          );
        }
      }

      
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
              title: Text("Abono de cliente"),
              content: Container(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => ListTile(
                        onTap: () {
                          Get.find<ClientController>()
                              .setClient(clienteObservable[index]!);
                          Get.to(ClienteDetailScreen());
                        },
                        title: Container(
                          width: double.infinity,
                          child: Text(
                              "${clienteObservable.value[index]?.nombreCliente}",
                              softWrap: false),
                        ),
                        subtitle: Text(
                            "${clienteObservable.value[index]?.cedulaCliente}"),
                        trailing: Text("Deuda: "
                            "${formatter.format(clienteObservable.value[index]?.totalDeuda)}"),
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
                                          clienteObservable
                                                  .value[index]?.totalDeuda ??
                                              0,
                                          double.parse(abonoController.text),
                                          clienteObservable.value[index]
                                                  ?.cedulaCliente ??
                                              "",
                                        );
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
            ),
          );
        }
      }

    
    }
  }

  Future<void> abonoValorTotal(double saldoDeuda, double totalDeuda,
      double abonoController, String cedulaCliente) async {
    totalDeuda = totalDeuda - abonoController;
    print(totalDeuda);
    FirebaseFirestore.instance
        .collection('clientes')
        .where('cedulaCliente', isEqualTo: cedulaCliente)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.first.reference.update({'totalDeuda': totalDeuda});
        print("COÑO SE PAGO ABONO");
        // el saldoDeuda agregarlo en el campo de totalDeuda
        Get.back();

        querySnapshot.docs.first.reference
            .update({'fechaAbono': DateTime.now()});
      } else if (querySnapshot.docs.isEmpty) {}
    });
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
        querySnapshot.docs.first.reference.update({'saldoDeuda': 0});
        querySnapshot.docs.first.reference.update({'totalDeuda': 0});
        print("COÑO SE PAGO TODO");
        // el saldoDeuda agregarlo en el campo de totalDeuda

        querySnapshot.docs.first.reference
            .update({'fechaCreacion': DateTime.now()});

       
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
