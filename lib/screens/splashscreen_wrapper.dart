import 'package:caducee/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:caducee/models/user.dart';

import 'home/home_screen.dart';


class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    // ignore: unnecessary_null_comparison
    if (user == null) {
      return const LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}
