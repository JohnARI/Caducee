// ignore_for_file: avoid_print

import 'package:caducee/components/appbar.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../services/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<AppUserData>>.value(
        value: DatabaseService(uid: '').users,
        initialData: const [],
        child: const MyAppBar());
  }
}
