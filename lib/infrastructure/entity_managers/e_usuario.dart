import 'package:app_seguimiento/domain/entitites/usuario.dart';
import 'package:app_seguimiento/infrastructure/controllers/c_usuario.dart';


// C: CREATE
Future insertUsuarioEntity({required Usuario usuario}) async {
  await insertUsuario(json: usuario.toJson());
}

// R: READ
Future<Usuario> getUsuarioEntity({required String codigo}) async {
  return Usuario.fromJson(await getUsuario(codigo: codigo));
}
Future<List<Usuario>> getUsuariosEntity() async {
  return (await getUsuarios()).map((e) => Usuario.fromJson(e)).toList();
}

// U: UPDATE
Future updateUsuarioEntity({required String codigo, required String field, required String newValue}) async {
  await updateUsuario(codigo: codigo, field: field, newValue: newValue);
}

// D: DELETE
Future deleteUsuarioEntity({required String codigo}) async {
  await deleteUsuario(codigo: codigo);
}