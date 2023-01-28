
class ImagenesClienteDeudor {
  Imagen fotoPrincipal;
  Imagen fotoLogo;
  List<Imagen> fotosAdicionales;
  ImagenesClienteDeudor({
    required this.fotoPrincipal,
    required this.fotoLogo,
    required this.fotosAdicionales,
  });
  factory ImagenesClienteDeudor.construir({
    fotoPrincipal,
    fotoLogo,
    fotosAdicionales,
  }){
    return ImagenesClienteDeudor(
      fotoPrincipal: fotoPrincipal ?? Imagen(tipo: Imagen.URL),
      fotoLogo: fotoLogo ?? Imagen(tipo: Imagen.URL),
      fotosAdicionales: fotosAdicionales ?? <Imagen>[]
    );
  }
}

class Imagen{

  static const String URL = 'url';
  static const String FILE = 'file';

  dynamic id;
  dynamic imagen;
  dynamic tipo;

  Imagen({
    this.id = '',
    this.imagen = '',
    this.tipo = URL
  });

}