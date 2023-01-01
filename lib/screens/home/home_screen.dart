
import 'package:caducee/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../services/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<AppUserData>>.value(
        value: DatabaseService(uid: '').users,
        initialData: const [],
        child: const MyAppBar());
  }
}
