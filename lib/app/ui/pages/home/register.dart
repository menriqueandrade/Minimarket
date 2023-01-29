import 'package:deudas_minimarket/app/core/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../core/controllers/sesion_controller.dart';
import '../../../core/controllers/users/user_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../variables.dart';
import '../../theme/colores.dart';

import 'package:bootstrap_icons/bootstrap_icons.dart';

import '../../widgets/boton.dart';
import '../../widgets/error_pantalla.dart';
import '../../widgets/input.dart';
import '../../widgets/modal.dart';
import '../../widgets/switch.dart';
import '../../widgets/titulo.dart';

class RegisterScreen extends GetView {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color.fromARGB(255, 255, 102, 0),
                  Color.fromARGB(255, 255, 102, 0),
                ],
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
              image: DecorationImage(
                  image: NetworkImage(
                      "https://d7lju56vlbdri.cloudfront.net/var/ezwebin_site/storage/images/_aliases/img_1col/noticias/solar-orbiter-toma-imagenes-del-sol-como-nunca-antes/9437612-1-esl-MX/Solar-Orbiter-toma-imagenes-del-Sol-como-nunca-antes.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.1)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ResponsiveRegister(),
          )),
    );
  }
}

class ResponsiveRegister extends GetResponsiveView {
  // final dynamic context;
  ResponsiveRegister({
    super.key,
  });
  double radio = 10;

  TextInputController txtCorreoRegister = TextInputController();
  TextInputController txtClaveRegister = TextInputController();
  SesionController sesionController = Get.find();
  UserController registerController = Get.find();

  @override
  Widget builder() {
    //sesionController.validarToken();

    if (screen.isWatch) {
      return const ErrorPantalla();
    }
    return Builder(
      builder: (BuildContext context) => Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: !screen.isDesktop ? 0 : 1, child: const SizedBox()),
                !screen.isDesktop
                    ? Container()
                    : Expanded(
                        child: Container(
                          width: 400,
                          height: 500,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(radio),
                                  bottomLeft: Radius.circular(radio)),
                              color: Colores.blanco,
                              image: const DecorationImage(
                                image: NetworkImage(
                                    "https://d7lju56vlbdri.cloudfront.net/var/ezwebin_site/storage/images/_aliases/img_1col/noticias/solar-orbiter-toma-imagenes-del-sol-como-nunca-antes/9437612-1-esl-MX/Solar-Orbiter-toma-imagenes-del-Sol-como-nunca-antes.jpg"),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              )),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            color: Colores.negro.withOpacity(0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  "https://d7lju56vlbdri.cloudfront.net/var/ezwebin_site/storage/images/_aliases/img_1col/noticias/solar-orbiter-toma-imagenes-del-sol-como-nunca-antes/9437612-1-esl-MX/Solar-Orbiter-toma-imagenes-del-Sol-como-nunca-antes.jpg",
                                  width: 150,
                                  filterQuality: FilterQuality.high,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                Expanded(
                  flex: screen.isTablet ? 3 : 1,
                  child: Container(
                    width: 400,
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colores.blanco,
                        borderRadius: screen.isDesktop
                            ? BorderRadius.only(
                                topRight: Radius.circular(radio),
                                bottomRight: Radius.circular(radio))
                            : BorderRadius.circular(radio)),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -250,
                          right: -250,
                          child: Opacity(
                            opacity: 0.3,
                            child: Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f4/BMW_logo_%28gray%29.svg/2048px-BMW_logo_%28gray%29.svg.png",
                              width: 500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: screen.isPhone
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [TituloWidget()],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Zona de Registro'),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Inputs(
                                titulo: 'Correo',
                                icon: BootstrapIcons.envelope,
                                controller: txtCorreoRegister,
                                tipoTeclado: TextInputType.emailAddress,
                                onSubmitted: (str) => registerController
                                    .createUserInWithEmailAndPassword(
                                        txtCorreoRegister.controlador.text,
                                        txtClaveRegister.controlador.text),
                              ),
                              Inputs(
                                titulo: 'Contraseña',
                                icon: BootstrapIcons.lock,
                                esClave: true,
                                controller: txtClaveRegister,
                                onSubmitted: (str) => registerController
                                    .createUserInWithEmailAndPassword(
                                        txtCorreoRegister.controlador.text,
                                        txtClaveRegister.controlador.text),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // SwitchPersonalizado(
                              //     texto: 'Mantener sesion iniciada',
                              //     estado: true,
                              //     onChanged: (v) {}),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Boton(
                                    color: Colores.rojo,
                                    accion: () {
                                      String? emailRegister = txtCorreoRegister
                                          .controlador.text
                                          .toString()
                                          .trim();
                                      String? contrasenaRegister =
                                          txtClaveRegister.controlador.text
                                              .toString()
                                              .trim();

                                      registerController
                                          .createUserInWithEmailAndPassword(
                                              emailRegister,
                                              contrasenaRegister);
                                    },
                                    child: const Text(
                                      'Registrar',
                                      style: TextStyle(color: Colores.blanco),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('¿No tienes cuenta?  '),
                                  BotonTexto(
                                    texto: 'Ya tengo cuenta',
                                    accion: () {
                                      Get.toNamed(Routes.LOGIN);
                                    },
                                    color: Colores.rojo,
                                    colorHover: Colores.gris,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: screen.isDesktop ? 0 : 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(flex: !screen.isDesktop ? 0 : 1, child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
