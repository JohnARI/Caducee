import 'package:caducee/models/category.dart';
import 'package:caducee/models/drug.dart';
import 'package:caducee/models/user.dart';
import 'package:caducee/screens/splashscreen_wrapper.dart';
import 'package:caducee/services/authentication.dart';
import 'package:caducee/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.black);
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
        title: 'Caducée',
        debugShowCheckedModeBanner: false,
        home: const SplashScreenWrapper(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fr', 'FR'),
        ],
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        ),
        
      );
      
  }
}