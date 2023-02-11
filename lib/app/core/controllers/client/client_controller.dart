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

//Metodo para agregar un campo a un documento existente
  void metodomagico() {}
  // DocumentReference documentReference = FirebaseFirestore.instance.collection('nombre_de_tu_coleccion').doc('id_del_documento');

  Future<void> agregarSaldoDeuda(String saldoDeuda, String idDocumento) async {
    //aca obtengo el usuario y toda su info
    try {
      final User? currentUser = await _auth.currentUser;
      final String? email = currentUser!.email;
      print(currentUser);
      print(email);

      //obtener el documento
      // DocumentReference documentReference =
      //     FirebaseFirestore.instance.collection('clientes').doc(idDocumento);
      // CollectionReference clientes = FirebaseFirestore.instance
      //     .collection('clientes')
      //     .doc(idDocumento)
      //     .id as CollectionReference<Object?>;

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

  // Future<void> agregaYA(
  //   int? saldoDeuda,
  // ) async {
  //   //aca obtengo el usuario y toda su info
  //   final User? currentUser = await _auth.currentUser;
  //   final String? email = currentUser!.email;
  //   print(currentUser);
  //   print(email);
  //   CollectionReference clientes =
  //       FirebaseFirestore.instance.collection('clientes');

  //   // Call the user's CollectionReference to add a new user
  //   await clientes
  //       .add

  //       ({

  //         'saldoDeuda': saldoDeuda,

  //         // Stokes and Sons
  //       })
  //       .then((value) => Get.snackbar("title", "Cliente Creado con exito"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  //Obtener la coleccion clientes de cloud firestore
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

  Future<void> pagoCliente(
      int totalDeuda, String idCedula, int saldoDeuda) async {
    var updatedValue;
    FirebaseFirestore.instance
        .collection('clientes')
        .where('cedulaCliente', isEqualTo: idCedula)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.first.reference
            .update({'totalDeuda': saldoDeuda - totalDeuda});

        //   querySnapshot.docs.first.reference.update({'fechaCreacion': DateTime.now()});
        // Se ha encontrado un documento con el campo coincidente
        //updatedValue = querySnapshot.docs.first.data()[querySnapshot.docs.first.data().keys.firstWhere((element) => element == 'id')];

      } else if (querySnapshot.docs.isEmpty) {
        // No se ha encontrado ningún documento con el campo coincidente
        updatedValue = "null";
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    obtenerClientes();
  }

  final Cliente _model = Cliente();
  final RxString searchText = "".obs;

  void searchTextChanged(String value) {
    _model.updateSearchText(value);
    _model.performSearch();
  }

  late Cliente clientedetail;

  setClient(Cliente clienteValue) {
    clientedetail = clienteValue;
  }
}
