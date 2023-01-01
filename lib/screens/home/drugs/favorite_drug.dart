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
        title: SizedBox(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
            child: TextField(
              autocorrect: false,
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
