class Reunion {
  String? _codigo;
  String? _detalles;
  String? _fecha;
  String? _link;
  String? _titulo;

  Reunion({
    required String codigo,
    required String detalles,
    required String fecha,
    required String link,
    required String titulo,
  }) {
    _codigo = codigo;
    _detalles = detalles;
    _fecha = fecha;
    _link = link;
    _titulo = titulo;
  }

  get codigo => this._codigo;

  set codigo(value) => this._codigo = value;

  get detalles => this._detalles;

  set detalles(value) => this._detalles = value;

  get fecha => this._fecha;

  set fecha(value) => this._fecha = value;

  get link => this._link;

  set link(value) => this._link = value;

  get titulo => this._titulo;

  set titulo(value) => this._titulo = value;

  Map<String, dynamic> toJson() {
    return {
      'codigo': _codigo,
      'detalles': _detalles,
      'fecha': _fecha,
      'link': _link,
      'titulo': _titulo,
    };
  }

  static Reunion fromJson(Map<String, dynamic> json) {
    return Reunion(
      codigo: json['codigo'],
      detalles: json['detalles'],
      fecha: json['fecha'],
      link: json['link'],
      titulo: json['titulo'],
    );
  }

  @override
  String toString() {
    return 'Reunion(_codigo: $_codigo, _detalles: $_detalles, _fecha: $_fecha, _link: $_link, _titulo: $_titulo)';
  }
}
