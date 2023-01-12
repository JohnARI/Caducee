import 'package:caducee/models/category.dart';
import 'package:caducee/services/database.dart';
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

  List<Category> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    final dbService = DatabaseService(uid: '');
    dbService.getCategories().then((categories) {
      setState(() {
        _filteredCategories = categories;
      });
    });
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
        title: tabSearchBar((val) {
          setState(() {
            _filterCategories(val);
          });
        }, _nameController, "Rechercher une catégorie"),
      ),
      body: _filteredCategories.isEmpty && _nameController.text.length >= 2
          ? Center(
              child: Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? "assets/images/no_categories_dark.png"
                    : "assets/images/no_categories_light.png",
                height: 200,
              ),
            )
          : _filteredCategories.isEmpty && _nameController.text.isEmpty
              ? Center(
                  child: Image.asset(
                    "assets/images/loader.gif",
                    height: 150,
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => Container(),
                  itemCount: _filteredCategories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(category: _filteredCategories[index]);
                  }),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({super.key, required this.category});
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            offset: const Offset(-6, -6),
            blurRadius: 20,
          ),
          myBoxShadow2,
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
          iconColor: myGreen,
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
          title: ListTile(
            title: Text(
              category.name,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          children: [
            Container(
              margin:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: Text(
                category.description,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 7.0, right: 3.0),
                  child: Text(
                    "Voir les médicaments",
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.0, bottom: 8.0),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: myGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
