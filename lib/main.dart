import 'package:deudas_minimarket/app/ui/pages/client/client_abono.dart';
import 'package:deudas_minimarket/simulacionbackend/backend_clientesdeudas.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/core/controllers/home_controller.dart';
import 'app/core/controllers/login_controller.dart';
import 'app/core/services/client_service.dart';
import 'app/mainConfigStateManegementApp.dart';
import 'app/ui/pages/client/client_pago.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //binding de firebase
  WidgetsFlutterBinding.ensureInitialized();
  //inicializando get storage para guardar el token del usuario
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
//await GetStorage.init();
  //inicializo negociobackend para simular el backend y poder procesar los datos como si estuviera realizando consultas
 // Get.put(BackendClientesDeudas());
  //Verificar por que el Binding de login control me toca ponerlo aca
   Get.put(HomeController());
  Get.put(ClientService());
  Get.put(LoginController());
  Get.put(PagoClienteScreen());
  Get.put(AbonoClienteScreen());
  
  
  //esto quita el # que aparece en la barra de busqueda

  runApp( const MainConfigStateManagementApp());
}
