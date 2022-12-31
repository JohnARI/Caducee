// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:caducee/common/const.dart';
import 'package:caducee/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:caducee/models/drug.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caducee/screens/home/drugs/drug_info.dart';

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
      return drug.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _filteredDrugs = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,

        // search bar
        title: SizedBox(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
            child: TextField(
              controller: _nameController,
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
                _filterDrugs(val);
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
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
  _DrugTileState createState() => _DrugTileState();
}

class _DrugTileState extends State<DrugTile> {
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
    final Icon bookmarkIcon = isFavorite
        ? const Icon(
            Icons.bookmark,
            color: myGreen,
            size: 30,
          )
        : const Icon(
            Icons.bookmark_border,
            color: myGreen,
            size: 30,
          );
    return Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            myBoxShadow,
            myBoxShadow2,
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DrugInfoPage(drug: widget.drug),
              ),
            );
          },
          child: ListTile(
            leading: const SizedBox(
              width: 48.0,
              height: 48.0,
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/iconLogo.png'),
                  height: 40.0,
                  width: 40.0,
                ),
              ),
            ),
            title: Text(
              widget.drug.name,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              widget.drug.shortDesc,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              ),
            ),
            trailing: IconButton(
              icon: bookmarkIcon,
              onPressed: () {
                if (isFavorite) {
                  removeFromFavorites(widget.drug);
                } else {
                  addToFavorites(widget.drug);
                }
                toggleFavorite();
              },
            ),
          ),
        ));
  }
}
