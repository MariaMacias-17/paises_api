import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paises_api/models/paises_model.dart';
import 'package:paises_api/services/paises_service.dart';

part 'pais_detalle_bloc_event.dart';
part 'pais_detalle_bloc_state.dart';

// bloc aparte para el detalle, asi el estado de la lista no se mezcla
// con el del pais que estoy viendo
class PaisDetalleBloc extends Bloc<PaisDetalleEvent, PaisDetalleState> {
  final paisesService = PaisesService();

  PaisDetalleBloc() : super(const PaisDetalleState()) {
    on<CargarPaisDetalleEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, hasError: false));

      try {
        final pais = await paisesService.getPaisByCode(event.codigo);
        emit(state.copyWith(isLoading: false, pais: pais));
      } catch (error) {
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
