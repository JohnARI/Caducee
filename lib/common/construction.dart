import 'package:flutter/material.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Theme.of(context).brightness == Brightness.dark
          ? Image.asset('assets/images/construction_dark.gif', width: 300, height: 300)
          : Image.asset('assets/images/construction_light.gif', width: 300, height: 300),
    );
  }
}