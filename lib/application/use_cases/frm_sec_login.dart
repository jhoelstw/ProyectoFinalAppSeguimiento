import 'package:app_seguimiento/application/use_cases/frm_sec_create.dart';
import 'package:app_seguimiento/application/use_cases/pantalla_principal.dart';
import 'package:app_seguimiento/domain/entitites/entorno.dart';
import 'package:app_seguimiento/domain/entitites/usuario.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_entorno.dart';
import 'package:app_seguimiento/infrastructure/entity_managers/e_usuario.dart';
import 'package:app_seguimiento/variables_globales.dart';
import 'package:app_seguimiento/widgets/w_text_button.dart';
import 'package:app_seguimiento/widgets/w_text_field.dart';
import 'package:flutter/material.dart';

class FrmSecLogin extends StatelessWidget {
  final TextEditingController codigoDeUsuario = TextEditingController();
  final TextEditingController codigoDeEntorno = TextEditingController();

  FrmSecLogin({Key? key}) : super(key: key);

  // SUBRUTINAS
  Future<bool> autenticar() async {
    if(codigoDeUsuario.text.isEmpty) return false;
    if(codigoDeEntorno.text.isEmpty) return false;

    Entorno entorno = await getEntornoEntity(codigo: codigoDeEntorno.text);
    Usuario usuario = await getUsuarioEntity(codigo: codigoDeUsuario.text);
    
    if (entorno.codLider.toString() == usuario.codigo.toString()) {
      Global.esLider = true;
    } else {
      Global.esLider = false;
    }
    Global.codUsuario = codigoDeUsuario.text;
    Global.codEntorno = codigoDeEntorno.text;
    Global.entorno = entorno;
    Global.usuario = usuario;
    return true;
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
                  'Iniciar Sesión',
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
                  controller: codigoDeUsuario,
                  labelText: 'Codigo de Usuario',
                  icon: Icons.key,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await autenticar().then(
                        (value) => value? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PantallaPrincipal(),
                          ),
                        ): null
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child: Text('Ingresar', style: TextStyle(fontSize: 20),),
                    ),
                  ),
                ),
                WTextButton(
                  leadingText: '¿Nuevo entorno?',
                  buttonText: 'Crear entorno',
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => FrmSecCreate()));
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
