import 'package:deudas_minimarket/app/ui/pages/home/home.dart';
import 'package:deudas_minimarket/app/ui/pages/home/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../routes/app_pages.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  //method signinGoogle
  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(credential);
      Get.toNamed(Routes.HOME);
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


