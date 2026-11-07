// pone puntos de miles a los numeros grandes, ej: 50882884 -> 50.882.884
// la uso para la poblacion y el area
String formatearNumero(num numero) {
  final texto = numero.round().toString();
  final buffer = StringBuffer();

  for (var i = 0; i < texto.length; i++) {
    // cada 3 digitos contando desde el final pongo un punto
    if (i > 0 && (texto.length - i) % 3 == 0) buffer.write('.');
    buffer.write(texto[i]);
  }

  return buffer.toString();
}
