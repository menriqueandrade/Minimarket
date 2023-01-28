

import 'package:deudas_minimarket/app/data/models/promedio_deuda_mes.dart';
import 'package:deudas_minimarket/app/data/models/usuario.dart';

import 'clientemoroso/clientedeudor.dart';

class ClientesDeudas {
  dynamic id;
  String? tipoPersona;
  String? numeroIdentificacion;
  //String? nombreNegocio;
  String? nombreContacto;
  String? direccion;
  String? numeroContacto;
  String? correo;
  
  //Pais? pais;
//  Departamento? departamento;
 // Ciudad? ciudad;

  
  
  PromedioDeudaMes? promedioVentaMes;
  //List<Red>? redesSociales;

  String? mensaje;

  dynamic estado;
  //bool? cuentaVerificada;

  Usuario? usuario;

  //List<List<TipoServicio>>? tipoNegocio;

  List<Clientedeudor> clientedeudor;

  ClientesDeudas({
    required this.id,
    required this.tipoPersona,
    required this.numeroIdentificacion,
   // required this.nombreNegocio,
    required this.nombreContacto,
   // required this.pais,
   // required this.departamento,
   // required this.ciudad,
    required this.direccion,
    required this.numeroContacto,
    required this.correo,
    required this.promedioVentaMes,
    //required this.redesSociales,
    required this.mensaje,
    required this.estado,
    //required this.cuentaVerificada,
    required this.usuario,
   // required this.tipoNegocio,
    required this.clientedeudor,
  });
  // ClientesDeudas({
  //   this.id,
  //   this.tipoPersona,
  //   this.numeroIdentificacion,
  //   this.nombreNegocio,
  //   this.nombreContacto,
  //   this.pais,
  //   this.departamento,
  //   this.ciudad,
  //   this.direccion,
  //   this.numeroContacto,
  //   this.correo,
  //   this.promedioVentaMes,
  //   this.redesSociales,
  //   this.mensaje,
  //   this.estado,
  //   this.cuentaVerificada,
  //   this.usuario,
  //   this.tipoNegocio,
  //   this.sedes,
  // });

  factory ClientesDeudas.construir({
    id,
    tipoPersona,
    numeroIdentificacion,
  //  nombreNegocio,
    nombreContacto,
  //  pais,
  //  departamento,
 //   ciudad,
    direccion,
    numeroContacto,
    correo,
    promedioVentaMes,
 //   redesSociales,
    mensaje,
    estado,
 //   cuentaVerificada,
    usuario,
  //  tipoNegocio,
    clientedeudor,
  }){
    return ClientesDeudas(
      id: id,
      tipoPersona: tipoPersona,
      numeroIdentificacion: numeroIdentificacion,
    //  nombreNegocio: nombreNegocio,
      nombreContacto: nombreContacto,
      //pais: pais,
     // departamento: departamento,
     // ciudad: ciudad,
      direccion: direccion,
      numeroContacto: numeroContacto,
      correo: correo,
      promedioVentaMes: promedioVentaMes,
    //  redesSociales: redesSociales,
      mensaje: mensaje,
      estado: estado,
    //  cuentaVerificada: cuentaVerificada,
      usuario: usuario,
   //   tipoNegocio: tipoNegocio,
      clientedeudor: clientedeudor ?? [],
    );
  
  }

  @override
  String toString() {
    return 'Negocio(id: $id, tipoPersona: $tipoPersona, numeroIdentificacion: $numeroIdentificacion,  nombreContacto: $nombreContacto,  direccion: $direccion, numeroContacto: $numeroContacto, correo: $correo, promedioVentaMes: $promedioVentaMes,  mensaje: $mensaje, estado: $estado,  usuario: $usuario, )';
  }
}
