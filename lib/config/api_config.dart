// aqui dejo todo lo de la api en un solo lugar para no repetirlo en el service
class ApiConfig {
  static const String baseUrl = 'https://api.restcountries.com';

  // la key la saque de restcountries.com, va en el header Authorization: Bearer
  static const String apiKey = 'rc_live_73f5791625ea4e37bf6b853d60d7e3f3';

  // la api deja maximo 100 por pagina
  static const int paisesPorPagina = 100;
}
