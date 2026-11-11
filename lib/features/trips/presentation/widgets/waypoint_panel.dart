import 'package:flutter/material.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/panel.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/field.dart';

class WaypointPanel extends StatelessWidget {
  const WaypointPanel(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final point = title.toLowerCase();
    const coordinates = TextInputType.numberWithOptions(
      decimal: true,
      signed: true,
    );
    return Panel(
      title,
      children: [
        Field('Dirección de $point'),
        Field('Latitud de $point', keyboardType: coordinates),
        Field('Longitud de $point', keyboardType: coordinates),
      ],
    );
  }
}
