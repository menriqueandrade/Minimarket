import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repository/sesion_repository.dart';
import '../../data/repository/token_repository.dart';
import '../../routes/app_pages.dart';
import '../../ui/widgets/snackbar.dart';
import '../../variables.dart';

class SesionController extends GetxController {
  SesionRepository sesionRepository = SesionRepository();
  final token = ''.obs;

  @override
  void onInit() async {
    await validarToken();
    super.onInit();
  }

  Future<String?> iniciarSesion(String correo, String clave) async {
    try {
      String token = await sesionRepository.get(correo, clave);
      await TokenRepository().setToken(token);
      this.token.value = token;
      Get.offAllNamed(Routes.HOME);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<Map?> claveOlvidada(String correo) async {
    return await sesionRepository.claveOlvidada(correo);
  }

  Future<void> validarToken() async {
    String? token = await TokenRepository().getToken();
    if (token != null) {
      try {
        await sesionRepository.validarToken(token);
        this.token.value = token;
        if (isDeploy) {
          Get.offAllNamed(Routes.HOME);
        }
      } catch (e) {
        MensajeInferior.porDefecto(titulo: 'Error', mensaje: '$e');
      }
    }
  }
}
