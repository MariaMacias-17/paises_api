// estos son los modelos que usa la app, ya limpios y solo con lo que muestro.
// la entity es como viene la api, el model es como lo necesito yo en las pantallas

// lo que necesito para cada tarjeta de la lista
class PaisesModelList {
  // el codigo alpha_3 (ej: COL) lo uso para navegar al detalle /country/COL
  final String? codigo;
  final String? bandera;
  final String? nombreComun;
  final String? region;
  final String? capital;

  PaisesModelList({
    this.codigo,
    this.bandera,
    this.nombreComun,
    this.region,
    this.capital,
  });
}

// lo que necesito para la pantalla de detalle
class PaisesModelDetails {
  final String? codigo;
  final String? bandera;
  final String? nombreComun;
  final String? nombreOficial;
  final String? capital;
  final String? region;
  final String? subregion;
  final int? poblacion;
  // antes tenia Float y eso era de ffi, en dart los decimales son double
  final double? area;
  // idiomas, monedas y fronteras pueden ser varios, por eso son listas
  final List<String> idiomas;
  final List<String> monedas;
  final List<String> fronteras;

  PaisesModelDetails({
    this.codigo,
    this.bandera,
    this.nombreComun,
    this.nombreOficial,
    this.capital,
    this.region,
    this.subregion,
    this.poblacion,
    this.area,
    this.idiomas = const [],
    this.monedas = const [],
    this.fronteras = const [],
  });
}
