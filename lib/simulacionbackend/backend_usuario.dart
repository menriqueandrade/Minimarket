import 'package:get/get.dart';

class BackendUsuarios extends GetxController {
  List usuarios = [
    {
      'correo':'manuel@gmail.com',
      'clave':'123456',
      'token': '1'
    }
  ];

  getAll(){
    return usuarios;
  }
  autenticar(correo, clave){
    for (var item in usuarios) {
      if(item['correo']==correo && item['clave']==clave) {
        return item['token'];
      }
    }
    throw 'usuario y/o clave no validas';
  }
  validarToken(token){
    for (var item in usuarios) {
      if(item['token']==token) {
        return item['token'];
      }
    }
    throw 'token no valido';
  }
  add(correo,clave,token){
    usuarios.add({
      'correo':correo,
      'clave':clave,
      'token': token
    });
  }
}