import 'package:caducee/models/category.dart';
import 'package:caducee/models/drug.dart';
import 'package:caducee/models/user.dart';
import 'package:caducee/screens/splashscreen_wrapper.dart';
import 'package:caducee/services/authentication.dart';
import 'package:caducee/services/database.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AppUser?>.value(
          value: AuthenticationService().user,
          initialData: null,
        ),
        StreamProvider<List<AppDrugData>>.value(
          value: DatabaseService(uid: '').drugs,
          initialData: const [],
        ),
        StreamProvider<List<Category>>.value(
          value: DatabaseService(uid: '').categories,
          initialData: const [],
        ),
      ],
      child: MaterialApp(
        title: 'Caducee',
        // routes: {
        //   '/allDrugs': (context) => allDrugs(),
        // },
        debugShowCheckedModeBanner: false,
        home: const SplashScreenWrapper(),
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        ),
        
      );
      
  }
}