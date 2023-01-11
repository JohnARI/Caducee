import 'package:caducee/common/const.dart';
import 'package:caducee/common/construction.dart';
import 'package:flutter/material.dart';

class Symptoms extends StatefulWidget {
  const Symptoms({super.key});

  @override
  State<Symptoms> createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Symptômes", style: TextStyle(color: myGreen)),
        backgroundColor: Colors.white,
      ),
      body: const UnderConstruction(),
    );
  }
}
