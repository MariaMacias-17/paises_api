import 'package:flutter/material.dart';

// etiqueta pequeña con la region, cada region tiene su color
class RegionChip extends StatelessWidget {
  final String region;

  const RegionChip({super.key, required this.region});

  // la api manda las regiones en ingles
  Color _colorRegion() {
    switch (region) {
      case 'Americas':
        return const Color(0xFF5EEAD4);
      case 'Europe':
        return const Color(0xFF93C5FD);
      case 'Asia':
        return const Color(0xFFFCA5A5);
      case 'Africa':
        return const Color(0xFFFCD34D);
      case 'Oceania':
        return const Color(0xFFC4B5FD);
      case 'Antarctic':
        return const Color(0xFFE2E8F0);
      default:
        return const Color(0xFF9AA4B2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorRegion();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        region,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
