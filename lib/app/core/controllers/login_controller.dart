import 'package:deudas_minimarket/app/ui/pages/home/home.dart';
import 'package:deudas_minimarket/app/ui/pages/home/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../routes/app_pages.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    // Tu código para mantener la sesión abierta
    keepSessionOpen();
  }

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

  Future<void> keepSessionOpen() async {
    // Tu lógica para mantener la sesión abierta
    // Por ejemplo, si estás usando Firebase Auth, podrías hacer algo así:
    User? user = await FirebaseAuth.instance.currentUser!;
    if (user != null) {
      // Si el usuario ya ha iniciado sesión, refresca el token
      await user.getIdToken();
      // Redirige a la pantalla de inicio
      Get.to(HomeScreen());
    } else {
      // Si el usuario no ha iniciado sesión, redirige al login
      Get.to(LoginScreen());
    }
  }

  //Mantener sesion abierta con estado

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


