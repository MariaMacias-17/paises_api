import 'package:flutter/material.dart';
import 'package:paises_api/config/app_theme.dart';

// cajita del detalle con icono, titulo y valor (capital, region, poblacion, area)
class DatoTile extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String valor;

  const DatoTile({
    super.key,
    required this.icono,
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.superficie,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.acento.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icono, size: 18, color: AppTheme.acento),
          ),
          const SizedBox(height: 10),
          Text(
            titulo,
            style: const TextStyle(
              color: AppTheme.textoSecundario,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            valor,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
