import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paises_api/blocs/pais_detalle_bloc/pais_detalle_bloc.dart';
import 'package:paises_api/config/app_theme.dart';
import 'package:paises_api/config/formatos.dart';
import 'package:paises_api/models/paises_model.dart';
import 'package:paises_api/widgets/bandera_imagen.dart';
import 'package:paises_api/widgets/dato_tile.dart';
import 'package:paises_api/widgets/error_vista.dart';
import 'package:paises_api/widgets/region_chip.dart';
import 'package:paises_api/widgets/seccion_chips.dart';

// pantalla de detalle de un pais.
// el bloc de esta pantalla se crea en routes.dart con el codigo de la url
class DetailsScreen extends StatelessWidget {
  final String code;

  const DetailsScreen({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaisDetalleBloc, PaisDetalleState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
            appBar: AppBar(title: Text(code)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.hasError || state.pais == null) {
          return Scaffold(
            appBar: AppBar(title: Text(code)),
            body: ErrorVista(
              mensaje: state.mensajeError ?? 'No se pudo cargar el pais',
              onReintentar: () {
                context.read<PaisDetalleBloc>().add(
                  CargarPaisDetalleEvent(codigo: code),
                );
              },
            ),
          );
        }

        return Scaffold(body: _detalle(context, state.pais!));
      },
    );
  }

  // arma toda la info del pais cuando ya cargo
  Widget _detalle(BuildContext context, PaisesModelDetails pais) {
    // CustomScrollView con SliverAppBar para que la bandera grande
    // se encoja cuando hago scroll hacia abajo
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 240,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                BanderaImagen(url: pais.bandera, radio: 0),
                // degradado encima de la bandera para que se una con el fondo oscuro
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black38, Colors.transparent, AppTheme.fondo],
                      stops: [0, 0.4, 1],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pais.nombreComun ?? 'Sin nombre',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  pais.nombreOficial ?? '',
                  style: const TextStyle(
                    color: AppTheme.textoSecundario,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    RegionChip(region: pais.region ?? 'Sin región'),
                    const SizedBox(width: 8),
                    if (pais.subregion != null)
                      Flexible(
                        child: Text(
                          pais.subregion!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppTheme.textoSecundario,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),

                // los 4 datos en dos filas de dos
                _filaDatos(
                  DatoTile(
                    icono: Icons.location_city_rounded,
                    titulo: 'Capital',
                    valor: pais.capital ?? 'Sin capital',
                  ),
                  DatoTile(
                    icono: Icons.public_rounded,
                    titulo: 'Región',
                    valor: pais.region ?? 'Sin región',
                  ),
                ),
                const SizedBox(height: 12),
                _filaDatos(
                  DatoTile(
                    icono: Icons.groups_rounded,
                    titulo: 'Población',
                    valor: pais.poblacion == null
                        ? 'Sin dato'
                        : formatearNumero(pais.poblacion!),
                  ),
                  DatoTile(
                    icono: Icons.straighten_rounded,
                    titulo: 'Área',
                    valor: pais.area == null
                        ? 'Sin dato'
                        : '${formatearNumero(pais.area!)} km²',
                  ),
                ),
                const SizedBox(height: 28),

                SeccionChips(
                  titulo: 'Idiomas',
                  icono: Icons.translate_rounded,
                  items: pais.idiomas,
                ),
                const SizedBox(height: 24),
                SeccionChips(
                  titulo: 'Monedas',
                  icono: Icons.payments_outlined,
                  items: pais.monedas,
                ),
                const SizedBox(height: 24),
                SeccionChips(
                  titulo: 'Fronteras',
                  icono: Icons.share_location_rounded,
                  items: pais.fronteras,
                  textoVacio: 'No tiene fronteras terrestres',
                  // al tocar una frontera abro el detalle de ese pais
                  onTapItem: (codigo) => context.push('/country/$codigo'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // IntrinsicHeight para que las dos cajitas de la fila queden del mismo alto
  Widget _filaDatos(Widget izquierda, Widget derecha) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: izquierda),
          const SizedBox(width: 12),
          Expanded(child: derecha),
        ],
      ),
    );
  }
}
