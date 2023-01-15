class Entregable {
  String? _codigo, _titulo, _responsable, _fechaDeEntrega, _detalles;
  bool? _estado;

  Entregable({
    required String codigo,
    required String titulo,
    required String responsable,
    required String fechaDeEntrega,
    required String detalles,
    required bool estado,
  }) {
    _codigo = codigo;
    _titulo = titulo;
    _responsable = responsable;
    _fechaDeEntrega = fechaDeEntrega;
    _detalles = detalles;
    _estado = estado;
  }

  get codigo => _codigo;
  set codigo(value) => _codigo = value;
  get titulo => _titulo;
  set titulo(value) => _titulo = value;
  get responsable => _responsable;
  set responsable(value) => _responsable = value;
  get fechaDeEntrega => _fechaDeEntrega;
  set fechaDeEntrega(value) => _fechaDeEntrega = value;
  get detalles => _detalles;
  set detalles(value) => _detalles = value;
  get estado => _estado;
  set estado(value) => _estado = value;

  Map<String, dynamic> toJson() {
    return {
      'codigo': _codigo,
      'titulo': _titulo,
      'responsable': _responsable,
      'fechaDeEntrega': _fechaDeEntrega,
      'detalles': _detalles,
      'estado': _estado,
    };
  }

  static Entregable fromJson(Map<String, dynamic> json) {
    return Entregable(
      codigo: json['codigo'],
      titulo: json['titulo'],
      responsable: json['responsable'],
      fechaDeEntrega: json['fechaDeEntrega'],
      detalles: json['detalles'],
      estado: json['estado'],
    );
  }

  @override
  String toString() {
    return 'Entregable(_codigo: $_codigo, _titulo: $_titulo, _responsable: $_responsable, _fechaDeEntrega: $_fechaDeEntrega, _detalles: $_detalles, _estado: $_estado)';
  }
}
