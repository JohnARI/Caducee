import 'package:caducee/common/const.dart';
import 'package:caducee/common/construction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfil extends StatefulWidget {
  const MyProfil({super.key});

  @override
  State<MyProfil> createState() => _MyProfilState();
}

class _MyProfilState extends State<MyProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil', style: TextStyle(color: myGreen)), 
        backgroundColor: Colors.white,
        actions: [
          const Padding(
            padding: EdgeInsets.only(top: 17.0),
            child: Text('Déconnexion', style: TextStyle(color: Colors.black26)),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: myGreen),
            onPressed: () {
              final FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: const UnderConstruction(),
    );
  }
}