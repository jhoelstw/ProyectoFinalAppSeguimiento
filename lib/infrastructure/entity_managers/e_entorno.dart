import 'package:app_seguimiento/domain/entitites/entorno.dart';
import 'package:app_seguimiento/domain/entitites/entregable.dart';
import 'package:app_seguimiento/domain/entitites/reunion.dart';
import 'package:app_seguimiento/domain/entitites/usuario.dart';
import 'package:app_seguimiento/infrastructure/controllers/c_entorno.dart';

// C: CREATE
Future insertEntornoEntity({required Entorno entorno}) async {
  await insertEntorno(json: entorno.toJson());
}

// R: READ
Future<Entorno> getEntornoEntity({required String codigo}) async {
  return Entorno.fromJson(await getEntorno(codigo: codigo));
}

Future<List<Entorno>> getEntornosEntity() async {
  return (await getEntornos()).map((e) => Entorno.fromJson(e)).toList();
}

// U: UPDATE
Future updateEntornoEntity(
    {required String codigo,
    required String field,
    required String newValue}) async {
  await updateEntorno(codigo: codigo, field: field, newValue: newValue);
}

// D: DELETE
Future deleteEntornoEntity({required String codigo}) async {
  await deleteEntorno(codigo: codigo);
}

Future deleteEntornoColaboradorEntity({required String entornoCodigo, required String colaboradorCodigo}) async {
  await deleteEntornoColaborador(entornoCodigo: entornoCodigo, colaboradorCodigo: colaboradorCodigo);
}
Future deleteEntornoReunionEntity({required String entornoCodigo, required String reunionCodigo}) async {
  await deleteEntornoReunion(entornoCodigo: entornoCodigo, reunionCodigo: reunionCodigo);
}
Future deleteEntornoEntregableEntity({required String entornoCodigo, required String entregableCodigo}) async {
  await deleteEntornoEntregable(entornoCodigo: entornoCodigo, entregableCodigo: entregableCodigo);
}

// TABLAS INTERMEDIAS

// Reading:
Future<List<Usuario>> getEntornoColaboradoresEntity(
    {required String codigo}) async {
  return (await getEntornoColaboradores(codigo: codigo))
      .map((e) => Usuario.fromJson(e))
      .toList();
}

Future<List<Reunion>> getEntornoReunionesEntity(
    {required String codigo}) async {
  return (await getEntornoReuniones(codigo: codigo))
      .map((e) => Reunion.fromJson(e))
      .toList();
}

Future<List<Entregable>> getEntornoEntregablesEntity(
    {required String codigo}) async {
  return (await getEntornoEntregables(codigo: codigo))
      .map((e) => Entregable.fromJson(e))
      .toList();
}

Future<List<Entregable>> getEntornoTareasEntity({required String entornoCodigo, required String usuarioCodigo}) async {
  return (await getEntornoEntregablesEntity(codigo: entornoCodigo)).where((Entregable e) => e.responsable == usuarioCodigo).toList();
}


// Writing:
Future addEntornoColaboradorEntity({
  required Usuario usuario,
  required String codigo,
}) async {
  addEntornoColaborador(json: usuario.toJson(), codigo: codigo);
}

Future addEntornoReunionEntity({
  required Reunion reunion,
  required String codigo,
}) async {
  addEntornoReunion(json: reunion.toJson(), codigo: codigo);
}

Future addEntornoEntregableEntity({
  required Entregable entregable,
  required String codigo,
}) async {
  addEntornoEntregable(json: entregable.toJson(), codigo: codigo);
}
