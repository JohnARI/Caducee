import 'package:caducee/common/const.dart';
import 'package:caducee/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:caducee/models/drug.dart';
import 'package:flutter/material.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  final _nameController = TextEditingController();

  List<AppDrugData> _favorites = [];
  List<AppDrugData> _originalFavorites = [];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DatabaseService(uid: user.uid).favoriteDrugs.listen((favorites) {
        if (mounted) {
          setState(() {
            _favorites = favorites;
            _originalFavorites = favorites;
          });
        }
      });
    }
  }

  void _favoriteDrugs(String query) {
    final filtered = _originalFavorites.where((drug) {
      return drug.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _favorites = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: tabSearchBar((val) {
          setState(() {
            _favoriteDrugs(val);
          });
        }, _nameController, "Rechercher un médicament"),
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? "assets/images/no_favorites_dark.gif"
                    : "assets/images/no_favorites_light.gif",
              height: 250,
            ))
          : ListView.separated(
              separatorBuilder: (context, index) => Container(),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                return FavoriteListTile(drug: _favorites[index]);
              },
            ),
    );
  }
}

class FavoriteListTile extends StatefulWidget {
  const FavoriteListTile({super.key, required this.drug});
  final AppDrugData drug;

  @override
  FavoriteListTileState createState() => FavoriteListTileState();
}

class FavoriteListTileState extends State<FavoriteListTile> {
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
      if (isFavorite) {
        removeFromFavorites(widget.drug);
      } else {
        addToFavorites(widget.drug);
      }
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
