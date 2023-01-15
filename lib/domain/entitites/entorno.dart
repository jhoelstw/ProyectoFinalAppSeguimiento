class Entorno {
  String? _codigo;
  String? _codLider;
  Entorno({required String codigo, required String codLider}) {
    _codigo = codigo;
    _codLider = codLider;
  }
  get codigo => _codigo;
  set codigo(value) => _codigo = value;
  get codLider => _codLider;
  set codLider(value) => _codLider = value;
  Map<String, dynamic> toJson() {
    return {'codigo': _codigo, 'codLider': _codLider};
  }

  static Entorno fromJson(Map<String, dynamic> json) {
    return Entorno(codigo: json['codigo'], codLider: json['codLider']);
  }

  @override
  String toString() {
    return 'Entorno(_codigo: $_codigo, _codLider: $_codLider)';
  }
}



