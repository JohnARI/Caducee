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
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            icon: const Icon(Icons.arrow_back, color: myGreen, size: 30.0),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10.0),
                Text(widget.drug.category,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2.0)),
                const SizedBox(height: 16.0),
                Text(widget.drug.name,
                    style: const TextStyle(
                        color: myDarkGreen,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    const Icon(Icons.warning_amber_rounded, color: Colors.red),
                    const SizedBox(width: 10.0),
                    Text(widget.drug.recommendation,
                        style: const TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                        )),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text('Utilisation:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10.0),
                Text(widget.drug.usage,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 20.0),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: myDarkGreen, width: 2.0))),
                  child: ExpansionTile(
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                    tilePadding: const EdgeInsets.symmetric(horizontal: 20.0),
                    initiallyExpanded: true,
                    title: const Text('Description',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(widget.drug.longDesc,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ],
                  ),
                ),
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: myDarkGreen, width: 2.0))),
                    child: ExpansionTile(
                      childrenPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      tilePadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      title: widget.drug.brand.length > 1
                          ? const Text('Les médicaments',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))
                          : const Text('Le medicament',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.drug.brand.length,
                          itemBuilder: (context, index) {
                            final isLast = index == widget.drug.brand.length - 1;
                            return Padding(
                              padding: isLast
                                  ? const EdgeInsets.only(bottom: 16.0)
                                  : const EdgeInsets.only(bottom: 0.0),
                              child: Text('-${widget.drug.brand[index]}',
                                  style: Theme.of(context).textTheme.bodyText2),
                            );
                          },
                        ),
                      ],
                    )),
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: myDarkGreen, width: 2.0))),
                    child: ExpansionTile(
                      childrenPadding:
                          const EdgeInsets.symmetric(horizontal: 20.0),
                      tilePadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      title: const Text('Posologie',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.drug.dosage.length,
                          itemBuilder: (context, index) {
                            final isLast = index == widget.drug.dosage.length - 1;
                            return Padding(
                              padding: isLast
                                  ? const EdgeInsets.only(bottom: 16.0)
                                  : const EdgeInsets.only(bottom: 4.0),
                              child: Text('-${widget.drug.dosage[index]}',
                                  style: Theme.of(context).textTheme.bodyText2),
                            );
                          },
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      );
    }
  }
}
