import 'package:app_seguimiento/application/use_cases/frm_man_entregables.dart';
import 'package:app_seguimiento/application/use_cases/frm_man_integrantes.dart';
import 'package:app_seguimiento/application/use_cases/frm_man_reuniones.dart';
import 'package:app_seguimiento/widgets/w_inicio_list_tile.dart';
import 'package:flutter/material.dart';


class PaginaInicio extends StatelessWidget {
  const PaginaInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        WInicioListTile(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FrmManIntegrantes()));
          },
          title: 'Integrantes',
          icono: 'https://cdn-icons-png.flaticon.com/512/417/417771.png',
          descripcion: 'Agrega un nuevo integrante a tu equipo de trabajo',
        ),
        WInicioListTile(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FrmManReuniones()));
          },
          title: 'Reuniones',
          icono: 'https://cdn-icons-png.flaticon.com/512/4144/4144517.png',
          descripcion: 'Agrega un nuevo integrante a tu equipo de trabajo',
        ),
        WInicioListTile(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>FrmManEntregables()));
          },
          title: 'Entregables',
          icono: 'https://cdn-icons-png.flaticon.com/128/4047/4047598.png',
          descripcion: 'Agrega un nuevo integrante a tu equipo de trabajo',
        ),
      ],
    );
  }
}