import 'package:flutter/material.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/trakto_page.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/empty_panel.dart';

class ProfilesScreen extends StatelessWidget {
  const ProfilesScreen({super.key});

  @override
  Widget build(BuildContext context) => const TraktoPage(
    'Perfiles',
    'Personas registradas que se pueden asociar a un conductor.',
    children: [
      OutlinedButton(onPressed: null, child: Text('Actualizar perfiles')),
      EmptyPanel(
        'Sin perfiles disponibles',
        'Los perfiles se consultan desde el backend.',
      ),
    ],
  );
}
