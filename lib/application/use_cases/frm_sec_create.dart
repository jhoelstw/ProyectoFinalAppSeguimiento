import 'package:app_seguimiento/application/use_cases/frm_sec_login.dart';
import 'package:app_seguimiento/application/use_cases/pantalla_principal.dart';
import 'package:app_seguimiento/domain/entitites/entorno.dart';
import 'package:app_seguimiento/domain/entitites/usuario.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_entorno.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_usuario.dart';
import 'package:app_seguimiento/variables_globales.dart';
import 'package:app_seguimiento/widgets/w_text_button.dart';
import 'package:app_seguimiento/widgets/w_text_field.dart';
import 'package:flutter/material.dart';

class FrmSecCreate extends StatelessWidget {
  final TextEditingController codigoDeEntorno = TextEditingController();
  final TextEditingController codigoDeLider = TextEditingController();
  final TextEditingController nombres = TextEditingController();
  final TextEditingController apellidos = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController celular = TextEditingController();

  FrmSecCreate({Key? key}) : super(key: key);

  // SUBRUTINAS
  Future<bool> autenticar() async {
    if(codigoDeEntorno.text.isEmpty) return false;
    if(codigoDeLider.text.isEmpty) return false;
    if(nombres.text.isEmpty) return false;
    if(apellidos.text.isEmpty) return false;
    if(email.text.isEmpty) return false;
    if(celular.text.isEmpty) return false;
    debugPrint('Todo ok');
    Entorno entorno = await getEntornoEntity(codigo: codigoDeEntorno.text);
    Usuario usuario = await getUsuarioEntity(codigo: codigoDeLider.text);
    if (entorno.codLider.toString() == usuario.codigo.toString()) {
      Global.esLider = true;
    } else {
      Global.esLider = false;
    }
    Global.codUsuario = codigoDeLider.text;
    Global.codEntorno = codigoDeEntorno.text;
    Global.entorno = entorno;
    Global.usuario = usuario;
    return true;
  }

  Future<void> crear() async {
    if(codigoDeEntorno.text.isEmpty) return;
    if(codigoDeLider.text.isEmpty) return;
    if(nombres.text.isEmpty) return;
    if(apellidos.text.isEmpty) return;
    if(email.text.isEmpty) return;
    if(celular.text.isEmpty) return;
    debugPrint('Todo ok');
    await insertUsuarioEntity(
      usuario: Usuario(
        apellidos: apellidos.text,
        celular: celular.text,
        codigo: codigoDeLider.text,
        email: email.text,
        nombre: nombres.text,
      ),
    );
    await insertEntornoEntity(
      entorno: Entorno(
        codigo: codigoDeEntorno.text,
        codLider: codigoDeLider.text,
      ),
    );
  }

  // METODO BUILD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  'Seguimiento de Trabajo en Equipo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Crear entorno',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                WTextField(
                  textInputType: TextInputType.name,
                  controller: codigoDeEntorno,
                  labelText: 'Codigo de Entorno',
                  icon: Icons.key,
                ),
                WTextField(
                  textInputType: TextInputType.name,
                  controller: codigoDeLider,
                  labelText: 'Codigo de Lider',
                  icon: Icons.key,
                ),
                WTextField(
                  textInputType: TextInputType.name,
                  controller: nombres,
                  labelText: 'Nombres',
                  icon: Icons.person,
                ),
                WTextField(
                  textInputType: TextInputType.name,
                  controller: apellidos,
                  labelText: 'Apellidos',
                  icon: Icons.person,
                ),
                WTextField(
                  textInputType: TextInputType.emailAddress,
                  controller: email,
                  labelText: 'Email',
                  icon: Icons.email,
                ),
                WTextField(
                  textInputType: TextInputType.phone,
                  controller: celular,
                  labelText: 'Celular',
                  icon: Icons.phone,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await crear();
                      await autenticar().then(
                        (value) => value? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PantallaPrincipal(),
                          ),
                        ):null,
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child: Text(
                        'Crear',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                WTextButton(
                  leadingText: '¿Entorno existente?',
                  buttonText: 'Iniciar sesión',
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => FrmSecLogin()));
                  },
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
