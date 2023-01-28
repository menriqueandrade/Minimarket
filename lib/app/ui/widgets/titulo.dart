import 'package:flutter/material.dart';


import '../../variables.dart';
import '../theme/colores.dart';
import '../theme/fonts.dart';


class TituloWidget extends StatelessWidget {

  final double fontSize;
  const TituloWidget({
    Key? key, this.fontSize = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
            fontFamily: Fuentes.ztgraftonThin,
            color: Colores.negro),
        children: <TextSpan>[
          TextSpan(
            text: titulo_minimarket.substring(0, 3),
            style: TextStyle(
                fontFamily: Fuentes.ztgraftonBold,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: Colores.rosa),
          ),
          TextSpan(
            text: titulo_minimarket.substring(3, titulo_minimarket.length),
            style: TextStyle(
                fontFamily: Fuentes.ztgraftonBold,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: Colores.negro),
          ),
        ],
      ),
    );
  }
}