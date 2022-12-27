// ignore_for_file: depend_on_referenced_packages
import 'package:caducee/common/const.dart';
import 'package:caducee/models/drug.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caducee/screens/home/drugs/drug_info.dart';

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
          backgroundColor: Colors.transparent,
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
                    name = val;
                  });
                },
              ),
            ),
          ),
        ),
        body: const Center(
          child: Text(
              'Il n\'y a pas de médicament dans cette catégorie pour le moment'),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
                    if (widget.categoryName == 'All') {
                      return const InkWell();
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

class DrugTile extends StatelessWidget {
  const DrugTile({super.key, required this.drug});
  final AppDrugData drug;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DrugInfoPage(drug: drug),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
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
              drug.name,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              drug.shortDesc,
              style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.bookmark_border,
                  color: myDarkGreen, size: 32.0),
              onPressed: () {},
            ),
          ),
        ));
  }
}
