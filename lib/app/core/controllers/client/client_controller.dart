import 'package:deudas_minimarket/app/ui/widgets/input.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/models/cliente.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/client_service.dart';

class ClientController extends GetxController {
   Rx<List<Cliente>> clientes = Rx<List<Cliente>>([]);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final clienteObservable = <Cliente?>[].obs;
  
//Agregar cliente a cloud firestore
  Future<void> agregarClientes(
      String nombreCliente,
      String cedulaCliente,
      String telefonoCliente,
      String direccionCliente,
      String cargoCliente,
      String correoCliente) async {
    //aca obtengo el usuario y toda su info
    final User? currentUser = await _auth.currentUser;
    final String? email = currentUser!.email;
    print(currentUser);
    print(email);
    CollectionReference clientes =
        FirebaseFirestore.instance.collection('clientes');
    // Call the user's CollectionReference to add a new user
    await clientes
        .add({
          'nombreCliente': nombreCliente,
          'cedulaCliente': cedulaCliente,
          'telefonoCliente': telefonoCliente,
          'direccionCliente': direccionCliente, // John Doe
          'cargoCliente': cargoCliente,
          'correoCliente': correoCliente,
          //Valores cambiantes
          'saldoDeuda': null,
          'fechaPago': null,
          // Stokes and Sons
        })
        .then((value) => Get.snackbar("title", "Cliente Creado con exito"))
        .catchError((error) => print("Failed to add user: $error"));
  }


  //Obtener la coleccion clientes de cloud firestore
   Future<void> obtenerClientes() async {
    CollectionReference clientes =
        FirebaseFirestore.instance.collection('clientes');
    clientes.snapshots().listen((event) {
      clienteObservable.clear();
      event.docs.forEach((element) {
        clienteObservable.add(Cliente.fromJson(element.data() as Map<String, dynamic>) );
      });
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    obtenerClientes();
  }
  
  



  
}
