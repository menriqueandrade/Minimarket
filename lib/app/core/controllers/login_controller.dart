import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../routes/app_pages.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final User? user = result.user;
      print(user);
      if (user!.emailVerified) {
        Get.toNamed(Routes.HOME);
      } else {
        Get.snackbar('Error',
            'Se ha enviado un correo electronico para verificar tu cuenta');
      }
    } catch (e) {
      print(e);

      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> cerrarSesion() async {
    try {
      await _auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print(e.toString());
    }
  }
}

//Metodo para iniciar sesion por correo firebase
  // Future<void> loginEmailPassword(String email, String password) async {
  //   try {
  //     //await Get.find<BackendClientesDeudas>().loginEmailPassword(email, password);
  //     Get.offAllNamed('/home');
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   }
  // }


