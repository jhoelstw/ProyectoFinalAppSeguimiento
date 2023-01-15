import 'package:app_seguimiento/domain/entitites/entregable.dart';
import 'package:flutter/material.dart';

class WEntregableCard extends StatelessWidget {
  final Entregable entregable;
  final VoidCallback onDelete;
  final bool deleteOption;

  const WEntregableCard({
    required this.entregable,
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
                    entregable.codigo,
                    style: const TextStyle(fontSize: 25),
                  ),
                  deleteOption? IconButton(onPressed: onDelete, icon: const Icon(Icons.close)):Container(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 350,
                    child: Text(
                      entregable.titulo,
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                ],
              ),
              const Divider(thickness: 3,),
              Text(
                'Responsable: ${entregable.responsable}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Fecha de entrega: ${entregable.fechaDeEntrega}',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Detalles: ${entregable.detalles}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
