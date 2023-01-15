import 'package:app_seguimiento/domain/entitites/entregable.dart';
import 'package:flutter/material.dart';


class WTareaCard extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final Entregable entregable;

  const WTareaCard({
    super.key,
    required this.value,
    required this.onChanged,
    required this.entregable,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Actividad',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                Switch(value: value, onChanged: onChanged)
              ],
            ),
            Text(
              entregable.titulo,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              thickness: 5.0,
              height: 30,
            ),
            Text(
              'Responsable: ${entregable.responsable}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'Fecha Final: ${entregable.fechaDeEntrega}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              'Detalles: ${entregable.detalles}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}