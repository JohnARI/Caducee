import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:caducee/common/const.dart';
import 'package:caducee/components/appbar.dart';
import 'package:caducee/screens/profil.dart';
import 'package:caducee/screens/symptoms.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _page = 1;
  final screens = [
    const Symptoms(),
    const MyAppBar(),
    const MyProfil(),
  ];

  bool darkMode = false;
  dynamic savedThemeMode;

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  Future getCurrentTheme() async {
    savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      setState(() {
        darkMode = true;
      });
    } else {
      setState(() {
        darkMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        backgroundColor: myTransparent,
        color: myDarkGreen,
        buttonBackgroundColor: myPastelGreen,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        height: 65,
        index: _page,
        items: const [
          Icon(
            Icons.medical_services_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.person_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
