import 'package:paises_api/entities/paises_api.dart';
import 'package:paises_api/models/paises_model.dart';

// el mapper convierte lo que llega de la api (entity) a mis modelos.
// igual que en pokemon, pero aqui tengo dos: uno para la lista y otro para el detalle
class PaisesMapper {
  static PaisesModelList paisApiToPaisesModelList(PaisApi paisApi) {
    return PaisesModelList(
      codigo: _textoONull(paisApi.codes?.alpha3),
      bandera: _textoONull(paisApi.flag?.urlPng),
      nombreComun: _nombreComun(paisApi),
      region: paisApi.region,
      capital: _capitales(paisApi),
    );
  }

  static PaisesModelDetails paisApiToPaisesModelDetails(PaisApi paisApi) {
    return PaisesModelDetails(
      codigo: _textoONull(paisApi.codes?.alpha3),
      bandera: _textoONull(paisApi.flag?.urlPng),
      nombreComun: _nombreComun(paisApi),
      nombreOficial:
          paisApi.names?.translations['spa']?.official ??
          paisApi.names?.official,
      capital: _capitales(paisApi),
      region: paisApi.region,
      subregion: paisApi.subregion,
      poblacion: paisApi.population,
      area: paisApi.area?.kilometers,
      // de cada idioma solo me interesa el nombre
      idiomas: paisApi.languages
          .map((idioma) => idioma.name)
          .whereType<String>()
          .toList(),
      // la moneda la muestro como "Colombian peso ($)"
      monedas: paisApi.currencies
          .where((moneda) => moneda.name != null)
          .map(
            (moneda) => moneda.symbol == null
                ? moneda.name!
                : '${moneda.name} (${moneda.symbol})',
          )
          .toList(),
      // las fronteras vienen como codigos alpha_3, ej: ["BRA", "ECU", "PER"]
      fronteras: paisApi.borders,
    );
  }

  // hay territorios (ej: Abjasia, Somalilandia) que traen el codigo y la bandera
  // como "" en vez de null, entonces los vacios los paso a null
  static String? _textoONull(String? texto) {
    if (texto == null || texto.isEmpty) return null;
    return texto;
  }

  // si la api trae el nombre en español lo uso, si no dejo el que viene en ingles
  static String? _nombreComun(PaisApi paisApi) {
    return paisApi.names?.translations['spa']?.common ?? paisApi.names?.common;
  }

  // hay paises con varias capitales (ej: Bolivia) entonces las junto con coma
  static String? _capitales(PaisApi paisApi) {
    final nombres = paisApi.capitals
        .map((capital) => capital.name)
        .whereType<String>()
        .toList();
    if (nombres.isEmpty) return null;
    return nombres.join(', ');
  }
}
