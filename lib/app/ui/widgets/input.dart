import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/colores.dart';

/**
 * se compone de dos clases
 * TextinputController 
 * Inputs
 * es utilizada para crear los inputs de los formularios
 * textinputcontroller es un controlador personalizado que contiene un TextEditingController 
 * para recobir lo que se digita por teclado
 * y un error, el cual facilita la forma de mostrar que este input tiene un error
 */

class TextInputController {
  TextEditingController controlador = TextEditingController();
  final error = ''.obs;
  TextInputController init(str){
    controlador.text = str==null ? '' : str.toString();
    return this;
  }
}

class Inputs extends StatelessWidget {

  final mostrarClave = true.obs;
  final estaEnfocado = false.obs;

  final IconData? icon;
  final String? titulo;
  final TextInputController controller;
  final TextInputType? tipoTeclado;
  final bool esClave;
  final int maxLines;
  final Function(String? str)? onChanged;
  final Function(String? str)? onSubmitted;

  Inputs({
    super.key, 
    this.icon,
    this.titulo,
    required this.controller,
    this.tipoTeclado,
    this.esClave = false, 
    this.maxLines = 1, 
    this.onChanged, 
    this.onSubmitted, 
  });

  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    myFocusNode.addListener(() {
      if (!myFocusNode.hasFocus){
        if(esClave){
          mostrarClave.value = true;
        }
        estaEnfocado.value = false;
        if(controller.controlador.text.isEmpty){
          controller.error.value = '';
        }
      } else{
        estaEnfocado.value = true;
      }
    });

    return Obx(
      (){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              cursorColor: Colores.negro,
              focusNode: myFocusNode,
              obscureText: esClave && mostrarClave.value,
              keyboardType: tipoTeclado,
              controller: controller.controlador,
              maxLines: maxLines,
              onSubmitted: onSubmitted,
              onChanged: (String? str){
                controller.error.value = '';
                if(onChanged != null){
                  onChanged!('$str');
                }
                if(tipoTeclado == TextInputType.number){
                  controller.error.value = str!.isNum ? '' : 'Solo se permiten numeros';
                }
                if(str!.isEmpty){
                  controller.error.value = '';
                }
              },
              decoration: InputDecoration(
                enabledBorder:  UnderlineInputBorder(
                  borderSide: BorderSide(color: Colores.gris), //<-- SEE HERE
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colores.negro ), //<-- SEE HERE
                ),
                errorText: controller.error.value.isEmpty ? null : controller.error.value,
                errorStyle: const TextStyle(fontSize: 10),
                labelText: titulo,
                labelStyle: TextStyle(
                  color: estaEnfocado.value ? Colores.negro : Colores.gris,
                  overflow: TextOverflow.fade
                ),
                suffixIcon: SizedBox(
                  width: esClave ? 80 : 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      colocarX(),
                      esClave ? Expanded(
                        child: iconoOjo()
                      ) : Container(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: controller.error.value.isEmpty ? 20 : 0,)
          ],
        );
      }
    );
  }

  IconButton iconoOjo() {
    return IconButton(
      autofocus: false,
      onPressed: (){
        mostrarClave.value = !mostrarClave.value;
      }, 
      icon: Icon(
        mostrarClave.value ? BootstrapIcons.eye : BootstrapIcons.eye_slash, 
        color: estaEnfocado.value ? Colores.negro : Colores.gris,
      )
    );
  }

  Widget colocarX(){
    if(controller.controlador.text.isEmpty){
      return Expanded(child: Container());
    }
    return Expanded(
      child: IconButton(
        autofocus: false,
        onPressed: (){
          controller.controlador.clear();
          controller.error.value = '';
          if(onChanged!=null){
            onChanged!('');
          }
        }, 
        icon: Icon(BootstrapIcons.x, color: estaEnfocado.value ? Colores.negro : Colores.gris)
      )
    );
  }
}
