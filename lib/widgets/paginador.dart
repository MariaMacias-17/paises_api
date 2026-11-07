import 'package:flutter/material.dart';
import 'package:paises_api/config/app_theme.dart';

// los botones de abajo: < 1 2 3 >
// no guarda nada, solo avisa con onCambiarPagina que pagina tocaron
// y el bloc es el que se encarga de cargarla
class Paginador extends StatelessWidget {
  final int paginaActual;
  final int totalPaginas;
  final bool habilitado;
  final ValueChanged<int> onCambiarPagina;

  const Paginador({
    super.key,
    required this.paginaActual,
    required this.totalPaginas,
    required this.onCambiarPagina,
    this.habilitado = true,
  });

  @override
  Widget build(BuildContext context) {
    final hayAnterior = habilitado && paginaActual > 1;
    final haySiguiente = habilitado && paginaActual < totalPaginas;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.superficie,
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
        ),
      ),
      // SafeArea para que no quede debajo de la barra de gestos del celular
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            IconButton(
              onPressed: hayAnterior
                  ? () => onCambiarPagina(paginaActual - 1)
                  : null,
              icon: const Icon(Icons.chevron_left_rounded),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // genero un boton por cada pagina
                    for (var pagina = 1; pagina <= totalPaginas; pagina++)
                      _BotonPagina(
                        numero: pagina,
                        seleccionado: pagina == paginaActual,
                        onTap: habilitado && pagina != paginaActual
                            ? () => onCambiarPagina(pagina)
                            : null,
                      ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: haySiguiente
                  ? () => onCambiarPagina(paginaActual + 1)
                  : null,
              icon: const Icon(Icons.chevron_right_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

// el boton con el numero, privado porque solo lo usa el paginador
class _BotonPagina extends StatelessWidget {
  final int numero;
  final bool seleccionado;
  final VoidCallback? onTap;

  const _BotonPagina({
    required this.numero,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: seleccionado ? AppTheme.acento : AppTheme.superficieAlta,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: Text(
                '$numero',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: seleccionado ? AppTheme.fondo : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
