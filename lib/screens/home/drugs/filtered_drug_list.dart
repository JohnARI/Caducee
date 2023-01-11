import 'package:caducee/common/const.dart';
import 'package:caducee/models/drug.dart';
import 'package:caducee/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FilteredDrugList extends StatefulWidget {
  final String categoryName;
  const FilteredDrugList({super.key, required this.categoryName});

  @override
  State<FilteredDrugList> createState() => _FilteredDrugListState();
}

class _FilteredDrugListState extends State<FilteredDrugList> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    final drugs = Provider.of<List<AppDrugData>>(context);
    final filteredDrugs =
        drugs.where((drug) => drug.category == widget.categoryName).toList();

    if (filteredDrugs.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: myTransparent,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: myGreen, size: 30.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // search bar
          title: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0),
              child: TextField(
                autocorrect: false,
                decoration: const InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.search,
                  color: myGreen,
                  size: 30,
                ),
              ),
                onChanged: (val) {
                  setState(() {
                    name = val.toLowerCase();
                  });
                },
              ),
            ),
          ),
        ),
        body: Center(
          child: Image.asset("assets/images/no_drugs_in_categories.png", height: 200),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: myTransparent,
          elevation: 0.0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: myGreen, size: 30.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // search bar
          title: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0),
              child: TextField(
                autocorrect: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: myGreen,
                    size: 30,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: myGreen),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    name = val.toLowerCase();
                  });
                },
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: Text(
                widget.categoryName,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  itemCount: filteredDrugs.length,
                  itemBuilder: (context, index) {
                    if (name.isNotEmpty) {
                      if (filteredDrugs[index]
                          .name
                          .toLowerCase()
                          .contains(name)) {
                        return DrugTile(drug: filteredDrugs[index]);
                      } else {
                        return const SizedBox();
                      }
                    }
                    return DrugTile(drug: filteredDrugs[index]);
                  },
                ),
              ),
            ),
          ],
        ));
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
    return drugTile(context, widget.drug, isFavorite, toggleFavorite, addToFavorites, removeFromFavorites);
  }
}
