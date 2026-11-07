import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paises_api/models/paises_model.dart';
import 'package:paises_api/services/paises_service.dart';

part 'pais_detalle_bloc_event.dart';
part 'pais_detalle_bloc_state.dart';

// bloc del detalle, separado del de la lista para que no se mezclen los estados
class PaisDetalleBloc extends Bloc<PaisDetalleEvent, PaisDetalleState> {
  final paisesService = PaisesService();

  PaisDetalleBloc() : super(const PaisDetalleState()) {
    // pide el pais a la api por su codigo
    on<CargarPaisDetalleEvent>((event, emit) async {
      // cargando
      emit(state.copyWith(isLoading: true, hasError: false));

      try {
        // exito: guardo el pais
        final pais = await paisesService.getPaisByCode(event.codigo);
        emit(state.copyWith(isLoading: false, pais: pais));
      } catch (error) {
        // error: guardo el mensaje para mostrarlo
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
