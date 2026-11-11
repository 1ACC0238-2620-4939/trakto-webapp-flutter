import 'package:flutter/material.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/panel.dart';
import 'package:trakto_route_flutter/core/presentation/widgets/secondary_text.dart';

class EmptyPanel extends StatelessWidget {
  const EmptyPanel(this.title, this.detail, {super.key});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) =>
      Panel(title, children: [SecondaryText(detail)]);
}
