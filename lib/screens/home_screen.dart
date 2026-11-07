import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paises_api/blocs/paises_bloc/paises_bloc.dart';
import 'package:paises_api/config/app_theme.dart';
import 'package:paises_api/widgets/error_vista.dart';
import 'package:paises_api/widgets/paginador.dart';
import 'package:paises_api/widgets/paises_card.dart';

// pantalla principal: lista de paises con el paginador abajo
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // apenas abre la pantalla le pido al bloc la pagina 1
    context.read<PaisesBloc>().add(CargarPaisesEvent(pagina: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Países del mundo'),
        // debajo del titulo muestro en que pagina voy
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: BlocBuilder<PaisesBloc, PaisesState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.totalPaginas == 0
                        ? 'Cargando...'
                        : 'Página ${state.paginaActual} de ${state.totalPaginas}',
                    style: const TextStyle(color: AppTheme.textoSecundario),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      body: BlocBuilder<PaisesBloc, PaisesState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(child: _contenido(context, state)),
              // el paginador solo aparece cuando ya se cuantas paginas hay
              if (state.totalPaginas > 0)
                Paginador(
                  paginaActual: state.paginaActual,
                  totalPaginas: state.totalPaginas,
                  // mientras carga desactivo los botones
                  habilitado: !state.isLoading,
                  onCambiarPagina: (pagina) {
                    context.read<PaisesBloc>().add(
                      CargarPaisesEvent(pagina: pagina),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }

  // muestra el loader, el error o la lista segun el estado del bloc
  Widget _contenido(BuildContext context, PaisesState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.hasError) {
      return ErrorVista(
        mensaje: state.mensajeError ?? 'Ocurrio un error',
        onReintentar: () {
          context.read<PaisesBloc>().add(
            CargarPaisesEvent(pagina: state.paginaActual),
          );
        },
      );
    }

    if (state.paises.isEmpty) {
      return const Center(child: Text('No hay paises'));
    }

    return ListView.separated(
      // la key con la pagina hace que al cambiar de pagina la lista vuelva arriba
      key: ValueKey(state.paginaActual),
      padding: const EdgeInsets.all(16),
      itemCount: state.paises.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final pais = state.paises[index];

        return PaisCard(
          nombreComun: pais.nombreComun ?? 'No tiene nombre',
          capital: pais.capital ?? 'Sin capital',
          region: pais.region ?? 'Sin región',
          bandera: pais.bandera,
          onTap: () {
            // sin codigo no puedo pedir el detalle a la api, solo aviso
            if (pais.codigo == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Este territorio no tiene detalle disponible'),
                ),
              );
              return;
            }
            // push y no go, para que en el detalle salga la flecha de volver
            context.push('/country/${pais.codigo}');
          },
        );
      },
    );
  }
}
