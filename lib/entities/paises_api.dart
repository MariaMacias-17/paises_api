// esta entity la saque de quicktype pegando la respuesta de la api,
// pero la recorte y deje solo lo que uso en la app.
// la version completa me daba errores porque:
//  - tenia clases llamadas Object y Colors que chocan con las de dart y flutter
//  - todo era required y no nulo, y hay paises que traen campos en null
//    (por ejemplo paises sin capital o sin fronteras) entonces se rompia el fromJson
// por eso aqui casi todo es opcional (?) o una lista vacia si no viene

class Paises {
  final Data data;

  Paises({required this.data});

  factory Paises.fromJson(Map<String, dynamic> json) =>
      Paises(data: Data.fromJson(json["data"]));
}

class Data {
  // los paises llegan en data.objects
  final List<PaisApi> objects;
  final Meta? meta;

  Data({required this.objects, this.meta});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    objects: json["objects"] == null
        ? []
        : List<PaisApi>.from(json["objects"].map((x) => PaisApi.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );
}

// meta me sirve para saber cuantos paises hay en total y asi calcular las paginas
class Meta {
  final int total;
  final int limit;
  final int offset;
  final bool more;

  Meta({
    required this.total,
    required this.limit,
    required this.offset,
    required this.more,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"] ?? 0,
    limit: json["limit"] ?? 0,
    offset: json["offset"] ?? 0,
    more: json["more"] ?? false,
  );
}

// en quicktype esta clase se llamaba Object, le cambie el nombre a PaisApi
class PaisApi {
  final Names? names;
  final Codes? codes;
  final List<Capital> capitals;
  final Flag? flag;
  final String? region;
  final String? subregion;
  final Area? area;
  final int? population;
  final List<Language> languages;
  final List<Currency> currencies;
  final List<String> borders;

  PaisApi({
    this.names,
    this.codes,
    required this.capitals,
    this.flag,
    this.region,
    this.subregion,
    this.area,
    this.population,
    required this.languages,
    required this.currencies,
    required this.borders,
  });

  factory PaisApi.fromJson(Map<String, dynamic> json) => PaisApi(
    names: json["names"] == null ? null : Names.fromJson(json["names"]),
    codes: json["codes"] == null ? null : Codes.fromJson(json["codes"]),
    capitals: json["capitals"] == null
        ? []
        : List<Capital>.from(json["capitals"].map((x) => Capital.fromJson(x))),
    flag: json["flag"] == null ? null : Flag.fromJson(json["flag"]),
    region: json["region"],
    subregion: json["subregion"],
    area: json["area"] == null ? null : Area.fromJson(json["area"]),
    // uso num por si la api manda la poblacion como decimal
    population: (json["population"] as num?)?.toInt(),
    languages: json["languages"] == null
        ? []
        : List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x)),
          ),
    currencies: json["currencies"] == null
        ? []
        : List<Currency>.from(
            json["currencies"].map((x) => Currency.fromJson(x)),
          ),
    borders: json["borders"] == null
        ? []
        : List<String>.from(json["borders"].map((x) => x)),
  );
}

class Names {
  final String? common;
  final String? official;
  // traducciones, la llave es el codigo del idioma, ej: "spa" para español
  final Map<String, Translation> translations;

  Names({this.common, this.official, required this.translations});

  factory Names.fromJson(Map<String, dynamic> json) => Names(
    common: json["common"],
    official: json["official"],
    translations: json["translations"] == null
        ? {}
        : Map.from(json["translations"]).map(
            (k, v) => MapEntry<String, Translation>(k, Translation.fromJson(v)),
          ),
  );
}

// en quicktype se llamaba Spa
class Translation {
  final String? common;
  final String? official;

  Translation({this.common, this.official});

  factory Translation.fromJson(Map<String, dynamic> json) =>
      Translation(common: json["common"], official: json["official"]);
}

class Codes {
  final String? alpha2;
  final String? alpha3;

  Codes({this.alpha2, this.alpha3});

  factory Codes.fromJson(Map<String, dynamic> json) =>
      Codes(alpha2: json["alpha_2"], alpha3: json["alpha_3"]);
}

class Capital {
  final String? name;

  Capital({this.name});

  factory Capital.fromJson(Map<String, dynamic> json) =>
      Capital(name: json["name"]);
}

class Flag {
  final String? emoji;
  final String? urlPng;
  final String? urlSvg;

  Flag({this.emoji, this.urlPng, this.urlSvg});

  factory Flag.fromJson(Map<String, dynamic> json) => Flag(
    emoji: json["emoji"],
    urlPng: json["url_png"],
    urlSvg: json["url_svg"],
  );
}

class Area {
  final double? kilometers;

  Area({this.kilometers});

  // lo paso a double porque a veces llega como int y a veces con decimales
  factory Area.fromJson(Map<String, dynamic> json) =>
      Area(kilometers: (json["kilometers"] as num?)?.toDouble());
}

class Language {
  final String? name;
  final String? nativeName;

  Language({this.name, this.nativeName});

  factory Language.fromJson(Map<String, dynamic> json) =>
      Language(name: json["name"], nativeName: json["native_name"]);
}

class Currency {
  final String? code;
  final String? name;
  final String? symbol;

  Currency({this.code, this.name, this.symbol});

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    code: json["code"],
    name: json["name"],
    symbol: json["symbol"],
  );
}
