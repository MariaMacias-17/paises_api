part of 'pais_detalle_bloc.dart';

// estado del detalle: si esta cargando, si hubo error y el pais
class PaisDetalleState extends Equatable {
  // empieza en true porque apenas abro la pantalla ya voy a pedir el pais
  final bool isLoading;
  final bool hasError;
  final String? mensajeError;
  final PaisesModelDetails? pais;

  const PaisDetalleState({
    this.isLoading = true,
    this.hasError = false,
    this.mensajeError,
    this.pais,
  });

  PaisDetalleState copyWith({
    bool? isLoading,
    bool? hasError,
    String? mensajeError,
    PaisesModelDetails? pais,
  }) {
    return PaisDetalleState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      mensajeError: mensajeError ?? this.mensajeError,
      pais: pais ?? this.pais,
    );
  }

  @override
  List<Object?> get props => [isLoading, hasError, mensajeError, pais];
}
