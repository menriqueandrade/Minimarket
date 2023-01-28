
class InformacionGeneral {
  String nombre;
  String telefono;
  String celular;
  //Pais pais;
//// Ciudad ciudad;
  String direccion;
  String correo;
  String descripcion;
  InformacionGeneral({
    required this.nombre,
    required this.telefono,
    required this.celular,
   // required this.pais,
//required this.departamento,
   // required this.ciudad,
    required this.direccion,
    required this.correo,
    required this.descripcion,
  });
  factory InformacionGeneral.construir({
    nombre,
    telefono,
    celular,
    pais,
    departamento,
    ciudad,
    direccion,
    correo,
    descripcion,
  }){
    return InformacionGeneral(
    nombre: nombre ?? '',
    telefono: telefono ?? '',
    celular: celular ?? '',
  //  pais: pais ?? Pais(id: '', nombre: ''),
   // departamento: departamento ?? Departamento(id: '', nombre: ''),
   // ciudad: ciudad ?? Ciudad(id: '', nombre: ''),
    direccion: direccion ?? '',
    correo: correo ?? '',
    descripcion: descripcion ?? '',
  );
  }
}
