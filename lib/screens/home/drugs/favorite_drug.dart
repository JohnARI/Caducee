// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:caducee/common/const.dart';
import 'package:caducee/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:caducee/models/drug.dart';
import 'package:flutter/material.dart';
import 'package:caducee/screens/home/drugs/drug_info.dart';

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
    if (query.isEmpty) {
      setState(() {
        _favorites = _originalFavorites;
      });
    } else {
      final favorites = _favorites.where((drug) {
        return drug.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        _favorites = favorites;
      });
    }
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
                _favoriteDrugs(val);
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          if (_favorites.isEmpty) {
            return const Center(
              child: Text('Il n\'y a pas de médicaments favoris'),
            );
          }
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
  _FavoriteListTileState createState() => _FavoriteListTileState();
}

class _FavoriteListTileState extends State<FavoriteListTile> {
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
