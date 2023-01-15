import 'package:app_seguimiento/domain/entitites/entregable.dart';
import 'package:app_seguimiento/infrastructure/controllers/c_entregable.dart';


// C: CREATE
Future insertEntregableEntity({required Entregable entregable}) async {
  await insertEntregable(json: entregable.toJson());
}

// R: READ
Future<Entregable> getEntregableEntity({required String codigo}) async {
  return Entregable.fromJson(await getEntregable(codigo: codigo));
}
Future<List<Entregable>> getEntregablesEntity() async {
  return (await getEntregables()).map((e) => Entregable.fromJson(e)).toList();
}

// U: UPDATE
Future updateEntregableEntity({required String codigo, required String field, required String newValue}) async {
  await updateEntregable(codigo: codigo, field: field, newValue: newValue);
}

Future updateEntregableEstadoEntity({required String codigo, required bool newValue}) async {
  await updateEntregableEstado(codigo: codigo, newValue: newValue);
}

// D: DELETE
Future deleteEntregableEntity({required String codigo}) async {
  await deleteEntregable(codigo: codigo);
}


// ENTREGABLES DEL USUARIO ACTUAL
/*Future<List<Entregable>> getTareasEntity({required String codigoUsuario}) async {
  return (await getTareas(codigoUsuario: codigoUsuario)).map((e) => Entregable.fromJson(e)).toList();
}*/