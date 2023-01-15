import 'package:caducee/common/const.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.response});
  final String response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: myGreen, size: 30.0),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Maladie potentielle', style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Text(response, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),
        ),
      ),
    );
  }
}
