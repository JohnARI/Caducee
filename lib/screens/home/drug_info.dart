// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'package:flutter/material.dart';

class DrugInfoPage extends StatefulWidget {
  final Map<String, dynamic> drug;

  const DrugInfoPage({Key? key, required this.drug}) : super(key: key);

  @override
  _DrugInfoPageState createState() => _DrugInfoPageState();
}

class _DrugInfoPageState extends State<DrugInfoPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.drug == null) {
      return const Scaffold(
        body: Center(
        child: Text('Aucun médicament trouvé'),
      ),
      );
    } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.drug['name']),
            backgroundColor: Colors.blueGrey,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16.0),
                Text(widget.drug['name']?.toString() ?? 'Une erreur est survenue lors de la récupération du nom.', style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 16.0),
                Text(widget.drug['longDesc']?.toString() ?? 'Une erreur est survenue lors de la récupération de la description.', style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: 16.0),
                Text(widget.drug['molecularFormula']?.toString() ?? 'Une erreur est survenue lors de la récupération de la formule brut.', style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 16.0),
                Text(widget.drug['utility']?.toString() ?? 'Une erreur est survenue lors de la récupération de l\'utilitée', style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 16.0),
                Text(widget.drug['timing']?.toString() ?? 'Une erreur est survenue lors de la récupération du timing.', style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
        );
      }

  }
}
