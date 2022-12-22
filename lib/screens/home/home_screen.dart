import 'package:caducee/screens/home/user_list.dart';
import 'package:flutter/material.dart';
import 'package:caducee/services/authentication.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../services/database.dart';
import 'drug_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<AppUserData>>.value(
      value: DatabaseService(uid: '').users,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          title: const Text('Accueil'),
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: const Text(
                'Changer de nom',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.changeName('Bon toutou');
              },
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: const Text(
                'Déconnexion',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: [
               const UserList(),
               const DrugList(),
               ].elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
                     BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Utilisateurs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: 'Médicaments',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[900],
        onTap: _onItemTapped,
      ),
    ),
    );
  }
}
