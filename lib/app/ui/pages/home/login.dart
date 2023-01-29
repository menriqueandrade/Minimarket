import 'package:deudas_minimarket/app/core/controllers/login_controller.dart';
import 'package:deudas_minimarket/app/ui/pages/home/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../core/controllers/sesion_controller.dart';
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

class LoginScreen extends GetView {
  
  final LoginController userController = Get.put(LoginController());


  // const LoginScreen({super.key});

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
            child: ResponsiveLogin(userController),
          )),
    );
  }
}

class ResponsiveLogin extends GetResponsiveView {
  
  // final dynamic context;
  ResponsiveLogin(
    LoginController userController, {
    super.key,
  });
  double radio = 10;

  TextInputController txtCorreo = TextInputController();
  TextInputController txtClave = TextInputController();
  SesionController sesionController = Get.find();
  LoginController loginController = Get.find();

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
                                    "https://png.pngtree.com/thumb_back/fw800/background/20210222/pngtree-line-business-orange-background-image_564081.jpg"),
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
                                  "https://png.pngtree.com/thumb_back/fw800/background/20210222/pngtree-line-business-orange-background-image_564081.jpg",
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
                                  Text('Accede a tu panel de negocio'),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Inputs(
                                titulo: 'Correo',
                                icon: BootstrapIcons.envelope,
                                controller: txtCorreo,
                                tipoTeclado: TextInputType.emailAddress,
                                onSubmitted: (str) =>
                                    loginController.signInWithEmailAndPassword(
                                        txtCorreo.controlador.text,
                                        txtClave.controlador.text),
                              ),
                              Inputs(
                                titulo: 'Contraseña',
                                icon: BootstrapIcons.lock,
                                esClave: true,
                                controller: txtClave,
                                onSubmitted: (str) =>
                                    loginController.signInWithEmailAndPassword(
                                        txtCorreo.controlador.text,
                                        txtClave.controlador.text),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BotonTexto(
                                    texto: 'Olvide mi contraseña',
                                    accion: () {
                                      TextInputController
                                          txtReestablecerCorreo =
                                          TextInputController();
                                      final mensaje = ''.obs;
                                      Modal.porDefecto(context,
                                          titulo: 'Recuperar contraseña',
                                          centrarTitulo: true,
                                          textoAceptar: 'Reestablecer',
                                          onAceptar: () async {
                                        // Map? response = await sesionController
                                        //     .claveOlvidada(txtReestablecerCorreo
                                        //         .controlador.text);
                                        // mensaje.value = response!['encontrado'] ? 'Se le ha enviado un correo electrónico para restablecer la contraseña.' : 'No estas registrado';
                                      },
                                          onCancelar: () {},
                                          child: Column(
                                            children: [
                                              Inputs(
                                                icon: BootstrapIcons.envelope,
                                                titulo: 'Correo electrónico',
                                                controller:
                                                    txtReestablecerCorreo,
                                              ),
                                              Obx(() => Text(mensaje.value))
                                            ],
                                          ));
                                    },
                                    color: Colores.rojo,
                                    colorHover: Colores.gris,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SwitchPersonalizado(
                                  texto: 'Mantener sesion iniciada',
                                  estado: true,
                                  onChanged: (v) {}),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Boton(
                                    color: Colores.rojo,
                                    accion: () {
                                      String? emailLogin = txtCorreo
                                          .controlador.text
                                          .toString()
                                          .trim();
                                      String? contrasenaLogin = txtClave
                                          .controlador.text
                                          .toString()
                                          .trim();

                                      loginController
                                          .signInWithEmailAndPassword(
                                              emailLogin, contrasenaLogin);
                                    },
                                    child: const Text(
                                      'Iniciar Sesion',
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
                                    texto: 'Registrate aqui',
                                    accion: () {
                                      //    Modal.child(context, child: RegisterScreen(), width: screen.isPhone ? Get.width : null, barrierDismissible: false);
                                      Get.toNamed(Routes.REGISTRO);
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

  //LUEGO ENVIAR ESTE METODO AL CONTROLADOR DE LOGIN CONTROLLER
  // void iniciarSesion() async {
  //   if (txtCorreo.controlador.text.isEmpty) {
  //     txtCorreo.error.value = 'Debe ingresar el correo';
  //     return;
  //   }
  //   if (!txtCorreo.controlador.text.isEmail) {
  //     txtCorreo.error.value = 'Debe ingresar un correo valido';
  //     return;
  //   }
  //   if (txtClave.controlador.text.isEmpty) {
  //     txtClave.error.value = 'Debe ingresar la contraseña';
  //     return;
  //   }
  //   String? response = await sesionController.iniciarSesion(
  //       txtCorreo.controlador.text, txtClave.controlador.text);
  //   if (response != null) {
  //     txtCorreo.error.value = response;
  //   }
  // }
}
