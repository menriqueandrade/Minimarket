import 'package:cloud_firestore/cloud_firestore.dart';

class Cliente {
  String? id;
  String? nombreCliente;
  String? cedulaCliente;
  String? telefonoCliente;
  String? direccionCliente;
  String? cargoCliente;
  String? correoCliente;
//  String? fechaPago;
  double? saldoDeuda;
  double? totalDeuda;
  Timestamp? fechaCreacion;
  Timestamp? fechaPago;
  Cliente({
    this.id,
    this.nombreCliente,
    this.cedulaCliente,
    this.telefonoCliente,
    this.direccionCliente,
    this.cargoCliente,
    this.correoCliente,
    this.fechaPago,
    this.saldoDeuda,
    this.totalDeuda,
    this.fechaCreacion,
  });
  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        nombreCliente: json['nombreCliente'],
        cedulaCliente: json['cedulaCliente'],
        telefonoCliente: json['telefonoCliente'],
        direccionCliente: json['direccionCliente'],
        cargoCliente: json['cargoCliente'],
        correoCliente: json['correoCliente'],
        fechaPago: json['fechaPago'],
        saldoDeuda: json['saldoDeuda'] is double
            ? json['saldoDeuda']
            : (json['saldoDeuda'] as num).toDouble(),
        totalDeuda: json['totalDeuda'] is double
            ? json['totalDeuda']
            : (json['totalDeuda'] as num).toDouble(),
        fechaCreacion: json['fechaCreacion'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        "nombreCliente": nombreCliente,
        "cedulaCliente": cedulaCliente,
        "telefonoCliente": telefonoCliente,
        "direccionCliente": direccionCliente,
        "cargoCliente": cargoCliente,
        "correoCliente": correoCliente,
        "fechaPago": fechaPago,
        "saldoDeuda": saldoDeuda,
        "totalDeuda": totalDeuda,
        "fechaCreacion": fechaCreacion,
        "id": id,
      };
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('clientes');
  List<DocumentSnapshot> _searchResults = [];
  String _searchText = "";
  void updateSearchText(String value) {
    _searchText = value;
  }

  Future<void> performSearch() async {
    _searchResults = await _collection
        .where("nombre", isEqualTo: _searchText)
        .get()
        .then((snapshot) => snapshot.docs);
  }
}
