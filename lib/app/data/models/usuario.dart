class Usuario {
  dynamic id;
  dynamic tipoIdentificacion;
  String numeroIdentificacion;
  String nombres;
  String apellidos;
  String correo;
  bool estado;
  bool esDeudor;
  String codigo;
  //dynamic permisos;

  Usuario({
    this.id,
    this.tipoIdentificacion,
    this.numeroIdentificacion = '',
    this.nombres = '',
    this.apellidos = '',
    this.correo = '',
    this.estado = true,
    this.esDeudor = false,
    this.codigo = '',
   // this.permisos,
  });

}
