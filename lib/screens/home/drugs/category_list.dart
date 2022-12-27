// ignore_for_file: depend_on_referenced_packages
import 'package:caducee/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caducee/common/const.dart';

import 'drug_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key, required this.name});
  final String name;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          if (widget.name != '') {
            if (categories[index].name.toString().toLowerCase().contains(widget.name)) {
              return CategoryTile(category: categories[index]);
            } else {
              return Container();
            }
          }
          return CategoryTile(category: categories[index]);
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
    return InkWell(
      onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DrugList(categoryName: category.name),
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
          contentPadding: const EdgeInsets.all(8.0),
          leading: Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: myGreen,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Center(
              child: Icon(
                Icons.local_hospital,
                color: Colors.white,
                size: 32.0,
              ),
            ),
          ),
        title: Text(
          category.name,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
        ),
      )
    );
  }
}


