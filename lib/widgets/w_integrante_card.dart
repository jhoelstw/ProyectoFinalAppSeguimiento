import 'package:app_seguimiento/domain/entitites/usuario.dart';
import 'package:flutter/material.dart';

class WIntegranteCard extends StatelessWidget {
  final Usuario usuario;
  final VoidCallback onDelete;
  final bool deleteOption;

  const WIntegranteCard({
    required this.usuario,
    required this.onDelete,
    required this.deleteOption,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    usuario.codigo,
                    style: const TextStyle(fontSize: 25),
                  ),
                  deleteOption? IconButton(onPressed: onDelete, icon: const Icon(Icons.close)):Container(),
                ],
              ),
              Row(
                children: [
                  Text(
                    usuario.nombre,
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              const Divider(thickness: 3,),
              Text(
                'Apellidos: ${usuario.apellidos}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Email: ${usuario.email}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Celular: ${usuario.celular}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
