
import 'package:flutter/material.dart';

import '../theme/colores.dart';

/**
 * switch personalizado
 * es opcional mandar el texto
 */

class SwitchPersonalizado extends StatelessWidget {

  final String? texto;
  final bool estado;
  final Function(bool value) onChanged;

  const SwitchPersonalizado({
    super.key, 
    this.texto, 
    required this.estado, 
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Row( 
      mainAxisAlignment: texto == null ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
      children: [
        texto == null ? Container(): Expanded(
          flex: 7,
          child: Text(
            texto!,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Switch(
                value: estado,
                inactiveThumbColor: Colores.negro,
                activeColor: Colores.blanco,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

