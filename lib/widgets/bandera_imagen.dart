import 'package:flutter/material.dart';
import 'package:paises_api/config/app_theme.dart';

// la bandera la uso en la tarjeta y en el detalle, por eso la hice widget aparte.
// muestra un loader mientras carga y un icono si la imagen falla
class BanderaImagen extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final double radio;
  final BoxFit fit;

  const BanderaImagen({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.radio = 8,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radio),
      child: SizedBox(
        width: width,
        height: height,
        child: url == null
            ? _sinBandera()
            : Image.network(
                url!,
                fit: fit,
                loadingBuilder: (context, child, progreso) {
                  if (progreso == null) return child;
                  return Container(color: AppTheme.superficieAlta);
                },
                errorBuilder: (context, error, stackTrace) => _sinBandera(),
              ),
      ),
    );
  }

  Widget _sinBandera() {
    return Container(
      color: AppTheme.superficieAlta,
      child: const Icon(Icons.flag_outlined, color: AppTheme.textoSecundario),
    );
  }
}
