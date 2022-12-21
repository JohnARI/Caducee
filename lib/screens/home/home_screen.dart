import 'package:flutter/material.dart';
import 'package:caducee/services/authentication.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
               await _auth.signOut();
            },
          )
        ],
      ),
      body: const Center(
        child: Text('Accueil'),
      ),
    );
  }
}