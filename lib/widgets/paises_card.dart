import 'package:flutter/material.dart';
import 'package:paises_api/config/app_theme.dart';
import 'package:paises_api/widgets/bandera_imagen.dart';
import 'package:paises_api/widgets/region_chip.dart';

// tarjeta de cada pais en la lista: bandera, nombre, capital y region.
// el onTap lo recibe de afuera para que la tarjeta no sepa nada de rutas
class PaisCard extends StatelessWidget {
  final String nombreComun;
  final String capital;
  final String region;
  final String? bandera;
  final VoidCallback onTap;

  const PaisCard({
    super.key,
    required this.nombreComun,
    required this.capital,
    required this.region,
    required this.bandera,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // para que el efecto del InkWell respete los bordes redondeados
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              BanderaImagen(url: bandera, width: 72, height: 48),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombreComun,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_city_outlined,
                          size: 14,
                          color: AppTheme.textoSecundario,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            capital,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppTheme.textoSecundario,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    RegionChip(region: region),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppTheme.textoSecundario,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
