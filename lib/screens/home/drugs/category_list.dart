// ignore_for_file: depend_on_referenced_packages
import 'package:caducee/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caducee/common/const.dart';
import 'filtered_drug_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final _nameController = TextEditingController();

  late List<Category> _filteredCategories;

  @override
  void initState() {
    super.initState();
    _filteredCategories = context.read<List<Category>>();
  }

  void _filterCategories(String query) {
    final filtered = context.read<List<Category>>().where((category) {
      return category.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _filteredCategories = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
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
                  _filterCategories(val);
                },
              ),
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: _filteredCategories.length,
            itemBuilder: (context, index) {
              return CategoryTile(category: _filteredCategories[index]);
            },
          ),
      );
    
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: InkWell(
        onTap: () { 
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FilteredDrugList(categoryName: category.name),
            ),
          );
        },
        child: ExpansionTile(
          leading: SizedBox(
            width: 48.0,
            height: 48.0,
            child: Center(
              child: Text(
                category.name[0],
                style: const TextStyle(
                  fontSize: 24.0,
                  color: myGreen,
                ),
              ),
            ),
          ),
          collapsedTextColor: myDarkGreen,
          title: ListTile(
            title: Text(
              category.name,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ),
          children: [
            Container(
              margin:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Text(
                category.description,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
