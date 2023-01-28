
import 'package:flutter/material.dart';


class Horario {
  dynamic id;
  // int permitirReservarCada;
  // int tempoMinimoReservarDias;
  // int tempoMinimoReservarHoras;
  // int tiempoCancelacion;
  List<HorarioAtencion> horarioAtencion;
 // List<Excepcion> excepciones;
  Horario({
    required this.id,
    // required this.permitirReservarCada,
    // required this.tempoMinimoReservarDias,
    // required this.tempoMinimoReservarHoras,
    // required this.tiempoCancelacion,
    required this.horarioAtencion,
   // required this.excepciones,
  });
  factory Horario.construir({
    id,
    // permitirReservarCada,
    // tempoMinimoReservarDias,
    // tempoMinimoReservarHoras,
    // tiempoCancelacion,
    horarioAtencion,
//    excepciones,
  }){
    return Horario(
      id: id ?? '',
      // permitirReservarCada: permitirReservarCada ?? 15,
      // tempoMinimoReservarDias: tempoMinimoReservarDias ?? 0,
      // tempoMinimoReservarHoras: tempoMinimoReservarHoras ?? 0,
      // tiempoCancelacion: tiempoCancelacion ?? 0,
      horarioAtencion: horarioAtencion ?? [],
      // excepciones: excepciones ?? [],
    );
  }
}

class HorarioAtencion {
  dynamic id;
  //List<bool> diasSemana;
  //int cantidadMaxPersonas;
  TimeOfDay horaInicio;
  TimeOfDay horaFin;
  HorarioAtencion({
    required this.id,
 //   required this.diasSemana,
  //  required this.cantidadMaxPersonas,
    required this.horaInicio,
    required this.horaFin,
  });

  factory HorarioAtencion.construir({
    id,
    diasSemana,
    cantidadMaxPersonas,
    horaInicio,
    horaFin,
  }){ 
    return HorarioAtencion(
      id: id,
   //   diasSemana: diasSemana ?? [true, true,true,true,true,true,true],
    //  cantidadMaxPersonas: cantidadMaxPersonas ?? 0,
      horaInicio: horaInicio ?? const TimeOfDay(hour: 8, minute: 0),
      horaFin: horaFin ?? const TimeOfDay(hour: 18, minute: 0),
    );
  } 

  get strHoraInicio{
    return '${horaInicio.hourOfPeriod}:${horaInicio.minute < 10 ? '0${horaInicio.minute}' : horaInicio.minute } ${horaInicio.period == DayPeriod.am ? 'a.m.' : 'p.m.'}';
  }
  get strHoraFin{
    return '${horaFin.hourOfPeriod}:${horaFin.minute < 10 ? '0${horaFin.minute}' : horaFin.minute } ${horaFin.period == DayPeriod.am ? 'a.m.' : 'p.m.'}';
  }
} 

class Excepcion {
  dynamic id;
  List<bool> diasSemana;
  int excepcionPor;
  TimeOfDay horaInicio;
  TimeOfDay horaFin;
  DateTime fechaInicio;
  DateTime fechaFin;
  Excepcion({
    required this.id,
    required this.diasSemana,
    required this.excepcionPor,
    required this.horaInicio,
    required this.horaFin,
    required this.fechaInicio,
    required this.fechaFin,
  });

  factory Excepcion.construir({
    id,
    diasSemana,
    exepcionPor,
    horaInicio,
    horaFin,
    fechaInicio,
    fechaFin,
  }){
    return Excepcion(
      id: id, 
      diasSemana: diasSemana ?? [true, true,true,true,true,true,true], 
      excepcionPor: exepcionPor ?? 1, 
      horaInicio: horaInicio ?? const TimeOfDay(hour: 8, minute: 0), 
      horaFin: horaFin ?? const TimeOfDay(hour: 18, minute: 0), 
      fechaInicio: fechaInicio ?? DateTime.now(), 
      fechaFin: fechaFin ?? DateTime.now()
    );
  }
  get strHoraInicio{
    return '${horaInicio.hourOfPeriod}:${horaInicio.minute < 10 ? '0${horaInicio.minute}' : horaInicio.minute } ${horaInicio.period == DayPeriod.am ? 'a.m.' : 'p.m.'}';
  }
  get strHoraFin{
    return '${horaFin.hourOfPeriod}:${horaFin.minute < 10 ? '0${horaFin.minute}' : horaFin.minute } ${horaFin.period == DayPeriod.am ? 'a.m.' : 'p.m.'}';
  }

  get strFechaInicio{
    return '${fechaInicio.day}/${fechaInicio.month}/${fechaInicio.year}';
  }
  get strFechaFin{
    return '${fechaFin.day}/${fechaFin.month}/${fechaFin.year}';
  }
}