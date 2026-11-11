import 'package:flutter/material.dart';
import 'package:trakto_route_flutter/app/navigation/home_screen.dart';
import 'package:trakto_route_flutter/core/theme/trakto_theme.dart';

class TraktoApp extends StatelessWidget {
  const TraktoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Trakto Route',
    debugShowCheckedModeBanner: false,
    theme: traktoTheme(Brightness.light),
    darkTheme: traktoTheme(Brightness.dark),
    home: const HomeScreen(),
  );
}
