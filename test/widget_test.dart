import 'package:flutter_test/flutter_test.dart';
import 'package:paises_api/config/formatos.dart';

// prueba de la funcion que formatea los numeros con puntos
void main() {
  test('formatearNumero pone puntos cada 3 digitos', () {
    expect(formatearNumero(0), '0');
    expect(formatearNumero(999), '999');
    expect(formatearNumero(1000), '1.000');
    expect(formatearNumero(50882884), '50.882.884');
    expect(formatearNumero(1141748.6), '1.141.749');
  });
}
