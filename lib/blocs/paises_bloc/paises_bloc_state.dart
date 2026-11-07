part of 'paises_bloc.dart';

class PaisesState extends Equatable {
  final bool isLoading;
  final bool hasError;
  final String? mensajeError;
  // antes tenia un solo pais, pero la lista necesita varios
  final List<PaisesModelList> paises;
  final int paginaActual;
  final int totalPaginas;

  const PaisesState({
    this.isLoading = false,
    this.hasError = false,
    this.mensajeError,
    this.paises = const [],
    this.paginaActual = 1,
    this.totalPaginas = 0,
  });

  // copyWith crea un estado nuevo cambiando solo lo que le paso,
  // lo demas lo deja como estaba (por eso el ??)
  PaisesState copyWith({
    bool? isLoading,
    bool? hasError,
    String? mensajeError,
    List<PaisesModelList>? paises,
    int? paginaActual,
    int? totalPaginas,
  }) {
    return PaisesState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      mensajeError: mensajeError ?? this.mensajeError,
      paises: paises ?? this.paises,
      paginaActual: paginaActual ?? this.paginaActual,
      totalPaginas: totalPaginas ?? this.totalPaginas,
    );
  }

  // equatable compara con estos campos para saber si el estado cambio
  // y asi el BlocBuilder solo redibuja cuando de verdad hay algo nuevo
  @override
  List<Object?> get props => [
    isLoading,
    hasError,
    mensajeError,
    paises,
    paginaActual,
    totalPaginas,
  ];
}
