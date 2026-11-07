part of 'pais_detalle_bloc.dart';

@immutable
sealed class PaisDetalleEvent {}

// le paso el codigo que viene en la ruta /country/:code
class CargarPaisDetalleEvent extends PaisDetalleEvent {
  final String codigo;
  CargarPaisDetalleEvent({required this.codigo});
}
