import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colores.dart';
import 'boton.dart';

/**
 * Modal
 * 
 * compuesto de dos metodos:
 * 1. PorDefecto() que retorna un modal que contiene botones y acciones, es usado para mostrar las alertas y mensajes
 * 2. child: al cual se se pada por para el elemento que se quiere mostrar es usado para mostrar los formularios
 * 
 */
class Modal {
  static porDefecto(context,{
    Widget? child, 
    String? titulo,
    bool centrarTitulo = false,
    bool? barrierDismissible, 
    Function? onCancelar, 
    Function? onAceptar,
    String? textoCancelar,
    String? textoAceptar,
    Color? colorCancelar,
    Color? colorAceptar,
    bool mostrarAcciones = true,
    bool widthDefault = true
  }){
    showDialog(
      barrierDismissible: barrierDismissible ?? true,
      context: context,
      builder: (c)=>Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.all(10),
        child: SizedBox(
          width: widthDefault ? 500 : null,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colores.negro,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '  ${titulo ?? ''}', 
                          textAlign: centrarTitulo ? TextAlign.center : TextAlign.left,
                          style: const TextStyle(color: Colores.blanco)
                        )
                      ),
                      IconButton(
                        onPressed: ()=>Get.back(), 
                        icon: const Icon(
                          BootstrapIcons.x, 
                          color: Colores.blanco,
                        )
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colores.blanco,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      child  ?? const SizedBox(),
                      const SizedBox(height: 20,),
                      !mostrarAcciones ? Container() : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Boton(
                            color: colorCancelar ?? Colores.rojo, 
                            child: Text(textoCancelar ?? 'Cancelar', style: TextStyle(color: Colores.blanco),), 
                            accion:(){
                              if(onCancelar!=null){
                                onCancelar();
                              }else{
                                Get.back();
                              }
                            }
                          ),
                          const SizedBox(width: 10,),
                          Boton(
                            color: colorAceptar ?? Colores.blanco, 
                            child: Text(textoAceptar ?? 'Aceptar', style: TextStyle(color: Colores.blanco),), 
                            accion:(){
                              if(onAceptar!=null){
                                onAceptar();
                              }else{
                                Get.back();
                              }
                            }
                          ),
                        ],
                      )
                    ],
                  )
                ),
              ],
            ),
          )
        )
      )
    );
  }
  static Future child(context,{
    Widget? child, 
    bool? barrierDismissible, 
    double? width
  })async{
    return await showDialog(
      barrierDismissible: barrierDismissible ?? true,
      context: context,
      builder: (c)=>Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(0),
        child: SizedBox(
          // width: width ?? 500,
          width: GetPlatform.isWeb ? 500 : Get.width,
          child: child
        )
      )
    );
  }
}