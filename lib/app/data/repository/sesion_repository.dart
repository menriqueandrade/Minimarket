import 'package:get/get.dart';

import '../../../simulacionbackend/backend_usuario.dart';



class SesionRepository {
  
  BackendUsuarios backendUsuarios = Get.find();

  getAll(){
    return backendUsuarios.getAll();
  }
  get(correo,clave){
    try {
      return backendUsuarios.autenticar(correo, clave);
    } catch (e) {
      throw e.toString();
      // throw Exception(e.toString());
    }
  }
  validarToken(token){
    try {
      return backendUsuarios.validarToken(token);
    } catch (e) {
      throw e.toString();
    }
  }
  Future<Map?> claveOlvidada(String correo)async{
    return {'encontrado' : true};
  }

}
