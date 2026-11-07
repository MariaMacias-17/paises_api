// modelos que usan las pantallas.
// la entity es como viene la api y el model es como lo necesito para mostrarlo

// datos de cada tarjeta de la lista
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

// datos de la pantalla de detalle
class PaisesModelDetails {
  final String? codigo;
  final String? bandera;
  final String? nombreComun;
  final String? nombreOficial;
  final String? capital;
  final String? region;
  final String? subregion;
  final int? poblacion;
  // area en km2
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
