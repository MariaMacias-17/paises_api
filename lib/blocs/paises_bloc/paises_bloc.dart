import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paises_api/config/api_config.dart';
import 'package:paises_api/models/paises_model.dart';
import 'package:paises_api/services/paises_service.dart';

part 'paises_bloc_event.dart';
part 'paises_bloc_state.dart';

// este bloc maneja la lista de paises y en que pagina voy
class PaisesBloc extends Bloc<PaisesEvent, PaisesState> {
  final paisesService = PaisesService();

  PaisesBloc() : super(const PaisesState()) {
    // pide a la api la pagina que llega en el evento
    on<CargarPaisesEvent>((event, emit) async {
      // 1. cargando: aviso que estoy cargando y en que pagina quede
      emit(
        state.copyWith(
          isLoading: true,
          hasError: false,
          paginaActual: event.pagina,
        ),
      );

      try {
        final resultado = await paisesService.getPaises(pagina: event.pagina);

        // si el usuario toco otra pagina mientras esta cargaba, ignoro
        // esta respuesta para que no me pise la pagina nueva
        if (state.paginaActual != event.pagina) return;

        // 2. exito: guardo los paises y calculo cuantas paginas hay
        emit(
          state.copyWith(
            isLoading: false,
            paises: resultado.paises,
            totalPaginas: (resultado.total / ApiConfig.paisesPorPagina).ceil(),
          ),
        );
      } catch (error) {
        if (state.paginaActual != event.pagina) return;

        // 3. error: guardo el mensaje para mostrarlo en pantalla
        emit(
          state.copyWith(
            isLoading: false,
            hasError: true,
            mensajeError: PaisesService.mensajeDeError(error),
          ),
        );
      }
    });
  }
}
