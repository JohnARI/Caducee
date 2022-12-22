// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caducee/common/loading.dart';
import 'package:caducee/screens/home/drug_info.dart';

class DrugList extends StatefulWidget {
  const DrugList({super.key});

  @override
  State<DrugList> createState() => _DrugListState();
}

class _DrugListState extends State<DrugList> {
  CollectionReference drugs = FirebaseFirestore.instance.collection('drugs');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: drugs.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Une erreur est survenue');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrugInfoPage(drug: data),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['shortDesc']),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}