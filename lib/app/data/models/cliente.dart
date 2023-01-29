class Cliente {
  
  String? nombreCliente;
  String? cedulaCliente;
  String? telefonoCliente;
  String? direccionCliente;
  String? cargoCliente;
  String? correoCliente;
  String? fechaPago;
  String? saldoDeuda;
  Cliente({
   
    this.nombreCliente,
    this.cedulaCliente,
    this.telefonoCliente,
    this.direccionCliente,
    this.cargoCliente,
    this.correoCliente,
    this.fechaPago,
    this.saldoDeuda,
    
  });
  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
       
        nombreCliente: json['nombreCliente'],
        cedulaCliente: json['cedulaCliente'],
        telefonoCliente: json['telefonoCliente'],
        direccionCliente: json['direccionCliente'],
        cargoCliente: json['cargoCliente'],
        correoCliente: json['correoCliente'],
        fechaPago: json['fechaPago'],
        saldoDeuda: json['saldoDeuda'],
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
      };
}
