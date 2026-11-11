import 'package:flutter/material.dart';

void openScreen(BuildContext context, Widget body) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (context) => Scaffold(appBar: traktoBar(context), body: body),
    ),
  );
}

AppBar traktoBar(BuildContext context) => AppBar(
  title: const Text('Trakto Route'),
  leading: Navigator.of(context).canPop()
      ? BackButton(onPressed: () => Navigator.of(context).maybePop())
      : null,
);
