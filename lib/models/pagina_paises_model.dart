import 'package:paises_api/models/paises_model.dart';

// cuando pido una pagina necesito los paises de esa pagina y tambien
// el total de paises para saber cuantas paginas hay (para los botones 1, 2, 3...)
class PaginaPaisesModel {
  final List<PaisesModelList> paises;
  final int total;

  PaginaPaisesModel({required this.paises, required this.total});
}
