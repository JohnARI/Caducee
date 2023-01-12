import 'package:adaptive_theme/adaptive_theme.dart';
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
        actions: [
          IconButton(
    icon: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
        ? const Icon(Icons.dark_mode_outlined, color: myGreen)
        : const Icon(Icons.light_mode_outlined, color: myGreen),
    onPressed: () {
        setState(() {
            
        });
        AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
            ? AdaptiveTheme.of(context).setDark()
            : AdaptiveTheme.of(context).setLight();
    },
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