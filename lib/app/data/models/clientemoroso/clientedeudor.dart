
import 'package:deudas_minimarket/app/data/models/clientemoroso/pago_cobro.dart';
import 'package:deudas_minimarket/app/data/models/clientemoroso/ticket.dart';

import 'horario.dart';

import 'imagenes_clientedeudor.dart';
import 'informacion_general.dart';


class Clientedeudor {
  dynamic id;

  InformacionGeneral informacionGeneral;
  PagoCobro pagoCobro;
  ImagenesClienteDeudor imagenesClienteDeudor;
  
  
  Horario horario;
 // List<ComboPlan> combosPlanes;
//  List<Evento> eventos;
 // List<Renta> rentas;
  List<Ticket> tickets;
 // List<TerminoCondicion> terminosCondiciones;



  dynamic fechaRegistro;
  dynamic estado;

  Clientedeudor({
    required this.id,
    required this.informacionGeneral,
    required this.pagoCobro,
    required this.imagenesClienteDeudor,
    required this.horario,
 //   required this.combosPlanes,
  //  required this.eventos,
 //   required this.rentas,
    required this.tickets,
 //   required this.terminosCondiciones,
    required this.fechaRegistro,
    required this.estado,
  });
  
  factory Clientedeudor.construir({
    id,
    informacionGeneral,
    pagoCobro,
     imagenesClienteDeudor,
    horario,
    // combosPlanes,
    // eventos,
    // rentas,
    tickets,
    // terminosCondiciones,
    fechaRegistro,
    estado,
  }){
    return Clientedeudor(
      id: id ,
      informacionGeneral: informacionGeneral ?? InformacionGeneral.construir(),
      pagoCobro: pagoCobro ?? PagoCobro(),
      imagenesClienteDeudor: imagenesClienteDeudor ?? imagenesClienteDeudor.construir(),
      horario: horario ?? Horario.construir(),
  //    combosPlanes: combosPlanes ?? [],
  //    eventos: eventos ?? [],
 //     rentas: rentas ?? [],
      tickets: tickets ?? [],
  //    terminosCondiciones: terminosCondiciones ?? [] ,
      fechaRegistro: fechaRegistro ,
      estado: estado ,
    );
  }

}

