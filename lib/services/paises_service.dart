import 'package:dio/dio.dart';
import 'package:paises_api/config/api_config.dart';
import 'package:paises_api/entities/paises_api.dart';
import 'package:paises_api/mappers/paises_mapper.dart';
import 'package:paises_api/models/pagina_paises_model.dart';
import 'package:paises_api/models/paises_model.dart';

// service: hace las peticiones a la api con dio
class PaisesService {
  // dio con la url base y el header de la api key,
  // asi no lo tengo que poner en cada peticion
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {'Authorization': 'Bearer ${ApiConfig.apiKey}'},
    ),
  );

  // trae una pagina de paises. pagina 1 = offset 0, pagina 2 = offset 100, etc
  Future<PaginaPaisesModel> getPaises({required int pagina}) async {
    final response = await dio.get(
      '/countries/v5',
      queryParameters: {
        'limit': ApiConfig.paisesPorPagina,
        'offset': (pagina - 1) * ApiConfig.paisesPorPagina,
      },
    );

    final paisesEntity = Paises.fromJson(response.data);
    final paises = paisesEntity.data.objects
        .map(PaisesMapper.paisApiToPaisesModelList)
        .toList();

    return PaginaPaisesModel(
      paises: paises,
      total: paisesEntity.data.meta?.total ?? paises.length,
    );
  }

  // trae un solo pais por su codigo, ej: COL
  Future<PaisesModelDetails> getPaisByCode(String code) async {
    final response = await dio.get('/countries/v5/codes.alpha_3/$code');

    // aunque sea uno solo, la api igual lo manda dentro de data.objects
    final paisesEntity = Paises.fromJson(response.data);
    if (paisesEntity.data.objects.isEmpty) {
      throw Exception('No se encontro el pais $code');
    }

    return PaisesMapper.paisApiToPaisesModelDetails(
      paisesEntity.data.objects.first,
    );
  }

  // para mostrarle al usuario un mensaje entendible y no el error feo de dio
  static String mensajeDeError(Object error) {
    if (error is DioException) {
      final status = error.response?.statusCode;
      if (status == 401 || status == 403) {
        return 'La API key no es valida. Revisa config/api_config.dart';
      }
      if (status == 404) return 'No se encontro el pais';
      if (status == 429) return 'Hiciste muchas peticiones, espera un momento';
      if (error.type == DioExceptionType.connectionError ||
          error.type == DioExceptionType.connectionTimeout) {
        return 'No hay conexion a internet';
      }
    }
    return 'Algo salio mal cargando los paises';
  }
}
