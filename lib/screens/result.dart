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
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Résultat",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  child: Column(
                    children: [
                      Text(
                        response,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: const [
                Icon(Icons.warning, color: Colors.red, size: 30.0),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Attention, ce texte à été généré par une intelligence artificielle, ne vous fiez pas à ce texte pour prendre une décision médicale. Consultez toujours un médecin en cas de doute.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
