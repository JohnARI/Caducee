import 'package:caducee/common/const.dart';
import 'package:caducee/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:caducee/models/drug.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrugList extends StatefulWidget {
  const DrugList({super.key});

  @override
  State<DrugList> createState() => _DrugListState();
}

class _DrugListState extends State<DrugList> {
  final _nameController = TextEditingController();

  List<AppDrugData> _filteredDrugs = [];

  @override
  void initState() {
    super.initState();
    final dbService = DatabaseService(uid: '');
    dbService.getDrugs().then((drugs) {
      setState(() {
        _filteredDrugs = drugs;
      });
    });
  }

  void _filterDrugs(String query) {
    final filtered = context.read<List<AppDrugData>>().where((drug) {
      return drug.name.toLowerCase().contains(query.toLowerCase()) ||
          drug.molecule.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _filteredDrugs = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: tabSearchBar((val) {
          setState(() {
            _filterDrugs(val);
          });
        }, _nameController, "Rechercher un médicament"),
      ),
      body: _filteredDrugs.isEmpty && _nameController.text.length >= 2
          ? Center(
              child: Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? "assets/images/no_drugs_dark.png"
                    : "assets/images/no_drugs_light.png",
                height: 200,
              ),
            )
          : _filteredDrugs.isEmpty && _nameController.text.isEmpty
            ? Center(
                child: Image.asset(
                  "assets/images/loader.gif",
                  height: 150,
                ),
            )
            : ListView.separated(
              separatorBuilder: (context, index) => Container(),
              itemCount: _filteredDrugs.length,
              itemBuilder: (context, index) {
                return DrugTile(drug: _filteredDrugs[index]);
              },
            ),
    );
  }
}

class DrugTile extends StatefulWidget {
  const DrugTile({super.key, required this.drug});
  final AppDrugData drug;

  @override
  DrugTileState createState() => DrugTileState();
}

class DrugTileState extends State<DrugTile> {
  final user = FirebaseAuth.instance.currentUser;
  late bool isFavorite;

  void addToFavorites(AppDrugData drug) async {
    await DatabaseService(uid: user!.uid).addDrugToFavorites(drug);
  }

  void removeFromFavorites(AppDrugData drug) async {
    await DatabaseService(uid: user!.uid).removeDrugFromFavorites(drug);
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  void initState() {
    super.initState();
    isFavorite = widget.drug.favorite.contains(user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return drugTile(context, widget.drug, isFavorite, toggleFavorite,
        addToFavorites, removeFromFavorites);
  }
}
