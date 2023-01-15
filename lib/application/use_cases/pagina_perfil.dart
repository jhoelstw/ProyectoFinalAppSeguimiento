import 'package:app_seguimiento/variables_globales.dart';
import 'package:app_seguimiento/widgets/w_text_display.dart';
import 'package:flutter/material.dart';


class PaginaPerfil extends StatelessWidget {
  const PaginaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        WTextDisplay(title: 'Codigo', value: Global.usuario!.codigo),
        WTextDisplay(title: 'Nombres', value: Global.usuario!.nombre),
        WTextDisplay(title: 'Apellidos', value: Global.usuario!.apellidos),
        WTextDisplay(title: 'Celular', value: Global.usuario!.celular),
      ],
    );
  }
}