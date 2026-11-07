import 'package:paises_api/models/paises_model.dart';

// resultado de pedir una pagina: los paises de esa pagina y el total
// de paises, que sirve para saber cuantas paginas hay (botones 1, 2, 3...)
class PaginaPaisesModel {
  final List<PaisesModelList> paises;
  final int total;

  PaginaPaisesModel({required this.paises, required this.total});
}
