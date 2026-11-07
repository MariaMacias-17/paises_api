part of 'paises_bloc.dart';

@immutable
sealed class PaisesEvent {}

// un solo evento: cargar la pagina que le diga (1, 2, 3...)
// lo uso al abrir la app, al tocar un boton del paginador y al reintentar
class CargarPaisesEvent extends PaisesEvent {
  final int pagina;
  CargarPaisesEvent({this.pagina = 1});
}
