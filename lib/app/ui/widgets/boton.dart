
import 'package:flutter/material.dart';

import '../theme/colores.dart';

/**
 * boton personalizado
 * se aplican estilos y recibe por parametros colores y acciones para personalizarlo 
 * acorde a la situacion
*/

class Boton extends StatefulWidget {

  final VoidCallback? accion;
  final Color? color;
  final Color? colorHover;
  final Widget? child;
  final double padding;
  final double radio;

  const Boton({
    Key? key,
    this.accion,
    this.color,
    this.colorHover,
    this.child,
    this.padding = 10,
    this.radio = 5,
  }) : super(key: key);

  @override
  State<Boton> createState() => _BotonState();
}

class _BotonState extends State<Boton> {
  
  VoidCallback? accion;
  Color? color;
  Color? colorHover;
  Widget? child;
  double radio = 0;

  bool _onHovered = false;
  bool _onFocused = false;

  @override
  void initState() {
    super.initState();

    accion = widget.accion;
    color = widget.color ?? Colores.negro;
    colorHover = widget.colorHover ?? Colores.negro;
    child = widget.child;
    radio = widget.radio;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: accion,
      child: FocusableActionDetector(
        onShowFocusHighlight: focus,
        onShowHoverHighlight: hover,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: _onHovered || _onFocused ? colorHover:color,
              borderRadius: BorderRadius.circular(radio)
            ),
            padding: EdgeInsets.all(widget.padding),
            child: child  ?? const Text('   ')
          ),
        ),
      ),
    );
  }

  hover(value){
    _onHovered = !_onHovered;
    setState(() {});
  }

  focus(value){
    _onFocused = !_onFocused;
    setState(() {});
  } 
}



class BotonTexto extends StatefulWidget {

  final VoidCallback? accion;
  final String? texto;
  final Color? color;
  final Color? colorHover;

  const BotonTexto({    
    super.key, 
    this.accion, 
    this.texto, 
    this.color, 
    this.colorHover, 
  });

  @override
  State<BotonTexto> createState() => _BotonTextoState();
}

class _BotonTextoState extends State<BotonTexto> {
  
  VoidCallback? accion;
  String texto = '';
  Color? color;
  Color? colorHover;
  Widget? child;

  bool _onHovered = false;
  bool _onFocused = false;

  @override
  void initState() {
    super.initState();

    accion = widget.accion;
    texto = widget.texto ?? '';
    color = widget.color ?? Colores.negro;
    colorHover = widget.colorHover ?? Colores.negro;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: accion,
      child: FocusableActionDetector(
        onShowFocusHighlight: focus,
        onShowHoverHighlight: hover,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            texto,
            style: TextStyle(
              color: _onHovered || _onFocused ? colorHover:color,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

  hover(value){
    _onHovered = !_onHovered;
    setState(() {});
  }

  focus(value){
    _onFocused = !_onFocused;
    setState(() {});
  } 
}