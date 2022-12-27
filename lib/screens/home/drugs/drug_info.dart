// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'package:caducee/common/const.dart';
import 'package:caducee/models/drug.dart';
import 'package:flutter/material.dart';

class DrugInfoPage extends StatefulWidget {
  final AppDrugData drug;

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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: myGreen),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Center(child: Text(widget.drug.name, style: const TextStyle(color: myGreen))),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 16.0),
                Text(widget.drug.name, style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 16.0),
                Text(widget.drug.longDesc, style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: 16.0),
                Text(widget.drug.shortDesc, style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 16.0),
                Text(widget.drug.category, style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 16.0),
                for (var i = 0; i < widget.drug.dosage.length; i++) 
                  Text(widget.drug.dosage[i], style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 16.0),
                for (var i = 0; i < widget.drug.brand.length; i++) 
                  Text(widget.drug.brand[i], style: Theme.of(context).textTheme.bodyText1),
                // Text(widget.drug.category.toString(), style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
        );
      }

  }
}
