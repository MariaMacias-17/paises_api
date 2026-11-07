import 'package:flutter/material.dart';
import 'package:paises_api/config/app_theme.dart';

// seccion con titulo y una lista de chips. la uso para idiomas, monedas y fronteras.
// si le paso onTapItem los chips se pueden tocar (eso lo uso en fronteras
// para ir al pais vecino)
class SeccionChips extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final List<String> items;
  final String textoVacio;
  final ValueChanged<String>? onTapItem;

  const SeccionChips({
    super.key,
    required this.titulo,
    required this.icono,
    required this.items,
    this.textoVacio = 'Sin datos',
    this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icono, size: 18, color: AppTheme.acento),
            const SizedBox(width: 8),
            Text(
              titulo,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 10),
        items.isEmpty
            ? Text(
                textoVacio,
                style: const TextStyle(color: AppTheme.textoSecundario),
              )
            // Wrap para que los chips bajen de linea si no caben
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: items.map((item) => _chip(item)).toList(),
              ),
      ],
    );
  }

  Widget _chip(String item) {
    final sePuedeTocar = onTapItem != null;

    return ActionChip(
      label: Text(item),
      avatar: sePuedeTocar
          ? const Icon(Icons.north_east_rounded, size: 14)
          : null,
      onPressed: sePuedeTocar ? () => onTapItem!(item) : null,
      backgroundColor: AppTheme.superficieAlta,
      side: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
