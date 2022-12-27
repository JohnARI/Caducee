// ignore_for_file: depend_on_referenced_packages
import 'package:caducee/common/const.dart';
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

  late List<AppDrugData> _filteredDrugs;

  @override
  void initState() {
    super.initState();
    _filteredDrugs = context.read<List<AppDrugData>>();
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
            padding: const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
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
