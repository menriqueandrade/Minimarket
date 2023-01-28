import 'package:get/get.dart';

import '../app/data/models/clientemoroso/clientedeudor.dart';
import '../app/data/models/clientemoroso/imagenes_clientedeudor.dart';
import '../app/data/models/clientemoroso/informacion_general.dart';
import '../app/data/models/clientesdeudas.dart';

import 'backend_usuario.dart';

class BackendClientesDeudas extends GetxController {

  BackendUsuarios backendUsuarios = Get.put(BackendUsuarios());


  final negocios = <ClientesDeudas>[
    ClientesDeudas.construir(
      id: '1',
      numeroIdentificacion: '123456789',
      correo:'negocio@correo.com',
      estado: true,
     // cuentaVerificada: false,
      clientedeudor: <Clientedeudor> [
        Clientedeudor.construir(id: '0', informacionGeneral: InformacionGeneral.construir(nombre: 'sede 1',), imagenesClienteDeudor: ImagenesClienteDeudor.construir(fotoLogo: Imagen(imagen:'https://picsum.photos/200/300.jpg',tipo: Imagen.URL), fotoPrincipal: Imagen(imagen:'https://picsum.photos/536/354', tipo: Imagen.URL), 
        fotosAdicionales: [
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
          Imagen(imagen:'https://img.freepik.com/foto-gratis/retrato-joven-rubio-mujer_273609-12060.jpg?w=2000', tipo: Imagen.URL),
        ]))
      ]
    ),
  ];

  getAll(){
    return negocios;
  }
  getId(id){
    for (ClientesDeudas item in negocios) {
      if(item.id == id){
        return item;
      }
    }
    return null;
  }
  getCorreo(correo){
    for (ClientesDeudas item in negocios) {
      if(item.correo == correo){
        return item;
      }
    }
    return null;
  }
  delete(id){
    for (ClientesDeudas item in negocios) {
      if(item.id == id){
        negocios.remove(item);
        return true;
      }
    }
    return false;
  }
  edit(ClientesDeudas obj){
    for (var i = 0; i < negocios.length; i++) {
      if(negocios[i].id == obj.id){
        negocios[i] = obj;
        return negocios[i];
      }
    }
    return null;
  }
  add(ClientesDeudas obj){
    obj.id = '${int.parse(negocios[negocios.length - 1].id) + 1}';
    if(getCorreo(obj.correo)==null){
      negocios.add(obj);
      backendUsuarios.add(obj.correo,obj.numeroIdentificacion,obj.id);
      return true;
    }else{
      return false;
    }
  }
}