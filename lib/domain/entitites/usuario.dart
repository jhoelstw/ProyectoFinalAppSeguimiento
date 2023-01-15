class Usuario {
  String? _apellidos, _celular, _codigo, _email, _nombre;

  Usuario({
    required String apellidos,
    required String celular,
    required String codigo,
    required String email,
    required String nombre,
  }) {
    _apellidos = apellidos;
    _celular = celular;
    _codigo = codigo;
    _email = email;
    _nombre = nombre;
  }

  get apellidos => _apellidos;
  set apellidos(value) => _apellidos = value;
  get celular => _celular;
  set celular(value) => _celular = value;
  get codigo => _codigo;
  set codigo(value) => _codigo = value;
  get email => _email;
  set email(value) => _email = value;
  get nombre => _nombre;
  set nombre(value) => _nombre = value;

  Map<String, dynamic> toJson() {
    return {
      'apellidos': _apellidos,
      'celular': _celular,
      'codigo': _codigo,
      'email': _email,
      'nombre': _nombre,
    };
  }
  static Usuario fromJson(Map<String, dynamic> json) {
    return Usuario(
      apellidos: json['apellidos'],
      celular: json['celular'],
      codigo: json['codigo'],
      email: json['email'],
      nombre: json['nombre'],
    );
  }
  @override
  String toString() {
    return 'Usuario(_apellidos: $_apellidos, _celular: $_celular, _codigo: $_codigo, _email: $_email, _nombre: $_nombre)';
  }
}
